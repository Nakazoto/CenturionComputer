/*
 *	CC6303:  A C compiler for the 6803/6303 processors
 *	(C) 2019 Alan Cox
 *
 *	This compiler is built out of a much modified CC65 and all new code
 *	is placed under the same licence as the original. Please direct all
 *	cc6303 bugs to the author not to the cc65 developers unless you find
 *	a bug that is also present in cc65.
 */
/*****************************************************************************/
/*                                                                           */
/*                                function.c                                 */
/*                                                                           */
/*                      Parse function entry/body/exit                       */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2015, Ullrich von Bassewitz                                      */
/*                Roemerstrasse 52                                           */
/*                D-70794 Filderstadt                                        */
/* EMail:         uz@cc65.org                                                */
/*                                                                           */
/*                                                                           */
/* This software is provided 'as-is', without any expressed or implied       */
/* warranty.  In no event will the authors be held liable for any damages    */
/* arising from the use of this software.                                    */
/*                                                                           */
/* Permission is granted to anyone to use this software for any purpose,     */
/* including commercial applications, and to alter it and redistribute it    */
/* freely, subject to the following restrictions:                            */
/*                                                                           */
/* 1. The origin of this software must not be misrepresented; you must not   */
/*    claim that you wrote the original software. If you use this software   */
/*    in a product, an acknowledgment in the product documentation would be  */
/*    appreciated but is not required.                                       */
/* 2. Altered source versions must be plainly marked as such, and must not   */
/*    be misrepresented as being the original software.                      */
/* 3. This notice may not be removed or altered from any source              */
/*    distribution.                                                          */
/*                                                                           */
/*****************************************************************************/



/* common */
#include "check.h"
#include "xmalloc.h"

/* cc65 */
#include "asmcode.h"
#include "asmlabel.h"
#include "codegen.h"
#include "error.h"
#include "funcdesc.h"
#include "global.h"
#include "litpool.h"
#include "locals.h"
#include "scanner.h"
#include "stackptr.h"
#include "standard.h"
#include "stmt.h"
#include "symtab.h"
#include "function.h"



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



/* Pointer to current function */
Function* CurrentFunc = 0;



/*****************************************************************************/
/*                 Subroutines working with struct Function                  */
/*****************************************************************************/



static Function* NewFunction (struct SymEntry* Sym)
/* Create a new function activation structure and return it */
{
    /* Allocate a new structure */
    Function* F = (Function*) xmalloc (sizeof (Function));

    /* Initialize the fields */
    F->FuncEntry  = Sym;
    F->ReturnType = GetFuncReturn (Sym->Type);
    F->Desc       = GetFuncDesc (Sym->Type);
    F->Reserved   = 0;
    F->RetLab     = GetLocalLabel ();
    F->TopLevelSP = 0;
    F->RegOffs    = RegisterSpace;
    F->Flags      = IsTypeVoid (F->ReturnType) ? FF_VOID_RETURN : FF_NONE;

    InitCollection (&F->LocalsBlockStack);

    /* Return the new structure */
    return F;
}



static void FreeFunction (Function* F)
/* Free a function activation structure */
{
    DoneCollection (&F->LocalsBlockStack);
    xfree (F);
}



const char* F_GetFuncName (const Function* F)
/* Return the name of the current function */
{
    return F->FuncEntry->Name;
}



unsigned F_GetParamCount (const Function* F)
/* Return the parameter count for the current function */
{
    return F->Desc->ParamCount;
}



unsigned F_GetParamSize (const Function* F)
/* Return the parameter size for the current function */
{
    return F->Desc->ParamSize;
}



Type* F_GetReturnType (Function* F)
/* Get the return type for the function */
{
    return F->ReturnType;
}



int F_HasVoidReturn (const Function* F)
/* Return true if the function does not have a return value */
{
    return (F->Flags & FF_VOID_RETURN) != 0;
}



void F_ReturnFound (Function* F)
/* Mark the function as having a return statement */
{
    F->Flags |= FF_HAS_RETURN;
}



int F_HasReturn (const Function* F)
/* Return true if the function contains a return statement*/
{
    return (F->Flags & FF_HAS_RETURN) != 0;
}



int F_IsMainFunc (const Function* F)
/* Return true if this is the main function */
{
    return (F->Flags & FF_IS_MAIN) != 0;
}


int F_IsOldStyle (const Function* F)
/* Return true if this is an old style (K&R) function */
{
    return (F->Desc->Flags & FD_OLDSTYLE) != 0;
}



int F_HasOldStyleIntRet (const Function* F)
/* Return true if this is an old style (K&R) function with an implicit int return */
{
    return (F->Desc->Flags & FD_OLDSTYLE_INTRET) != 0;
}



unsigned F_GetRetLab (const Function* F)
/* Return the return jump label */
{
    return F->RetLab;
}



int F_GetTopLevelSP (const Function* F)
/* Get the value of the stack pointer on function top level */
{
    return F->TopLevelSP;
}



