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
/*                                 asmcode.h                                 */
/*                                                                           */
/*          Assembler output code handling for the cc65 C compiler           */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2009, Ullrich von Bassewitz                                      */
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



#ifndef ASMCODE_H
#define ASMCODE_H



#include <stdio.h>

/* common */
#include "attrib.h"

/* cc68 */
#include "textlist.h"



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



/* Marker for an assembler code position */
typedef struct {
    TextList 	*Text;
    int         SP;             /* Stack pointer at this position */
    unsigned	X;		/* X state */
    unsigned	Movable;
} CodeMark;



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



void GetCodePos (CodeMark* M);
/* Get a marker pointing to the current output position */

void GetCodePosMovable (CodeMark* M);
/* Get a marker pointing to the current output position, and tell the
   code generator this block may be moved so must not assume state */

void RemoveCodeRange (const CodeMark* Start, const CodeMark* End);
/* Remove all code between two code markers */

void RemoveCode (const CodeMark* M);
/* Remove all code after the given code marker */

void MoveCode (const CodeMark* Start, const CodeMark* End, const CodeMark* Target);
/* Move the code between Start (inclusive) and End (exclusive) to
** (before) Target. The code marks aren't updated.
*/

int CodeRangeIsEmpty (const CodeMark* Start, const CodeMark* End);
/* Return true if the given code range is empty (no code between Start and End) */

void WriteAsmOutput (void);
/* Write the final assembler output to the output file */



/* End of asmcode.h */

#endif
