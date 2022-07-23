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
/*                                inttypes.h                                 */
/*                                                                           */
/*                           Define integer types                            */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2004      Ullrich von Bassewitz                                       */
/*               Roemerstrasse 52                                            */
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



#ifndef INTTYPES_H
#define INTTYPES_H



/* If we have <stdint.h>, include it; otherwise, adapt types from <stddef.h>.
** gcc and msvc don't define __STDC_VERSION__ without special flags, so check
** for them explicitly.  Undefined symbols are replaced by zero; so, checks for
** defined(__GNUC__) and defined(_MSC_VER) aren't necessary.
*/
#if (__STDC_VERSION__ >= 199901) || (__GNUC__ >= 3) || (_MSC_VER >= 1600)
#include <stdint.h>
#else

/* Assume that ptrdiff_t and size_t are wide enough to hold pointers.
** Assume that they are the widest type.
*/
#include <stddef.h>

typedef ptrdiff_t intptr_t;
typedef size_t uintptr_t;
typedef ptrdiff_t intmax_t;
typedef size_t uintmax_t;

#endif



/* End of inttypes.h */
#endif