int F_ReserveLocalSpace (Function* F, unsigned Size)
/* Reserve (but don't allocate) the given local space and return the stack
** offset.
*/
{
    F->Reserved += Size;
    return StackPtr - F->Reserved;
}



int F_GetStackPtr (const Function* F)
/* Return the current stack pointer including reserved (but not allocated)
** space on the stack.
*/
{
    return StackPtr - F->Reserved;
}



void F_AllocLocalSpace (Function* F)
/* Allocate any local space previously reserved. The function will do
** nothing if there is no reserved local space.
*/
{
    if (F->Reserved > 0) {

        /* Create space on the stack */
        g_space (F->Reserved, 0);

        /* Correct the stack pointer */
        StackPtr -= F->Reserved;

        /* Nothing more reserved */
        F->Reserved = 0;
    }
}


void F_AdjustLocalSpace (Function* F)
/* Account for any pending local space, but do not generate code to create
   it as the code generator in the caller has created the space as a side
   effect of thits actions (currently initializing an array)
*/
{
    /* Correct the stack pointer */
    StackPtr -= F->Reserved;

    /* Nothing more reserved */
    F->Reserved = 0;
}



int F_AllocRegVar (Function* F, const Type* Type)
/* Allocate a register variable for the given variable type. If the allocation
** was successful, return the offset of the register variable in the register
** bank (zero page storage). If there is no register space left, return -1.
*/
{
    /* Allow register variables only on top level and if enabled */
    if (IS_Get (&EnableRegVars) && GetLexicalLevel () == LEX_LEVEL_FUNCTION) {

        /* Get the size of the variable */
        unsigned Size = CheckedSizeOf (Type);

        /* For now we don't handle register long */
        if (Size > 2)
            return -1;

        /* Do we have space left? */
        if (F->RegOffs >= Size) {
            /* Space left. We allocate the variables from high to low addresses,
            ** so the addressing is compatible with the saved values on stack.
            ** This allows shorter code when saving/restoring the variables.
            */
            F->RegOffs -= Size;
            return F->RegOffs;
        }
    }

    /* No space left or no allocation */
    return -1;
}



/* Also pop off any other stuff as we go for a clean exit path */
static void F_RestoreRegVars (Function* F)
/* Restore the register variables for the local function if there are any. */
{
    unsigned ByteTotal = 0;
    const SymEntry* Sym;

    /* Get the last symbol from the function symbol table */
    Sym = F->FuncEntry->V.F.Func->SymTab->SymTail;

    /* Walk through all symbols checking for register variables. Unlike cc65
       we don't want to batch them as we just stuff them all through X. Do
       them in reverse order so we can try and pop them nicely */

    /* FIXME: need to accumulate non regvar size */
    while (Sym) {
        if (SymIsRegVar (Sym)) {
            unsigned Bytes = CheckedSizeOf (Sym->Type);

            /* Check for more than one variable */
            /*int Offs       = Sym->V.R.SaveOffs; */
            /* Drop the accumulated uninteresting storage */
            if (ByteTotal) {
                g_drop(ByteTotal, F_HasReturn(CurrentFunc));
                StackPtr += ByteTotal;
                ByteTotal = 0;
            }
            /* Pop and restore the reg var */
            g_restore_regvar(0, Sym->V.R.RegOffs, Bytes);
        } else {
            /* Don't try and drop anything that's not a local auto variable */
            if (SymIsAuto (Sym) && !SymIsParam (Sym)) {
                unsigned Bytes = CheckedSizeOf (Sym->Type);
                /* Accumulate the space to drop */
                ByteTotal += Bytes;
            }
        }

        /* Check next symbol */
        Sym = Sym->PrevSym;
    }
    /* Drop any remaining uninteresting storage */
    if (ByteTotal) {
        g_drop(ByteTotal, F_HasReturn(CurrentFunc));
        StackPtr += ByteTotal;
    }
}



static void F_EmitDebugInfo (void)
/* Emit debug infos for the current function */
{
    if (DebugInfo) {
        /* Get the current function */
        const SymEntry* Sym = CurrentFunc->FuncEntry;

        /* Output info for the function itself */
        AddTextLine ("\t.dbg\tfunc, \"%s\", \"00\", %s, \"%s\"",
                     Sym->Name,
                     (Sym->Flags & SC_EXTERN)? "extern" : "static",
                     Sym->AsmName);
    }
}



/*****************************************************************************/
/*                                   code                                    */
/*****************************************************************************/



