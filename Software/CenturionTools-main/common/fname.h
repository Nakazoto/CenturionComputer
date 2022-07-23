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
/*                                  fname.h                                  */
/*                                                                           */
/*                       File name handling utilities                        */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2003 Ullrich von Bassewitz                                       */
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



#ifndef FNAME_H
#define FNAME_H



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



const char* FindExt (const char* Name);
/* Return a pointer to the file extension in Name or NULL if there is none */

const char* FindName (const char* Path);
/* Return a pointer to the file name in Path. If there is no path leading to
** the file, the function returns Path as name.
*/

char* MakeFilename (const char* Origin, const char* Ext);
/* Make a new file name from Origin and Ext. If Origin has an extension, it
** is removed and Ext is appended. If Origin has no extension, Ext is simply
** appended. The result is placed in a malloc'ed buffer and returned.
** The function may be used to create "foo.o" from "foo.s".
*/



/* End of fname.h */

#endif
