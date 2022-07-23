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
/*                                 codeseg.c                                 */
/*                                                                           */
/*                          Code segment structure                           */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2001-2011, Ullrich von Bassewitz                                      */
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



#include <string.h>
#include <ctype.h>

/* common */
#include "chartype.h"
#include "check.h"
#include "debugflag.h"
#include "global.h"
#include "hashfunc.h"
#include "strbuf.h"
#include "strutil.h"
#include "xmalloc.h"

/* cc65 */
#include "asmlabel.h"
#include "codeent.h"
#include "codeseg.h"
#include "datatype.h"
#include "error.h"
#include "global.h"
#include "ident.h"
#include "output.h"
#include "symentry.h"



/*****************************************************************************/
/*                             Helper functions                              */
/*****************************************************************************/



static void CS_PrintFunctionHeader (const CodeSeg* S)
/* Print a comment with the function signature to the output file */
{
}


static void CS_MoveLabelsToPool (CodeSeg* S, CodeEntry* E)
/* Move the labels of the code entry E to the label pool of the code segment */
{
    unsigned LabelCount = CE_GetLabelCount (E);
    while (LabelCount--) {
        CodeLabel* L = CE_GetLabel (E, LabelCount);
        L->Owner = 0;
        CollAppend (&S->Labels, L);
    }
    CollDeleteAll (&E->Labels);
}



static CodeLabel* CS_FindLabel (CodeSeg* S, const char* Name, unsigned Hash)
/* Find the label with the given name. Return the label or NULL if not found */
{
    /* Get the first hash chain entry */
    CodeLabel* L = S->LabelHash[Hash];

    /* Search the list */
    while (L) {
        if (strcmp (Name, L->Name) == 0) {
            /* Found */
            break;
        }
        L = L->Next;
    }
    return L;
}




/*****************************************************************************/
/*                    Functions for parsing instructions                     */
/*****************************************************************************/



static const char* SkipSpace (const char* S)
/* Skip white space and return an updated pointer */
{
    while (IsSpace (*S)) {
        ++S;
    }
    return S;
}



static const char* ReadToken (const char* L, const char* Term,
                              char* Buf, unsigned BufSize)
/* Read the next token into Buf, return the updated line pointer. The
** token is terminated by one of the characters given in term.
*/
{
    /* Read/copy the token */
    unsigned I = 0;
    unsigned ParenCount = 0;
    while (*L && (ParenCount > 0 || strchr (Term, *L) == 0)) {
        if (I < BufSize-1) {
            Buf[I] = *L;
        } else if (I == BufSize-1) {
            /* Cannot store this character, this is an input error (maybe
            ** identifier too long or similar).
            */
            Error ("ASM code error: syntax error");
        }
        ++I;
        if (*L == ')') {
            --ParenCount;
        } else if (*L == '(') {
            ++ParenCount;
        }
        ++L;
    }

    /* Terminate the buffer contents */
    Buf[I] = '\0';

    /* Return the updated line pointer */
    return L;
}





/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



CodeSeg* NewCodeSeg (const char* SegName, SymEntry* Func)
/* Create a new code segment, initialize and return it */
{
    unsigned I;
    const Type* RetType;

    /* Allocate memory */
    CodeSeg* S = xmalloc (sizeof (CodeSeg));

    /* Initialize the fields */
    S->SegName  = xstrdup (SegName);
    S->Func     = Func;
    InitCollection (&S->Entries);
    InitCollection (&S->Labels);
    for (I = 0; I < sizeof(S->LabelHash) / sizeof(S->LabelHash[0]); ++I) {
        S->LabelHash[I] = 0;
    }

    /* Copy the global optimization settings */
    S->Optimize       = (unsigned char) IS_Get (&Optimize);
    S->CodeSizeFactor = (unsigned) IS_Get (&CodeSizeFactor);

    /* Return the new struct */
    return S;
}



void CS_InsertEntry (CodeSeg* S, struct CodeEntry* E, unsigned Index)
/* Insert the code entry at the index given. Following code entries will be
** moved to slots with higher indices.
*/
{
    /* Insert the entry into the collection */
    CollInsert (&S->Entries, E, Index);
}


struct CodeEntry* CS_GetPrevEntry (CodeSeg* S, unsigned Index)
/* Get the code entry preceeding the one with the index Index. If there is no
** preceeding code entry, return NULL.
*/
{
    if (Index == 0) {
        /* This is the first entry */
        return 0;
    } else {
        /* Previous entry available */
        return CollAtUnchecked (&S->Entries, Index-1);
    }
}



struct CodeEntry* CS_GetNextEntry (CodeSeg* S, unsigned Index)
/* Get the code entry following the one with the index Index. If there is no
** following code entry, return NULL.
*/
{
    if (Index >= CollCount (&S->Entries)-1) {
        /* This is the last entry */
        return 0;
    } else {
        /* Code entries left */
        return CollAtUnchecked (&S->Entries, Index+1);
    }
}



int CS_GetEntries (CodeSeg* S, struct CodeEntry** List,
                   unsigned Start, unsigned Count)
/* Get Count code entries into List starting at index start. Return true if
** we got the lines, return false if not enough lines were available.
*/
{
    /* Check if enough entries are available */
    if (Start + Count > CollCount (&S->Entries)) {
        return 0;
    }

    /* Copy the entries */
    while (Count--) {
        *List++ = CollAtUnchecked (&S->Entries, Start++);
    }

    /* We have the entries */
    return 1;
}



unsigned CS_GetEntryIndex (CodeSeg* S, struct CodeEntry* E)
/* Return the index of a code entry */
{
    int Index = CollIndex (&S->Entries, E);
    CHECK (Index >= 0);
    return Index;
}



int CS_RangeHasLabel (CodeSeg* S, unsigned Start, unsigned Count)
/* Return true if any of the code entries in the given range has a label
** attached. If the code segment does not span the given range, check the
** possible span instead.
*/
{
    unsigned EntryCount = CS_GetEntryCount(S);

    /* Adjust count. We expect at least Start to be valid. */
    CHECK (Start < EntryCount);
    if (Start + Count > EntryCount) {
        Count = EntryCount - Start;
    }

    /* Check each entry. Since we have validated the index above, we may
    ** use the unchecked access function in the loop which is faster.
    */
    while (Count--) {
        const CodeEntry* E = CollAtUnchecked (&S->Entries, Start++);
        if (CE_HasLabel (E)) {
            return 1;
        }
    }

    /* No label in the complete range */
    return 0;
}



CodeLabel* CS_AddLabel (CodeSeg* S, const char* Name)
/* Add a code label for the next instruction to follow */
{
}




void CS_OutputPrologue (const CodeSeg* S)
/* If the given code segment is a code segment for a function, output the
** assembler prologue into the file. That is: Output a comment header, switch
** to the correct segment and enter the local function scope. If the code
** segment is global, do nothing.
*/
{
}



void CS_OutputEpilogue (const CodeSeg* S)
{
    /* Nothing to do for the 6803 assembler */
}



void CS_Output (CodeSeg* S)
/* Output the code segment data to the output file */
{
}




void CS_GenRegInfo (CodeSeg* S)
/* Generate register infos for all instructions */
{
}
