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
/*                                loadexpr.c                                 */
/*                                                                           */
/*               Load an expression into the primary register                */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2004-2009, Ullrich von Bassewitz                                      */
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



/* cc65 */
#include "codegen.h"
#include "error.h"
#include "exprdesc.h"
#include "global.h"
#include "loadexpr.h"
#include "cpu.h"



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



static void LoadConstant (unsigned Flags, ExprDesc* Expr)
/* Load the primary register with some constant value. */
{
    switch (ED_GetLoc (Expr)) {

        case E_LOC_ABS:
            /* Number constant */
            g_getimmed (Flags | TypeOf (Expr->Type) | CF_CONST, Expr->IVal, 0);
            break;

        case E_LOC_GLOBAL:
            /* Global symbol, load address */
            g_getimmed ((Flags | CF_EXTERNAL) & ~CF_CONST, Expr->Name, Expr->IVal);
            break;

        case E_LOC_STATIC:
        case E_LOC_LITERAL:
            /* Static symbol or literal, load address */
            g_getimmed ((Flags | CF_STATIC) & ~CF_CONST, Expr->Name, Expr->IVal);
            break;

        case E_LOC_REGISTER:
            /* Register variable. Taking the address is usually not
            ** allowed.
            */
            if (IS_Get (&AllowRegVarAddr) == 0) {
                Error ("Cannot take the address of a register variable");
            }
            g_getimmed ((Flags | CF_REGVAR) & ~CF_CONST, Expr->Name, Expr->IVal);
            break;

        case E_LOC_STACK:
            g_leasp (Flags, Expr->IVal);
            break;

        default:
            Internal ("Unknown constant type: %04X", Expr->Flags);
    }
}

/* See if we can load this value type into X: distinct from 'using' X as
   the input */
int CanLoadViaX(unsigned Flags, struct ExprDesc *Expr)
{
    /* The reality is more complicated but we almost never want to put
       something in X, and when do we can use the optimizer to fix it better
       than the compiler */
    if (ED_IsBitField(Expr) || ED_NeedsTest(Expr)) {
        return 0;
    }
    if ((Flags & CF_TYPEMASK) == CF_CHAR || (Flags & CF_FORCECHAR)) {
        return 0;
    }
    if (IsTypeChar(Expr->Type)) {
        //AddCodeLine("; target type char\n");
        return 0;
    }
    if (ED_IsLVal(Expr)) {
        /* Until we fix getloc to be a lot smarter */
        if (ED_GetLoc(Expr) == E_LOC_EXPR) {
            return 0;
        }
        return 1;
    }
    /* FIXME: we can do this for a small range of ival */
    if (ED_IsLocExpr(Expr)) {
        return 0;
    }
    /* Constant */
    return 1;
}

/* Load an expression into X */
void LoadExprX (unsigned Flags, struct ExprDesc* Expr)
{
    if (ED_IsLVal (Expr)) {

        /* Dereferenced lvalue. If this is a bit field its type is unsigned.
        ** But if the field is completely contained in the lower byte, we will
        ** throw away the high byte anyway and may therefore load just the
        ** low byte.
        */
        if (ED_IsBitField (Expr))
            Internal("BadXType");
        else
            Flags |= TypeOf (Expr->Type);

        if (ED_NeedsTest (Expr)) {
            Flags |= CF_TEST;
            Internal("BadXTest");
        }

        switch (ED_GetLoc (Expr)) {

            case E_LOC_ABS:
                /* Absolute: numeric address or const */
                g_getstatic (Flags | CF_USINGX | CF_ABSOLUTE, Expr->IVal, 0);
                break;

            case E_LOC_GLOBAL:
                /* Global variable */
                g_getstatic (Flags | CF_EXTERNAL | CF_USINGX , Expr->Name, Expr->IVal);
                break;

            case E_LOC_STATIC:
            case E_LOC_LITERAL:
                /* Static variable or literal in the literal pool */
                g_getstatic (Flags | CF_STATIC | CF_USINGX, Expr->Name, Expr->IVal);
                break;

            case E_LOC_REGISTER:
                /* Register variable */
                g_getstatic (Flags | CF_REGVAR | CF_USINGX, Expr->Name, Expr->IVal);
                break;

            case E_LOC_STACK:
                /* Value on the stack */
                g_getlocal_x (Flags , Expr->IVal);
                break;

            case E_LOC_PRIMARY:
                /* The primary register */
                if (!(Flags & CF_USINGX))
                    g_primary_to_x();
                break;

            case E_LOC_EXPR:
                /* Reference to address in primary with offset in Expr */
                g_getind (Flags, Expr->IVal);
                break;

            default:
                Internal ("Invalid location in XLoadExpr: 0x%04X", ED_GetLoc (Expr));
        }
    } else {
        /* An rvalue */
        if (ED_IsLocExpr (Expr)) {
            Internal("BadXLockExpr");
        } else {
            /* Constant of some sort, load it into the primary */
            LoadConstant (Flags | CF_USINGX, Expr);
        }
    }
}

