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
/*                                   cpu.h                                   */
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



#ifndef CPU_H
#define CPU_H



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/


/* CPUs */
typedef enum {
    CPU_UNKNOWN = -1,           /* Not specified or invalid target */
    CPU_NONE,                   /* No CPU - for assembler */
    CPU_4,
    CPU_6,
    CPU_COUNT
} cpu_t;

/* CPU instruction sets */
enum {
    CPU_ISET_NONE    = 1 << CPU_NONE,
    CPU_ISET_4       = 1 << CPU_4,
    CPU_ISET_6       = 1 << CPU_6,
};

/* CPU used */
extern cpu_t CPU;

/* Table with CPU names */
extern const char* CPUNames[CPU_COUNT];

/* Table with CPU the instruction sets */
extern const unsigned CPUIsets[CPU_COUNT];



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



int ValidAddrSizeForCPU (unsigned char AddrSize);
/* Check if the given address size is valid for the current CPU */

cpu_t FindCPU (const char* Name);
/* Find a CPU by name and return the target id. CPU_UNKNOWN is returned if
** the given name is no valid target.
*/



/* End of cpu.h */

#endif
