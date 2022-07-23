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
/*                                 version.c                                 */
/*                                                                           */
/*             Version information for the cc65 compiler package             */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 1998-2009, Ullrich von Bassewitz                                      */
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
#include "xsprintf.h"
#include "searchpath.h"
#include "version.h"



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



#define VER_MAJOR       2U
#define VER_MINOR       18U



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



const char* GetVersionAsString (void)
/* Returns the version number as a string in a static buffer */
{
    static char Buf[60];
#if defined(BUILD_ID)
    xsnprintf (Buf, sizeof (Buf), "%u.%u - %s", VER_MAJOR, VER_MINOR, STRINGIZE (BUILD_ID));
#else
    xsnprintf (Buf, sizeof (Buf), "%u.%u", VER_MAJOR, VER_MINOR);
#endif
    return Buf;
}



unsigned GetVersionAsNumber (void)
/* Returns the version number as a combined unsigned for use in a #define */
{
    return ((VER_MAJOR * 0x100) + (VER_MINOR * 0x10));
}
