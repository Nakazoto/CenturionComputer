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
/*                                 incpath.c                                 */
/*                                                                           */
/*                      Include path handling for cc65                       */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2013, Ullrich von Bassewitz                                      */
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
#include "incpath.h"



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



SearchPaths*    SysIncSearchPath;       /* System include path */
SearchPaths*    UsrIncSearchPath;       /* User include path */



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



void InitIncludePaths (void)
/* Initialize the include path search list */
{
    /* Create the search path lists */
    SysIncSearchPath = NewSearchPath ();
    UsrIncSearchPath = NewSearchPath ();
}



void FinishIncludePaths (void)
/* Finish creating the include path search lists. */
{
    /* Add specific paths from the environment */
    AddSearchPathFromEnv (SysIncSearchPath, "CC68_INC");
    AddSearchPathFromEnv (UsrIncSearchPath, "CC68_INC");

    /* Add paths relative to a main directory defined in an env. var. */
    AddSubSearchPathFromEnv (SysIncSearchPath, "CC68_HOME", "include");

    /* Add some compiled-in search paths if defined at compile time. */
#if defined(CC68_INC) && !defined(_WIN32)
    AddSearchPath (SysIncSearchPath, STRINGIZE (CC68_INC));
#endif

    /* Add paths relative to the parent directory of the Windows binary. */
    AddSubSearchPathFromWinBin (SysIncSearchPath, "include");
}
