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
/*                                   cpu.c                                   */
/*                                                                           */
/*                            CPU specifications                             */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2003-2011, Ullrich von Bassewitz                                      */
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
#include "addrsize.h"
#include "check.h"
#include "cpu.h"
#include "strutil.h"



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



/* CPU used */
cpu_t CPU = CPU_UNKNOWN;

/* Table with target names */
const char* CPUNames[CPU_COUNT] = {
    "none",
    "4",
    "6",
};

/* Tables with CPU instruction sets */
const unsigned CPUIsets[CPU_COUNT] = {
    CPU_ISET_NONE,
    CPU_ISET_4,
    CPU_ISET_6,
};



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/


cpu_t FindCPU (const char* Name)
/* Find a CPU by name and return the target id. CPU_UNKNOWN is returned if
** the given name is no valid target.
*/
{
    unsigned I;

    /* Check all CPU names */
    for (I = 0; I < CPU_COUNT; ++I) {
        if (StrCaseCmp (CPUNames [I], Name) == 0) {
            return (cpu_t)I;
        }
    }

    /* Not found */
    return CPU_UNKNOWN;
}