void NewFunc (SymEntry* Func)
/* Parse argument declarations and function body. */
{
    int         C99MainFunc = 0;/* Flag for C99 main function returning int */

    /* Get the function descriptor from the function entry */
    FuncDesc* D = Func->V.F.Func;


    SymEntry * Param;

    /* Allocate the function activation record for the function */
    CurrentFunc = NewFunction (Func);

    /* Reenter the lexical level */
    ReenterFunctionLevel (D);

    /* Check if the function header contains unnamed parameters. These are
    ** only allowed in cc65 mode.
    */
    if ((D->Flags & FD_UNNAMED_PARAMS) != 0 && (IS_Get (&Standard) != STD_CC68)) {
        Error ("Parameter name omitted");
    }

    /* Function body now defined */
    Func->Flags |= SC_DEF;

    /* Special handling for main() */
    if (strcmp (Func->Name, "main") == 0) {

        /* Mark this as the main function */
        CurrentFunc->Flags |= FF_IS_MAIN;

        /* If cc65 extensions aren't enabled, don't allow a main function that
        ** doesn't return an int.
-        */
        if (IS_Get (&Standard) != STD_CC68 && CurrentFunc->ReturnType[0].C != T_INT) {
            Error ("'main' must always return an int");
        }

        /* Determine if this is a main function in a C99 environment that
        ** returns an int.
        */
        if (IsTypeInt (F_GetReturnType (CurrentFunc)) &&
            IS_Get (&Standard) == STD_C99) {
            C99MainFunc = 1;
        }
    }
    /* Allocate code and data segments for this function */
    Func->V.F.Seg = PushSegments (Func);

    /* Allocate a new literal pool */
    PushLiteralPool (Func);

    /* Generate function entry code if needed */
    g_enter (Func->Name, TypeOf(Func->Type), F_GetParamSize(CurrentFunc));

    /* If stack checking code is requested, emit a call to the helper routine */
    if (IS_Get (&CheckStack)) {
        g_stackcheck ();
    }

    /* Setup the stack */
    StackPtr = 0;

    /* Walk through the parameter list and allocate register variable space
    ** for parameters declared as register. Generate code to swap the contents
    ** of the register bank with the save area on the stack.
    */
    Param = D->SymTab->SymHead;
    while (Param && (Param->Flags & SC_PARAM) != 0) {

        /* FIXME: Underlying bug here. CvRegVarToAuto wants to convert the
           vartiable back to auto type. However it is inconsistent about
           whether it saved the old state or not when returning -1
           When we turn this support on we need to update F_AllocRegVar
           to always save the value, and remove the ifdefs on CvRegVarToAuto
           so it gets put back */
        /* TODO: check if this is a CC65 bug and if so report it there */

        /* Check for a register variable */
        if (SymIsRegVar (Param)) {

            /* FIXME: This one is harder to do right */
            /* Allocate space */
            int Reg = -1; //FIXME F_AllocRegVar (CurrentFunc, Param->Type);

            /* Could we allocate a register? */
            if (Reg < 0) {
                /* No register available: Convert parameter to auto */
                CvtRegVarToAuto (Param);
            } else {
                /* Remember the register offset */
                Param->V.R.RegOffs = Reg;

                /* Generate swap code */
//FIXME         g_swap_regvars (Param->V.R.SaveOffs, Reg, CheckedSizeOf (Param->Type));
            }
        }

        /* Next parameter */
        Param = Param->NextSym;
    }

    /* Need a starting curly brace */
    ConsumeLCurly ();

    /* Make sure there is always something on the stack of local variable blocks */
    CollAppend (&CurrentFunc->LocalsBlockStack, 0);

    /* Parse local variable declarations if any */
    DeclareLocals ();

    /* Remember the current stack pointer. All variables allocated elsewhere
    ** must be dropped when doing a return from an inner block.
    */
    CurrentFunc->TopLevelSP = StackPtr;

    /* Now process statements in this block */
    while (CurTok.Tok != TOK_RCURLY && CurTok.Tok != TOK_CEOF) {
        Statement (0);
    }

    /* If this is not a void function, and not the main function in a C99
    ** environment returning int, output a warning if we didn't see a return
    ** statement.
    */
    if (!F_HasVoidReturn (CurrentFunc) && !F_HasReturn (CurrentFunc) && !C99MainFunc) {
         Warning ("Control reaches end of non-void function");
     }

    /* If this is the main function in a C99 environment returning an int, let
    ** it always return zero. Note: Actual return statements jump to the return
    ** label defined below.
    ** The code is removed by the optimizer if unused.
    */
    if (C99MainFunc) {
        g_getimmed (CF_INT | CF_CONST, 0, 0);
    }

    /* Output the function exit code label */
    g_defcodelabel (F_GetRetLab (CurrentFunc));

    /* Restore the register variables */
    /* FIXME: it would be better to combine this with any popping, so we
       roll the pulx stx into the recovery logic */
    F_RestoreRegVars (CurrentFunc);

    /* Generate the exit code */

    g_leave (F_HasVoidReturn (CurrentFunc), TypeOf(Func->Type), F_GetParamSize(CurrentFunc));

    /* Emit references to imports/exports */
    EmitExternals ();

    /* Emit function debug info */
    F_EmitDebugInfo ();
    EmitDebugInfo ();

    /* Leave the lexical level */
    LeaveFunctionLevel ();

    /* Eat the closing brace */
    ConsumeRCurly ();

    /* Restore the old literal pool, remembering the one for the function */
    Func->V.F.LitPool = PopLiteralPool ();

    /* Switch back to the old segments */
    PopSegments ();

    /* Reset the current function pointer */
    FreeFunction (CurrentFunc);
    CurrentFunc = 0;
}
