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
/*                                 filepos.h                                 */
/*                                                                           */
/*                       File position data structure                        */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 1998-2011, Ullrich von Bassewitz                                      */
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



#ifndef FILEPOS_H
#define FILEPOS_H



/*****************************************************************************/
/*                                   Data                                    */
/*****************************************************************************/



/* Type of a file position */
typedef struct FilePos FilePos;
struct FilePos {
    unsigned    Line;               /* Line */
    unsigned    Col;                /* Column */
    unsigned    Name;               /* File */
};

/* Initializer for a FilePos */
#define STATIC_FILEPOS_INITIALIZER      { 0, 0, 0 }



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



void InitFilePos (FilePos* P);
/* Initialize the file position (set all fields to zero) */

int CompareFilePos (const FilePos* P1, const FilePos* P2);
/* Compare two file positions. Return zero if both are equal, return a value
** > 0 if P1 is greater and P2, and a value < 0 if P1 is less than P2. The
** compare rates file index over line over column.
*/



/* End of filepos.h */

#endif
