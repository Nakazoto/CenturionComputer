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
/*                                 xmalloc.h                                 */
/*                                                                           */
/*                       Memory allocation subroutines                       */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2006 Ullrich von Bassewitz                                       */
/*               Römerstraße 52                                              */
/*               D-70794 Filderstadt                                         */
/* EMail:        uz@cc65.org                                                 */
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



#ifndef XMALLOC_H
#define XMALLOC_H



#include <stddef.h>



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



void* xmalloc (size_t Size);
/* Allocate memory, check for out of memory condition. Do some debugging */

void* xrealloc (void* P, size_t Size);
/* Reallocate a memory block, check for out of memory */

void xfree (void* Block);
/* Free the block, do some debugging */

char* xstrdup (const char* S);
/* Duplicate a string on the heap. The function checks for out of memory */

void* xdup (const void* Buf, size_t Size);
/* Create a copy of Buf on the heap and return a pointer to it. */



/* End of xmalloc.h */

#endif
