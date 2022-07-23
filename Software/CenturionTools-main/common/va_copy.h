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
/*                                 va_copy.h                                 */
/*                                                                           */
/*               va_copy macro for systems that don't have it                */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2004      Ullrich von Bassewitz                                       */
/*               Römerstrasse 52                                             */
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



#ifndef VA_COPY_H
#define VA_COPY_H



#include <stdarg.h>


                   
/* No action if we have a working va_copy */
#if !defined(va_copy)



/* The watcom compiler doesn't have va_copy and a problematic va_list definition */
#if defined(__WATCOMC__)
#define va_copy(dest,src)       memcpy((dest), (src), sizeof (va_list))
#endif

/* GNU C has a builtin function */
#if defined(__GNUC__)
#define va_copy(dest,src)       __va_copy(dest, src)
#endif

/* MS VC allows for assignment */
#if defined(_MSC_VER)
#define va_copy(dest,src)       ((dest) = (src))
#endif

/* If va_copy is not defined now, we have a problem */
#if !defined(va_copy)
#error "Need a working va_copy!"
#endif



#endif



/* End of va_copy.h */

#endif