void LoadExpr (unsigned Flags, struct ExprDesc* Expr)
/* Load an expression into the primary register if it is not already there. */
{
    if (ED_IsLVal (Expr)) {

        /* Dereferenced lvalue. If this is a bit field its type is unsigned.
        ** But if the field is completely contained in the lower byte, we will
        ** throw away the high byte anyway and may therefore load just the
        ** low byte.
        */
        if (ED_IsBitField (Expr)) {
            Flags |= (Expr->BitOffs + Expr->BitWidth <= CHAR_BITS)? CF_CHAR : CF_INT;
            Flags |= CF_UNSIGNED;
        } else {
            Flags |= TypeOf (Expr->Type);
        }
        if (ED_NeedsTest (Expr)) {
            Flags |= CF_TEST;
        }

        switch (ED_GetLoc (Expr)) {

            case E_LOC_ABS:
                /* Absolute: numeric address or const */
                g_getstatic (Flags | CF_ABSOLUTE, Expr->IVal, 0);
                break;

            case E_LOC_GLOBAL:
                /* Global variable */
                g_getstatic (Flags | CF_EXTERNAL, Expr->Name, Expr->IVal);
                break;

            case E_LOC_STATIC:
            case E_LOC_LITERAL:
                /* Static variable or literal in the literal pool */
                g_getstatic (Flags | CF_STATIC, Expr->Name, Expr->IVal);
                break;

            case E_LOC_REGISTER:
                /* Register variable */
                g_getstatic (Flags | CF_REGVAR, Expr->Name, Expr->IVal);
                break;

            case E_LOC_STACK:
                /* Value on the stack */
                g_getlocal (Flags, Expr->IVal);
                break;

            case E_LOC_PRIMARY:
                /* The primary register - just test if necessary */
                if (Flags & CF_TEST) {
                    g_test (Flags);
                }
                break;

            case E_LOC_EXPR:
            {
                int ch = 0;
                if (IsTypePtr(Expr->Type) && IsTypeChar(Indirect(Expr->Type)))
                    ch = 1;
                if (IsTypeChar(Expr->Type))
                    ch = 2;
                /* Reference to address in primary with offset in Expr */
//                AddCodeLine(";E_LOC_EXPR IVal %u Flags %u IsChar %d\n",
//                    Expr->IVal, Flags, ch);
                g_getind (Flags, Expr->IVal);
                }
                break;

            default:
                Internal ("Invalid location in LoadExpr: 0x%04X", ED_GetLoc (Expr));
        }

        /* Handle bit fields. The actual type may have been casted or
        ** converted, so be sure to always use unsigned ints for the
        ** operations.
        */
        if (ED_IsBitField (Expr)) {
            unsigned F = CF_INT | CF_UNSIGNED | CF_CONST | (Flags & CF_TEST);
            /* Shift right by the bit offset */
            g_asr (F, Expr->BitOffs);
            /* And by the width if the field doesn't end on an int boundary */
            if (Expr->BitOffs + Expr->BitWidth != CHAR_BITS &&
                Expr->BitOffs + Expr->BitWidth != INT_BITS) {
                g_and (F, (0x0001U << Expr->BitWidth) - 1U);
            }
        }

        /* Expression was tested */
        ED_TestDone (Expr);

    } else {
        /* An rvalue */
        if (ED_IsLocExpr (Expr)) {
            if (Expr->IVal != 0) {
                /* We have an expression in the primary plus a constant
                ** offset. Adjust the value in the primary accordingly.
                */
                Flags |= TypeOf (Expr->Type);
                g_inc (Flags | CF_CONST, Expr->IVal);
            }
        } else {
            /* Constant of some sort, load it into the primary */
            LoadConstant (Flags, Expr);
        }

        /* Are we testing this value? */
        if (ED_NeedsTest (Expr)) {
            /* Yes, force a test */
            Flags |= TypeOf (Expr->Type);
            g_test (Flags);
            ED_TestDone (Expr);
        }
    }

}
