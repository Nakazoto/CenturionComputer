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
/*                                intstack.c                                 */
/*                                                                           */
/*                  Integer stack used for program settings                  */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2004-2010, Ullrich von Bassewitz                                      */
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
#include "intstack.h"



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



long IS_Get (const IntStack* S)
/* Get the value on top of an int stack */
{
    PRECONDITION (S->Count > 0);
    return S->Stack[S->Count-1];
}



void IS_Set (IntStack* S, long Val)
/* Set the value on top of an int stack */
{
    PRECONDITION (S->Count > 0);
    S->Stack[S->Count-1] = Val;
}



void IS_Drop (IntStack* S)
/* Drop a value from an int stack */
{
    PRECONDITION (S->Count > 0);
    --S->Count;
}



void IS_Push (IntStack* S, long Val)
/* Push a value onto an int stack */
{
    PRECONDITION (S->Count < sizeof (S->Stack) / sizeof (S->Stack[0]));
    S->Stack[S->Count++] = Val;
}



long IS_Pop (IntStack* S)
/* Pop a value from an int stack */
{
    PRECONDITION (S->Count > 0);
    return S->Stack[--S->Count];
}
