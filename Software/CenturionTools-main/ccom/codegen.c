/*
 *	CC6303:  A C compiler for the 6803/6303 processors
 *	(C) 2019 Alan Cox
 *
 *	This compiler is built out of a much modified CC65 and all new code
 *	is placed under the same licence as the original. Please direct all
 *	cc6303 bugs to the author not to the cc65 developers unless you find
 *	a bug that is also present in cc65.
 */
/*
 *	Early prototype of a Warrex CPU6 / EE-200 Code Generator.
 *
 *	This is a two accumulator machine with 16bit operations, plenty of
 *	indexes but with a few gaps
 *	- no compare (use B and sutract from B is the idiom)
 *	- no way to store/load S, Y or Z except via other registers
 *
 *	The other oddity is X. A call saves the old X and sets X to the
 *	return PC, an rtr reverses this. Thus X is sort of a free callee
 *	save register, a fact we don't yet use well as we sometimes seem
 *	to neeed X to get stuff.
 *
 *	Currently
 *
 *	A 	accumulator
 *	B	scratch
 *	X	scratch pointer
 *	Y	upper half of 32bit accumulator
 *	Z 	frame pointer
 *	S	stack pointer
 *
 *	It would be nice to fold B and X into one and claim X as a register
 *	variable.
 */


/*****************************************************************************/
/*                                                                           */
/*                                 codegen.c                                 */
/*                                                                           */
/*                            6502 code generator                            */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 1998-2013, Ullrich von Bassewitz                                      */
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



#include <stdio.h>
#include <string.h>
#include <stdarg.h>

/* common */
#include "check.h"
#include "cpu.h"
#include "inttypes.h"
#include "strbuf.h"
#include "xmalloc.h"
#include "xsprintf.h"
#include "version.h"

/* cc65 */
#include "asmcode.h"
#include "asmlabel.h"
#include "casenode.h"
#include "codeseg.h"
#include "dataseg.h"
#include "error.h"
#include "expr.h"
#include "global.h"
#include "segments.h"
#include "stackptr.h"
#include "util.h"
#include "codegen.h"


#define LO(x)		((unsigned)((x) & 0xFFFF))
#define HI(x)		((unsigned)((x >> 16) & 0xFFFF))

/*****************************************************************************/
/*                                  Helpers                                  */
/*****************************************************************************/



static void typeerror (unsigned type)
/* Print an error message about an invalid operand type */
{
    /* Special handling for floats here: */
    if ((type & CF_TYPEMASK) == CF_FLOAT) {
        Fatal ("Floating point type is currently unsupported");
    } else {
        Internal ("Invalid type in CF flags: %04X, type = %u", type, type & CF_TYPEMASK);
    }
}



static const char* GetLabelName (unsigned Flags, uintptr_t Label, long Offs, int addr)
{
    static char Buf [256];              /* Label name */

    /* Create the correct label name */
    switch (Flags & CF_ADDRMASK) {

        case CF_STATIC:
            /* Static memory cell */
            if (Offs) {
                xsprintf (Buf, sizeof (Buf), "%s%+ld", LocalLabelName (Label), Offs);
            } else {
                xsprintf (Buf, sizeof (Buf), "%s", LocalLabelName (Label));
            }
            break;

        case CF_EXTERNAL:
            /* External label */
            if (Offs) {
                xsprintf (Buf, sizeof (Buf), "_%s%+ld", (char*) Label, Offs);
            } else {
                xsprintf (Buf, sizeof (Buf), "_%s", (char*) Label);
            }
            break;

        case CF_ABSOLUTE:
            /* Absolute address */
            xsprintf (Buf, sizeof (Buf), "0x%04X", (unsigned)((Label+Offs) & 0xFFFF));
            break;

        case CF_REGVAR:
            /* Variable in register bank : not yet touched */
            if (addr)
                xsprintf (Buf, sizeof (Buf), "reg+%u", (unsigned)((Label+Offs) & 0xFFFF));
            else
                xsprintf (Buf, sizeof (Buf), "@reg+%u", (unsigned)((Label+Offs) & 0xFFFF));
            break;

        default:
            Internal ("Invalid address flags: %04X", Flags);
    }

    /* Return a pointer to the static buffer */
    return Buf;
}

unsigned FramePtr;		/* True if we are using a frame pointer */

/*
 *	Assign a value to accumulator A. If keepc is set don't mush the
 *	link (carry) flag (ie don't clr)
 */

static void AssignA(unsigned short value, int keepc)
{
    /* Optimizations using clr. clr clears the C flag so we can't always
       use it */
    if (value == 0) {
        if (keepc == 0)
            AddCodeLine("cla");
        else
            AddCodeLine("lda 0; noopt");
    }
    else
        AddCodeLine("lda %d", value);
}

/*
 *	Assign to X when we are using it for an index
 */
static void AssignX(unsigned short value)
{
    if (value == 0)
        AddCodeLine("clr x");
    else
        AddCodeLine("ldx %d", value);
}

/* Load the A register with a name, offset */
static void LoadA(const char *from, int offset)
{
    if (offset)
        AddCodeLine("lda (%s+%d)", from, offset);
    else
        AddCodeLine("lda (%s)", from);
}

/* Load the A register via the X register with offset */
static void LoadAVia(char r, int offset)
{
    if (offset > 127)
        Internal("Bad offset %d in LoadAVia%c.\n", offset, r);
    AddCodeLine("lda %d(%c)", offset, r);
}

/* Store the A register to a name */
static void StoreA(const char *where, int offset)
{
    if (offset)
        AddCodeLine("sta (%s+%d)", where, offset);
    else
        AddCodeLine("sta (%s)", where);
}

/* Store the A register via X */
static void StoreAVia(char r, int offset)
{
    if (offset > 127)
        Internal("Bad offset %d in StoreAVia%c.\n", r, offset);
    AddCodeLine("sta %d(%c)", offset, r);
}

/* Subtract a constant from A. We use B as our scratch register. We might
   be better off eventually doing long using B:A but that remains to
   be seen */
static void SubAConst(int value)
{
    /* CPU has an RSUB instruction in reality so use add */
    AddCodeLine("ldb -%d", LO(value));
    AddCodeLine("add b,a");
}

static void AddAConst(int value)
{
    if (value == 0)
        AddCodeLine("xfr a,a");	/* Just set flags */
    /* Should probably use inr for 4 or less ? FIXME */
    else if (value == 1)
        AddCodeLine("ina");
    else if (value == -1)
        AddCodeLine("dca");
    else if (value == -2) {
        AddCodeLine("dca");
        AddCodeLine("dca");
    } else if (value == 2) {
        AddCodeLine("ina");
        AddCodeLine("ina");
    } else {
        AddCodeLine("ld b, %d", LO(value));
        AddCodeLine("add b,a");
    }
}

static void AddA(const char *where, int offset)
{
    if (offset == 0)
        AddCodeLine("ldb (%s)", where);
    else
        AddCodeLine("ldb (%s+%d)", where, offset);
    AddCodeLine("add b,a");
}

static void AddAVia(char r, int offset)
{
    if (offset > 127)
            Internal("Bad offset %d in LoadAVia%c.\n", offset, r);
    AddCodeLine("ldb %d(%c)", offset, r);
    AddCodeLine("add b,a");
}

static void LsrABy(int n)
{
    if (n > 15) {
        AssignA(0, 0);
        return;
    }
    if (CPU != CPU_4) {
        /* Use a rotate to get the top bit clear */
        AddCodeLine("rl");
        AddCodeLine("rrr a");
        if (n > 1)	/* And an arithmetic shift will do the right thing now */
            AddCodeLine("srr a,%d", n - 1);
        return;
    }
    /* Fast path for CPU4, EE200 */
    /* TODO: is this a faster path for the CPU6 as well ? */
    if (n >= 8) {
        AddCodeLine("xfr ah,al");
        AddCodeLine("clrb ah");
        while(n-- > 8)
            AddCodeLine("srab");	/* Upper bits already done */
        return;
    }
    AddCodeLine("rl");
    AddCodeLine("rrr a");
    while(--n)
        AddCodeLine("sra");
}

static void AslABy(int n)
{
    if (n == 0)
        return;
    if (n > 15) {
        AssignA(0, 0);
        return;
    }
    if (CPU != CPU_4) {
        AddCodeLine("slr a,%d", n);
        return;
    }
    if (n >= 8) {
        AddCodeLine("xfr al,ah");
        AddCodeLine("clab");
        while(n-- > 8)
            AddCodeLine("slrb ah");	/* Low bits already done */
        return;
    }
    while(n--)
        AddCodeLine("sla");
}

/* Get A into X, may mash A */
static void AToX(void)
{
    AddCodeLine("xax");
}
    

/* Get X into A */
static void XToA(void)
{
    AddCodeLine("xfr x,a");
}


/* Generate the value of an offset from the stack base. We don't have to
   worry about reach */

static int GenOffsetIndirect(int Offs)
{
    /* Frame pointer argument */
    if (Offs > 0 && FramePtr)
        return Offs + 2;
    Offs -= StackPtr;
    return Offs;
}

/*
 *	Find a way to reference an object by it's offset. We have
 *	three options to consider eventually
 *
 *	1.	Stuff the offset into X and return (always works)
 *	2.	Use an offset from S (objects within 128 bytes of SP)
 *	3.	Use an offset from Z (most arguments, objects nearer
 *		top of stack)
 */
static char GenerateOffset(unsigned Flags, int *Offsp)
{
    unsigned s = sizeofarg(Flags) - 1;
    int Offs = *Offsp;

    /* Frame pointer using function, use the frame pointer only for
       arguments not locals. We can (assuming non insane argument counts)
       just use z for this */
    if (Offs > 0 && FramePtr) {
        AddCodeLine(";Genoffset %u %d\n", Flags, Offs);
        Offs += 4;	/* FP is from SP but also have stacked stuff */
        if (Offs <= 128 - s) {
            /* Usual simple case. X holds fp, caller is using n,X format
               so we just load x with @fp on any CPU type */
            *Offsp = Offs;
            return 'z';
        }
        /* Out of range put it in X */
        AddCodeLine("ldb %d", Offs);
        AddCodeLine("xfr z,x");
        AddCodeLine("add b,x");
        *Offsp = 0;
        return 'x';
    }

    /* The non vararg argument case. Everything is relative to S, X may hold
       something related to S already */

    /* Allow for the save frame below the arguments */
    if (Offs >= 0)
        Offs += 4;

    /* Check for top of stack as it's cheaper than n(Z) */
    if (Offs == StackPtr) {
        *Offsp = 0;
        return 's';
    }

    /* If the argument is within the range of Z then use Z if we can. We can't
       do so for varargs however */
    if (Offs > -128 && !FramePtr) {
        *Offsp = Offs;
        return 'z';
    }
    /* Adjust for current stack pointer */
    Offs -= StackPtr;

    if (Offs >= -127 && Offs <= 128 - s) {
        *Offsp = Offs;
        return 's';
    }
    /* We can't reach it from z or s.. that requires a big frame but can
       occur with arrays on the stack. Go via X */
    *Offsp = 0;
    AddCodeLine("ldb %d", Offs);
    AddCodeLine("xfr s,x");
    AddCodeLine("add b,x");
    return 'x';
}
    
/*****************************************************************************/
/*                            Pre- and postamble                             */
/*****************************************************************************/



void g_preamble (void)
/* Generate the assembler code preamble */
{
    /* Identify the compiler version */
    AddTextLine (";");
    AddTextLine ("; File generated by ccwrx v %s", GetVersionAsString ());
    AddTextLine (";");

    /* If we're producing code for some other CPU, switch the command set */
    switch (CPU) {
        case CPU_4:	AddTextLine ("\t.setcpu\t\t4");	 break;
        case CPU_6:	AddTextLine ("\t.setcpu\t\t6");  break;
        default:        Internal ("Unknown CPU: %d", CPU);
    }
}



void g_fileinfo (const char* Name, unsigned long Size, unsigned long MTime)
/* If debug info is enabled, place a file info into the source */
{
    /* TODO */
}

/* The code that follows may be moved around */
void g_moveable (void)
{
}

/* We have generated code and thrown it away. OPTIMISE: we can do better in this
   case I think */
void g_removed (void)
{
}


/*****************************************************************************/
/*                              Segment support                              */
/*****************************************************************************/



void g_userodata (void)
/* Switch to the read only data segment */
{
    UseDataSeg (SEG_RODATA);
}



void g_usedata (void)
/* Switch to the data segment */
{
    UseDataSeg (SEG_DATA);
}



void g_usebss (void)
/* Switch to the bss segment */
{
    UseDataSeg (SEG_BSS);
}



void g_segname (segment_t Seg)
/* Emit the name of a segment if necessary */
{
    /* Emit a segment directive for the data style segments */
    DataSeg* S;
    switch (Seg) {
        case SEG_RODATA: S = CS->ROData; break;
        case SEG_DATA:   S = CS->Data;   break;
        case SEG_BSS:    S = CS->BSS;    break;
        default:         S = 0;          break;
    }
    if (S) {
        DS_AddLine (S, ".segment\t\"%s\"", GetSegName (Seg));
    }
}



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/

unsigned sizeofarg (unsigned flags)
/* Return the size of a function argument type that is encoded in flags */
{
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            return (flags & CF_FORCECHAR)? 1 : 2;

        case CF_INT:
            return 2;

        case CF_LONG:
            return 4;

        case CF_FLOAT:
            return 4;

        default:
            typeerror (flags);
            /* NOTREACHED */
            return 2;
    }
}


/* We need to track the state of X versus S here. As we push and pop
   we may well be able to supress the use of TSX but we can't assume the
   offset versus S is the same any more */
int pop (unsigned flags)
/* Pop an argument of the given size */
{
    unsigned s = sizeofarg (flags);
    return StackPtr += s;
}

int push (unsigned flags)
/* Push an argument of the given size */
{
    unsigned s = sizeofarg (flags);
    return StackPtr -= s;
}

static int MakeByteOffs (unsigned Flags, int Offs)
/* The value in Offs is an offset to an address in d. Make sure, an object
** of the type given in Flags can be loaded or stored into this address by
** adding part of the offset to the address in d, so that the remaining
** offset fits into an index register. Return the remaining offset.
*/
{
    /* 127 is ok as we work on words and 127(x) is indeed 127/128 */
    if (Offs <= 127 - sizeofarg (Flags) && Offs >= -128)
        return Offs;
    if (Offs)
        AddAConst(Offs);
    return 0;
}



/*****************************************************************************/
/*                      Functions handling local labels                      */
/*****************************************************************************/



void g_defcodelabel (unsigned label)
/* Define a local code label */
{
    AddCodeLine("%s:", LocalLabelName(label));
    /* Overly pessimistic but we don't know what our branch will come from */
}

void g_defdatalabel (unsigned label)
/* Define a local data label */
{
    AddDataLine ("%s:", LocalLabelName (label));
}



void g_aliasdatalabel (unsigned label, unsigned baselabel, long offs)
/* Define label as a local alias for baselabel+offs */
{
    /* We need an intermediate buffer here since LocalLabelName uses a
    ** static buffer which changes with each call.
    */
    StrBuf L = AUTO_STRBUF_INITIALIZER;
    SB_AppendStr (&L, LocalLabelName (label));
    SB_Terminate (&L);
    AddDataLine ("%s .equ\t%s+%ld",
                 SB_GetConstBuf (&L),
                 LocalLabelName (baselabel),
                 offs);
    SB_Done (&L);
}

/*****************************************************************************/
/*                     Functions handling global labels                      */
/*****************************************************************************/

void g_defgloblabel (const char* Name)
/* Define a global label with the given name */
{
    /* Global labels are always data labels */
    AddDataLine ("_%s:", Name);
}



void g_defexport (const char* Name, int ZP)
/* Export the given label */
{
    AddTextLine ("\t.export\t\t_%s", Name);
}

void g_defimport (const char* Name, int ZP)
/* Import the given label */
{
}

void g_importstartup (void)
/* Forced import of the startup module */
{
}

void g_importmainargs (void)
/* Forced import of a special symbol that handles arguments to main */
{
}

/*****************************************************************************/
/*                          Function entry and exit                          */
/*****************************************************************************/

void g_enter (const char *name, unsigned flags, unsigned argsize)
/* Function prologue */
{
    push (CF_INT);		/* Return address */
    push (CF_INT);		/* Saved X */
    AddCodeLine(".export _%s", name);
    AddCodeLine("_%s:",name);

    /* TODO: look at indexing via y or z and using x as the frame pointer */
    AddCodeLine("stx (-s)");
    push (CF_INT);

    AddCodeLine("xfr z,x");
    AddCodeLine("stx (-s)");
    push(CF_INT);
    AddCodeLine("xfr s,z");

    /* Uglies from the L->R stack handling for varargs */
    if ((flags & CF_FIXARGC) == 0) {
        /* B passed in is the argbyte count */
        AddCodeLine("add b,z");
        FramePtr = 1;
    } else {
        FramePtr = 0;
    }
}

void g_leave(int voidfunc, unsigned flags, unsigned argsize)
/* Function epilogue */
{
    /* Should always be zero : however ignore this being wrong if we took
       a C level error as that may be the real cause. Only valid code failing
       this check is a problem */

    if (StackPtr && !ErrorCount)
        Internal("g_leave: stack unbalanced by %d", StackPtr);
    AddCodeLine("jmp cexit");
}

/*****************************************************************************/
/*                           Fetching memory cells                           */
/*****************************************************************************/

void g_getimmed (unsigned Flags, unsigned long Val, long Offs)
/* Load a constant into the primary register */
{
    unsigned short W1,W2;


    if ((Flags & CF_CONST) != 0) {

        /* Numeric constant */
        switch (Flags & CF_TYPEMASK) {

            case CF_CHAR:
                if ((Flags & CF_USINGX) == 0 && (Flags & CF_FORCECHAR) != 0) {
                    if (Val == 0)
                        AddCodeLine("clrb al");
                    else
                        AddCodeLine ("ldab %d", (unsigned char) Val);
                    break;
                }
                /* FALL THROUGH */
            case CF_INT:
                if (Flags & CF_USINGX)
                    AssignX(Val);
                else
                    AssignA(Val, 0);
                break;

            case CF_LONG:
                /* Split the value into two words */
                W1 = LO(Val);
                W2 = HI(Val);
                AssignA(W2, 0);
                /* Y is the upper half of our 32bit accumulator */
                AddCodeLine("xay");
                AssignX(W1);
                break;

            default:
                typeerror (Flags);
                break;

        }

    } else {
        /* Some sort of label */
        const char* Label = GetLabelName (Flags, Val, Offs, 1);
        /* Load the address into the primary */
        if (Flags & CF_USINGX)
            AddCodeLine("ldx %s", Label);
        else
            AddCodeLine ("lda %s", Label);
    }
}

void g_getstatic (unsigned flags, uintptr_t label, long offs)
/* Fetch an static memory cell into the primary register */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 0);

    /* Check the size and generate the correct load operation */
    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
            /* No byte loads into X and they don't usually make sense
               so flag them as not happening and let the caller try again
               via D */
            if ((flags & CF_FORCECHAR) || (flags & CF_TEST)) {
                AddCodeLine ("ldab (%s)", lbuf);   /* load A from the label */
            } else {
                AddCodeLine ("cla");
                AddCodeLine ("ldab (%s)", lbuf);   /* load A from the label */
                if (!(flags & CF_UNSIGNED)) {
                    /* Must sign extend */
                    unsigned L = GetLocalLabel ();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
            }
            break;

        case CF_INT:
            if (flags & CF_USINGX) {
                    AddCodeLine ("ldx (%s)", lbuf);
            }
            else
                LoadA(lbuf, 0);
            break;

        case CF_LONG:
            if (flags & CF_TEST) {
                LoadA(lbuf, 2);
                AddCodeLine("ldb (%s)", lbuf);
                AddCodeLine ("ori a,b");
            } else {
                LoadA(lbuf, 0);
                AddCodeLine("xfr a,y");
                if (flags & CF_USINGX) {
                    AddCodeLine ("ldx (%s+2)", lbuf);
                } else
                    LoadA(lbuf, 2);
            }
            break;

        default:
            typeerror (flags);

    }
}

void g_getlocal (unsigned Flags, int Offs)
/* Fetch specified local object (local var). */
{
    char r = GenerateOffset(Flags, &Offs);

    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if ((Flags & CF_FORCECHAR) || (Flags & CF_TEST)) {
                AddCodeLine ("ldab %d(%c)", Offs, r);
            } else {
                AddCodeLine ("cla");
                AddCodeLine ("ldab %d(%c)", Offs, r);
                if ((Flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
            }
            break;

        case CF_INT:
            LoadAVia(r, Offs);
            break;

        case CF_LONG:
            LoadAVia(r, Offs);
            AddCodeLine("xfr a,y");
            LoadAVia(r, Offs + 2);
            if (Flags & CF_TEST)
                g_test (Flags);
            break;

        default:
            typeerror (Flags);
    }
}

void g_getlocal_x (unsigned Flags, int Offs)
/* Fetch specified local object (local var) into x. */
{
    char r = GenerateOffset(Flags, &Offs);

    switch (Flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                Internal("ForceChar in getlocal_x");
                break;
            }
        case CF_INT:
            AddCodeLine ("ldx %d(%c)", Offs, r);
            break;
        case CF_LONG:
            LoadAVia(r, Offs);
            AddCodeLine ("ldx %d(%c)", Offs + 2, r);
            break;

        default:
            typeerror (Flags);
    }
}


void g_primary_to_x(void)
{
    AToX();
}

void g_x_to_primary(void)
{
    XToA();
}

/* For now we use D but there is a good case for optimising a lot of these
   paths to use X when they don't need X again shortly */

void g_getind (unsigned Flags, unsigned Offs)
/* Fetch the specified object type indirect through the primary register
** into the primary register
*/
{
    Offs = MakeByteOffs (Flags, Offs);

    /* Handle the indirect fetch */
    switch (Flags & CF_TYPEMASK) {
        case CF_CHAR:
            /* Simple case for a test */
            if (Flags & CF_TEST) {
                AddCodeLine("ldab %d(a)", Offs);
                break;
            }
            AddCodeLine ("xab");
            AddCodeLine ("clrb ah");
            AddCodeLine ("ldab %d(b)", Offs);
            if ((Flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
            }
            break;

        case CF_INT:
            LoadAVia('a', Offs);
            break;

        case CF_LONG:
            AToX();
            LoadAVia('x', Offs);
            AddCodeLine("xfr a,y");
            LoadAVia('x', Offs + 2);
            if (Flags & CF_TEST) {
                g_test (Flags);
            }
            break;

        default:
            typeerror (Flags);

    }
}

void g_leasp (unsigned Flags, int Offs)
/* Fetch the address of the specified symbol into the primary register */
{
    /* FramePtr indicates a Varargs function where arguments are relative
       to fp */
    if (FramePtr && Offs > 0) {
        /* Because of the frame pointer */
        Offs += 4;
        if (Flags & CF_USINGX) {
            AddCodeLine("ldx %d", Offs);
            AddCodeLine("add z,x");
        } else {
            AddCodeLine("lda %d", Offs);
            AddCodeLine("add z,a");
        }
        return;
    }
    /* We have to go via S in the frame pointer case so do that always */
    if (Offs >= 0)
        Offs += 4;
    Offs -= StackPtr;

    if (!(Flags & CF_USINGX)) {
        AddCodeLine("xfr s,a");
        if (Offs)
            AddAConst(Offs);
        return;
    }
    AddCodeLine("xfr s,x");
    if (Offs) {
        AddCodeLine("ldb %d", Offs);
        AddCodeLine("add b,x");
    }
}

/*****************************************************************************/
/*                             Store into memory                             */
/*****************************************************************************/

void g_putstatic (unsigned flags, uintptr_t label, long offs)
/* Store the primary register into the specified static memory cell */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 0);

    /* Check the size and generate the correct store operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            AddCodeLine ("stab (%s)", lbuf);
            break;

        case CF_INT:
            if (flags & CF_USINGX) {
                AddCodeLine ("stx (%s)", lbuf);
            } else
                StoreA(lbuf, 0);
            break;

        case CF_LONG:
            if (flags & CF_USINGX) {
                AddCodeLine ("stx (%s+2)", lbuf);
                AddCodeLine ("xfr y,x");
                AddCodeLine ("stx (%s)", lbuf);
            } else {
                AddCodeLine ("xfr y,b");
                AddCodeLine ("stb (%s+2)", lbuf);
                StoreA(lbuf, 0);
            }
            break;

        default:
            typeerror (flags);

    }
}



void g_putlocal (unsigned Flags, int Offs, long Val)
/* Put data into local object. */
{
    char r = GenerateOffset (Flags, &Offs);

    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (Flags & CF_CONST) {
                if ((Val & 0xFF) == 0)
                    AddCodeLine("clab");
                else
                    AddCodeLine ("ldab %d", (unsigned char) Val);
            }
            AddCodeLine ("stab %d(%c)", Offs, r);
            break;

        case CF_INT:
            if (Flags & CF_CONST)
                AssignA(Val, 0);
            StoreAVia(r, Offs);
            break;

        case CF_LONG:
            if (Flags & CF_CONST) {
                AssignA(HI(Val), 0);
                StoreAVia(r, Offs);
                if (HI(Val) != LO(Val))
                    AssignA(LO(Val), 0);
                StoreAVia(r, Offs + 2);
            } else {
                AddCodeLine("xfr y,b");
                AddCodeLine("stb 0x%X(%c)", LO(Offs), r);
                StoreAVia(r, Offs + 2);
            }
            break;

        default:
            typeerror (Flags);

    }
}



void g_putind (unsigned Flags, unsigned Offs)
/* Store the specified object type in the primary register at the address
** on the top of the stack
*/
{
    AddCodeLine("ldx (s+)");
    /* FIXME: 128 - sizeof Flags .. */
    if (Offs > 125) {
        AddCodeLine("ldb %d", Offs);
        AddCodeLine("add b,x");
        Offs = 0;
    }
    /* X now points into the object, and Offs is the remaining offset to
       allow for. D holds the stuff to store */                
    switch (Flags & CF_TYPEMASK) {
        case CF_CHAR:
            AddCodeLine ("stab %d(x)", Offs);
            break;

        case CF_INT:
            StoreAVia('x', Offs);
            break;

        case CF_LONG:
            StoreAVia('x', Offs + 2);
            AddCodeLine("xfr y,b");
            AddCodeLine("stb (x)");
            break;

        default:
            typeerror (Flags);

    }

    /* Pop the argument which is always a pointer */
    pop (CF_PTR);
}



/*****************************************************************************/
/*                    type conversion and similiar stuff                     */
/*****************************************************************************/


void g_toslong (unsigned flags)
/* Make sure, the value on TOS is a long. Convert if necessary */
{
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
        case CF_INT:
            if (flags & CF_UNSIGNED) {
                /* Push a new upper 16bits of zero */
                AssignX(0);
                AddCodeLine("stx (-s)");
            } else {
                /* need to sign extend */
                unsigned L = GetLocalLabel();
                AddCodeLine("clr b");
                AddCodeLine("ldx (s)");
                AddCodeLine("bp %s", LocalLabelName(L));
                AddCodeLine("dcr b");
                g_defcodelabel (L);
                AddCodeLine("stb (-s)");
            }
            push (CF_INT);
            break;

        case CF_LONG:
            break;

        default:
            typeerror (flags);
    }
}



void g_tosint (unsigned flags)
/* Make sure, the value on TOS is an int. Convert if necessary */
{
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
        case CF_INT:
            break;

        case CF_LONG:
            /* We have a big endian long at s+4,3,2,1 so we just need to
               throw out the top. Use ins so we don't trash X */
            AddCodeLine("ldb (s+)");
            pop (CF_INT);
            break;

        default:
            typeerror (flags);
    }
}



static void g_regchar (unsigned Flags)
/* Make sure, the value in the primary register is in the range of char. Truncate if necessary */
{
    unsigned L;

    AddCodeLine ("clrb ah");

    if ((Flags & CF_UNSIGNED) == 0) {
        AddCodeLine("xfr al,al");
        /* Sign extend */
        L = GetLocalLabel();
        AddCodeLine ("bp %s", LocalLabelName (L));
        AddCodeLine ("dcrb ah");
        g_defcodelabel (L);
    }
}



void g_regint (unsigned Flags)
/* Make sure, the value in the primary register an int. Convert if necessary */
{
    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                /* Conversion is from char */
                g_regchar (Flags);
            }
            /* FALLTHROUGH */

        case CF_INT:
        case CF_LONG:
            break;

        default:
            typeerror (Flags);
    }
}



void g_reglong (unsigned Flags)
/* Make sure, the value in the primary register a long. Convert if necessary */
{
    unsigned L;

    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                /* Conversion is from char */
                AddCodeLine("clr y");
                AddCodeLine("clrb ah");
                if ((Flags & CF_UNSIGNED) == 0) {
                    L = GetLocalLabel();
                    AddCodeLine ("xfr al,al");
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcr y");
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
                break;   
            }
            /* FALLTHROUGH */

        case CF_INT:
            AddCodeLine("clr y");
            AddCodeLine("clrb ah");
            if ((Flags & CF_UNSIGNED)  == 0) {
                L = GetLocalLabel();
                AddCodeLine ("xfr al,al");
                AddCodeLine ("bp %s", LocalLabelName (L));
                AddCodeLine ("dcr y");
                AddCodeLine ("dcrb ah");
                g_defcodelabel (L);
            }
            break;

        case CF_LONG:
            break;

        default:
            typeerror (Flags);
    }
}



unsigned g_typeadjust (unsigned lhs, unsigned rhs)
/* Adjust the integer operands before doing a binary operation. lhs is a flags
** value, that corresponds to the value on TOS, rhs corresponds to the value
** in (e)ax. The return value is the the flags value for the resulting type.
*/
{
    unsigned ltype, rtype;
    unsigned result;

    /* Get the type spec from the flags */
    ltype = lhs & CF_TYPEMASK;
    rtype = rhs & CF_TYPEMASK;

    /* Check if a conversion is needed */
    if (ltype == CF_LONG && rtype != CF_LONG && (rhs & CF_CONST) == 0) {
        /* We must promote the primary register to long */
        g_reglong (rhs);
        /* Get the new rhs type */
        rhs = (rhs & ~CF_TYPEMASK) | CF_LONG;
        rtype = CF_LONG;
    } else if (ltype != CF_LONG && (lhs & CF_CONST) == 0 && rtype == CF_LONG) {
        /* We must promote the lhs to long */
        if (lhs & CF_REG) {
            g_reglong (lhs);
        } else {
            g_toslong (lhs);
        }
        /* Get the new rhs type */
        lhs = (lhs & ~CF_TYPEMASK) | CF_LONG;
        ltype = CF_LONG;
    }

    /* Determine the result type for the operation:
    **  - The result is const if both operands are const.
    **  - The result is unsigned if one of the operands is unsigned.
    **  - The result is long if one of the operands is long.
    **  - Otherwise the result is int sized.
    */
    result = (lhs & CF_CONST) & (rhs & CF_CONST);
    result |= (lhs & CF_UNSIGNED) | (rhs & CF_UNSIGNED);
    if (rtype == CF_LONG || ltype == CF_LONG) {
        result |= CF_LONG;
    } else {
        result |= CF_INT;
    }
    return result;
}



unsigned g_typecast (unsigned lhs, unsigned rhs)
/* Cast the value in the primary register to the operand size that is flagged
** by the lhs value. Return the result value.
*/
{
    /* Check if a conversion is needed */
    if ((rhs & CF_CONST) == 0) {
        switch (lhs & CF_TYPEMASK) {

            case CF_LONG:
                /* We must promote the primary register to long */
                g_reglong (rhs);
                break;

            case CF_INT:
                /* We must promote the primary register to int */
                g_regint (rhs);
                break;

            case CF_CHAR:
                /* We must truncate the primary register to char */
                g_regchar (lhs);
                break;

            default:
                typeerror (lhs);
        }
    }

    /* Do not need any other action. If the left type is int, and the primary
    ** register is long, it will be automagically truncated. If the right hand
    ** side is const, it is not located in the primary register and handled by
    ** the expression parser code.
    */

    /* Result is const if the right hand side was const */
    lhs |= (rhs & CF_CONST);

    /* The resulting type is that of the left hand side (that's why you called
    ** this function :-)
    */
    return lhs;
}



void g_scale (unsigned flags, long val)
/* Scale the value in the primary register by the given value. If val is positive,
** scale up, is val is negative, scale down. This function is used to scale
** the operands or results of pointer arithmetic by the size of the type, the
** pointer points to.
*/
{
    int p2;

    /* Value may not be zero */
    if (val == 0) {
        Internal ("Data type has no size");
    } else if (val > 0) {

        /* Scale up */
        if ((p2 = PowerOf2 (val)) > 0 && p2 <= 4) {

            /* Factor is 2, 4, 8 and 16, use special function */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        if (CPU == CPU_6 && p2 > 2)
                            AddCodeLine("slrb a,%d", p2);
                        else {
                            while (p2--) {
                                AddCodeLine ("slab");
                            }
                        }
                        break;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    if (CPU == CPU_6 && p2 > 2 )
                        AddCodeLine("slr a,%d", p2);
                    else {
                        while (p2--) {
                            AddCodeLine ("sla");
                        }
                    }
                    break;

                case CF_LONG:
                    AddCodeLine ("jsr shleax%d", p2);
                    break;

                default:
                    typeerror (flags);

            }

        } else if (val != 1) {

            /* Use a multiplication instead */
            g_mul (flags | CF_CONST, val);

        }

    } else {

        /* Scale down */
        val = -val;
        if ((p2 = PowerOf2 (val)) > 0 && p2 <= 4) {

            /* Factor is 2, 4, 8 and 16 use special function */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        if (flags & CF_UNSIGNED) {
                            AddCodeLine("rl");
                            AddCodeLine("rrr al");
                            if (CPU == CPU_6) {
                                AddCodeLine("slr al,%d", p2 - 1);
                            } else {
                                while (--p2)
                                    AddCodeLine("slr al");
                            }
                        } else {
                            if (CPU == CPU_6) {
                                AddCodeLine("slr al,%d", p2);
                            } else {
                                while (p2--)
                                    AddCodeLine ("slrb al");
                            }
                        }
                        break;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    if (flags & CF_UNSIGNED) {
                        LsrABy(p2);
                    } else  {
                        if (CPU == CPU_6)
                            AddCodeLine("srr a,%d", p2);
                        else {
                            if (p2 == 1)
                                AddCodeLine("srr a");
                            else
                                AddCodeLine ("jsr asrax%d", p2);
                        }
                    }
                    break;

                case CF_LONG:
                    if (flags & CF_UNSIGNED) {
                        AddCodeLine ("jsr lsreax%d", p2);
                    } else {
                        AddCodeLine ("jsr asreax%d", p2);
                    }
                    break;

                default:
                    typeerror (flags);

            }

        } else if (val != 1) {

            /* Use a division instead */
            g_div (flags | CF_CONST, val);

        }
    }
}



/*****************************************************************************/
/*              Adds and subs of variables fix a fixed address               */
/*****************************************************************************/



void g_addlocal (unsigned flags, int offs)
/* Add a local variable to d */
{
    char r;

    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            r = GenerateOffset(flags, &offs);
            AddCodeLine("clr bh");
            AddCodeLine ("ldbb %d(%c)", offs, r);
            AddCodeLine ("add b,a");
            break;

        case CF_INT:
            r = GenerateOffset(flags, &offs);
            AddCodeLine ("ldb %d(%c)", offs, r);
            break;

        case CF_LONG:
            /* Do it the old way */
            /* OPTIMIZE:  */
            g_push (flags, 0);
            g_getlocal (flags, offs);
            g_add (flags, 0);
            break;

        default:
            typeerror (flags);

    }
}



void g_addstatic (unsigned flags, uintptr_t label, long offs)
/* Add a static variable to a */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 0);
    unsigned L;

    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            AddCodeLine("clr bh");
            AddCodeLine("ldb (%s)", lbuf);
            AddCodeLine("add b,a");
            break;

        case CF_INT:
            AddA(lbuf, 0);
            break;

        case CF_LONG:
            L = GetLocalLabel();
            AddCodeLine("ldb (%s)", lbuf);
            AddCodeLine("add b,y");
            AddCodeLine("ldb 2(%s)", lbuf);
            AddCodeLine("add b,a");
            AddCodeLine("bnl %s", LocalLabelName(L));
            AddCodeLine("inr y");
            g_defcodelabel(L);
            break;

        default:
            typeerror (flags);

    }
}



/*****************************************************************************/
/*                           Special op= functions                           */
/*****************************************************************************/



void g_addeqstatic (unsigned flags, uintptr_t label, long offs,
                    unsigned long val)
/* Emit += for a static variable */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 0);


    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("clrb ah");
                if (flags & CF_CONST) {
                    /* Optimise +1 case ? */
                    AddCodeLine ("ldab (%s)", lbuf);
                    AddCodeLine ("ldbb %d", (unsigned char) val);
                    AddCodeLine ("addb bl,al");
                    AddCodeLine ("stab (%s)", lbuf);
                } else {
                    AddCodeLine ("ldbb (%s)", lbuf);
                    AddCodeLine ("addb bl,al");
                    AddCodeLine ("stab (%s)", lbuf);
                }
                if ((flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
                break;
            }
            /* FALLTHROUGH */
        case CF_INT:
            if (flags & CF_CONST) {
                if (flags & CF_USINGX) {
                    AddCodeLine ("ldx (%s)", lbuf);
                    switch(val) {
                        case 2:
                            AddCodeLine ("inx");
                            /* Fall through */
                        case 1:
                            AddCodeLine ("inx");
                            break;
                        default:
                            AddCodeLine("ldb %d", (unsigned short)val);
                            AddCodeLine("add b,x");
                            break;
                    }
                    AddCodeLine("stx (%s)", lbuf);
                    break;
                }
                AssignA(val, 0);
                AddA(lbuf, 0);
                StoreA(lbuf, 0);
            } else {
                AddA(lbuf, 0);
                StoreA(lbuf, 0);
            }
            break;

        case CF_LONG:
            lbuf = GetLabelName (flags, label, offs, 1);
            if (flags & CF_CONST) {
                /* TODO: look at optimizing */
                g_getstatic (flags, label, offs);
                g_inc (flags, val);
                g_putstatic (flags, label, offs);
            } else {
                AddCodeLine ("ldb %s", lbuf);
                AddCodeLine ("jsr laddeq");
            }
            break;

        default:
            typeerror (flags);
    }
}



/* FIXME: do we assume the val is in A or stacked ?? */
void g_addeqlocal (unsigned flags, int Offs, unsigned long val)
/* Emit += for a local variable */
{
    char r;
    
    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                r= GenerateOffset(flags, &Offs);
                AddCodeLine("clrb ah");
                if ((flags & CF_CONST) && val == 1) {
                    AddCodeLine("ldab %d(%c)", Offs, r);
                    AddCodeLine("inr al");
                    AddCodeLine ("stab %d(%c)", Offs, r);
                } else {
                    if (flags & CF_CONST)
                        AddCodeLine ("ldab %d", (int)(val & 0xFF));
                    AddCodeLine ("ldbb %d(%c)", Offs, r);
                    AddCodeLine("addb bl,al");
                    AddCodeLine ("stab %d(%c)", Offs, r);
                }
                if ((flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            r = GenerateOffset(flags, &Offs);
            if (flags & CF_CONST)
                AssignA(val, 0);
            AddAVia(r,  Offs);
            StoreAVia(r, Offs);
            break;

        case CF_LONG:
            /* OPTIMIZE: this needs much improvement */
            if (flags & CF_CONST) {
                g_getimmed (flags, val, 0);
            }
            Offs = GenOffsetIndirect(Offs);
            AddCodeLine("ldb %d", Offs);
            AddCodeLine ("jsr laddeqysp");
            break;

        default:
            typeerror (flags);
    }
}


/* OPTIMIZE: we need a notion not just of using X but of "from X" to fix this
   to generate x relative code when it can. And probably smarts in the caller */
void g_addeqind (unsigned flags, unsigned offs, unsigned long val)
/* Emit += for the location with address in d */
{
    offs = MakeByteOffs (flags, offs);

    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            AToX();
            AddCodeLine("ldab %d(x)", offs);
            /* FIXME: 1-4 or so are worth doing by inr */
            if (val == 1)
                AddCodeLine("inr a");
            else {
                AddCodeLine("ldbb %d", (int8_t)val);
                AddCodeLine("addb bl,al");
            }
            AddCodeLine("clrb ah");
            AddCodeLine("stab %d(x)", offs);
            /* Do we care about sign prop here ? */
            break;

        case CF_INT:
            AToX();
            LoadAVia('x', offs);
            AddAConst(val);
            StoreAVia('x', offs);
            break;
            
            /* Fall through */
        case CF_LONG:
            AddCodeLine("sta (-s)");
            push (CF_PTR);                      /* Correct the internal sp */
            g_getind (flags, offs);             /* Fetch the value */
            g_inc (flags, val);                 /* Increment value in primary */
            g_putind (flags, offs);             /* Store the value back */
            break;

        default:
            typeerror (flags);
    }
}



void g_subeqstatic (unsigned flags, uintptr_t label, long offs,
                    unsigned long val)
/* Emit -= for a static variable */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 0);

    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("cla");
                if (flags & CF_CONST) {
                    AddCodeLine ("ldab (%s)", lbuf);
                    AddCodeLine ("ldbb -%d", (unsigned char)(val & 0xFF));
                    AddCodeLine ("addb bl,al");
                    AddCodeLine ("stab (%s)", lbuf);
                } else {
                    AddCodeLine ("ldbb (%s)", lbuf);
                    AddCodeLine ("addb bl,al");
                    AddCodeLine ("stab (%s)", lbuf);
                }
                if ((flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            if ((flags & CF_CONST) && (flags & CF_USINGX)) {
                AddCodeLine ("ldb -%d", (unsigned short)val);
                AddCodeLine ("ldx (%s)", lbuf);
                AddCodeLine ("add b,x");
                AddCodeLine ("stx (%s)", lbuf);
                break;
            }
            if (flags & CF_CONST) {
                LoadA(lbuf, 0);
                SubAConst(val);
                StoreA(lbuf, 0);
            } else {
                AddCodeLine("ldb (%s)", lbuf);
                AddCodeLine("sub b,a");		/* A = B - A */
                AddCodeLine("sta (%s)", lbuf);
            }
            break;

        case CF_LONG:
            if (flags & CF_CONST) {
                g_getstatic (flags, label, offs);
                g_dec (flags, val);
                g_putstatic (flags, label, offs);
            } else {
                lbuf = GetLabelName (flags, label, offs, 1);
                AddCodeLine ("ldb %s", lbuf);
                AddCodeLine ("jsr lsubeq");
            }
            break;

        default:
            typeerror (flags);
    }
}



void g_subeqlocal (unsigned flags, int Offs, unsigned long val)
/* Emit -= for a local variable */
{
    char r;
    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            r = GenerateOffset(flags, &Offs);
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("clrb ah");
                if (flags & CF_CONST) {
                    AddCodeLine ("ldab %d(%c)", Offs, r);
                    if (val == 1)
                        AddCodeLine ("dcrb al");
                    else {
                        AddCodeLine ("ldbb %d", -(unsigned char) val);
                        AddCodeLine ("addb bl,al");
                    }
                } else {
                    AddCodeLine ("ldbb %d(%c)", Offs, r);
                    AddCodeLine ("subb bl,al");
                    AddCodeLine ("xfrb bl,al");
                }
                AddCodeLine ("stab %d(%c)", Offs, r);
                if ((flags & CF_UNSIGNED) == 0) {
                    unsigned L = GetLocalLabel();
                    AddCodeLine ("bp %s", LocalLabelName (L));
                    AddCodeLine ("dcrb ah");
                    g_defcodelabel (L);
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            r = GenerateOffset(flags, &Offs);
            if (flags & CF_CONST) {
                LoadAVia(r, Offs);
                SubAConst(val);
                StoreAVia(r, Offs);
                break;
            }
            AddCodeLine("ldb %d(%c)", Offs, r);
            AddCodeLine("sub b,a");	/* A = B - A */
            StoreAVia(r, Offs);
            break;

        case CF_LONG:
            if (flags & CF_CONST) {
                g_getimmed (flags, val, 0);
            }
            Offs = GenOffsetIndirect(Offs);
            AssignX(Offs);
            AddCodeLine ("jsr lsubeqysp");
            break;

        default:
            typeerror (flags);
    }
}



void g_subeqind (unsigned flags, unsigned offs, unsigned long val)
/* Emit -= for the location with address in X */
{
    /* If the offset is too large for a byte register, add the high byte
    ** of the offset to the primary. Beware: We need a special correction
    ** if the offset in the low byte will overflow in the operation.
    */
    offs = MakeByteOffs (flags, offs);

    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            /* No need to care about sign extension ? */
            AToX();
            AddCodeLine ("cla");
            AddCodeLine ("ldab %d(x)", offs);
            if (val == 1)
                AddCodeLine("dcrb al");
            else {
                AddCodeLine("ldbb -%d",(unsigned char)val);
                AddCodeLine("addb bl,al");
            }
            AddCodeLine ("stab %d(x)", offs);
            break;

        case CF_INT:
            AToX();
            LoadAVia('x', offs);
            SubAConst(val);
            StoreAVia('x', offs);
            break;
        case CF_LONG:
            AddCodeLine ("jsr pushd");          /* Push the address */
            push (CF_PTR);                      /* Correct the internal sp */
            g_getind (flags, offs);             /* Fetch the value */
            g_dec (flags, val);                 /* Increment value in primary */
            g_putind (flags, offs);             /* Store the value back */
            break;

        default:
            typeerror (flags);
    }
}



/*****************************************************************************/
/*                 Add a variable address to the value in d                 */
/*****************************************************************************/



void g_addaddr_local (unsigned flags attribute ((unused)), int offs)
/* Add the address of a local variable to d */
{
    if (offs > 0 && FramePtr) {
        AddCodeLine("add z,a");
        offs += 2;
        if (offs != 0)
            AddAConst(offs);
    } else {
        offs -= StackPtr;
        if (offs != 0) {
            AddAConst(offs);
            AddCodeLine("add s,a");
        } else
            AddCodeLine("xfr s,a");
    }
}

void g_addaddr_static (unsigned flags, uintptr_t label, long offs)
/* Add the address of a static variable to d */
{
    /* Create the correct label name */
    const char* lbuf = GetLabelName (flags, label, offs, 1);
    AddCodeLine ("ldb %s", lbuf);
    AddCodeLine ("add b,a");
}



/*****************************************************************************/
/*                                                                           */
/*****************************************************************************/

/* This is used internally for certain increment cases only */

void g_save (unsigned flags)
/* Copy primary register to hold register. */
{
    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("stab (tmp1)");
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            StoreA("tmp1", 0);
            break;

        case CF_LONG:
            StoreA("tmp1", 0);
            AddCodeLine("xfr y,b");
            AddCodeLine("stb (tmp2)");
            break;

        default:
            typeerror (flags);
    }
}



void g_restore (unsigned flags)
/* Copy hold register to primary. */
{
    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("ldab (tmp1)");
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            LoadA("tmp1", 0);
            break;

        case CF_LONG:
            AddCodeLine("lda (tmp2)");
            AddCodeLine("xay");
            AddCodeLine("lda (tmp1)");
            break;

        default:
            typeerror (flags);
    }
}



void g_cmp (unsigned flags, unsigned long val)
/* Immediate compare. The primary register will not be changed, Z flag
** will be set.
*/
{

    /* Check the size and determine operation */
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                if ((val & 0xFF) == 0)
                    AddCodeLine("xfrb al,al");
                else {
                    AddCodeLine ("ldbb %d", (unsigned char) val);
                    AddCodeLine ("sabb");
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            if (LO(val) == 0)
                AddCodeLine ("xfr a,a");
            else {
                AddCodeLine ("ldb %d", (unsigned short) val);
                AddCodeLine ("sab");
            }
            break;

        case CF_LONG:
            Internal ("g_cmp: Long compares not implemented");
            break;

        default:
            typeerror (flags);
    }
}



static void oper (unsigned Flags, unsigned long Val, const char* const* Subs)
/* Encode a binary operation. subs is a pointer to four strings:
**      0       --> Operate on ints
**      1       --> Operate on unsigneds
**      2       --> Operate on longs
**      3       --> Operate on unsigned longs
**
**  Sets up X for accesses. Don't use oper for magic via X code
*/
{
    /* Determine the offset into the array */
    if (Flags & CF_UNSIGNED) {
        ++Subs;
    }
    if ((Flags & CF_TYPEMASK) == CF_LONG) {
        Subs += 2;
    }

    /* Load the value if it is not already in the primary */
    if (Flags & CF_CONST) {
        /* Load value - we call the helpers with the value in D, except
           for longs */
        g_getimmed (Flags, Val, 0);
    }

    AddCodeLine ("jsr %s", *Subs);

    /* The operation will pop it's argument */
    pop (Flags);
}



void g_test (unsigned flags)
/* Test the value in the primary and set the condition codes */
{
    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("xfr al,al");
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            AddCodeLine ("xfr a,a");
            /* Check we get all the codes we need this way */
            break;

        case CF_LONG:
            AddCodeLine ("xfr y,b");
            AddCodeLine ("ori a,b");
            break;

        default:
            typeerror (flags);

    }
}



void g_push (unsigned flags, unsigned long val)
/* Push the primary register or a constant value onto the stack */
{
    /* OPTIMIZE: we need to do long better especially in the 6800 case */
    if ((flags & CF_CONST) && (flags & CF_TYPEMASK) != CF_LONG) {

        /* We have a constant 8 or 16 bit value */
        if ((flags & CF_TYPEMASK) == CF_CHAR && (flags & CF_FORCECHAR)) {
            /* Handle as 8 bit value */
            AddCodeLine ("ldbb %d", (unsigned char) val);
            AddCodeLine ("stbb (-s)");
        } else {
            g_getimmed (flags, val, 0);
            AddCodeLine ("sta (-s)");
        }

    } else {

        /* Value is not 16 bit or not constant */
        if (flags & CF_CONST) {
            if ((flags & CF_TYPEMASK) != CF_CHAR || (flags & CF_FORCECHAR) == 0) {
                g_getimmed (flags, val, 0);
                switch(flags & CF_TYPEMASK) {
                case CF_INT:
                    AddCodeLine("sta (-s)");
                    break;
                case CF_LONG:
                    AddCodeLine("sta (-s)");
                    AddCodeLine("xfr y,b");
                    AddCodeLine("stb (-s)");
                    break;
                default:
                    typeerror (flags);
                }
                push (flags);
                return;
            }
            g_getimmed (flags, val, 0);
        }

        /* Push the primary register */
        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    /* Handle as char */
                    AddCodeLine("stab (-s)");
                    break;
                }
                /* FALL THROUGH */
            case CF_INT:
                if (flags & CF_USINGX)
                    AddCodeLine("stx (-s)");
                else
                    AddCodeLine("sta (-s)");
                break;

            case CF_LONG:
                if (flags & CF_USINGX)
                    AddCodeLine("stx (-s)");
                else
                    AddCodeLine ("sta (-s)");
                AddCodeLine("xfr y,b");
                AddCodeLine("stb (-s)");
                break;

            default:
                typeerror (flags);
        }
    }
    /* Adjust the stack offset */
    push (flags);
}



void g_swap (unsigned flags)
/* Swap the primary register and the top of the stack. flags give the type
** of *both* values (must have same size).
*/
{
    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
        case CF_INT:
            AddCodeLine("ldb (s)");
            AddCodeLine("sta (s)");
            AddCodeLine("xfr b,a");
            break;

        case CF_LONG:
            AddCodeLine ("jsr swapestk");
            break;

        default:
            typeerror (flags);

    }
}



/* Flags tells us if it is varargs, ArgSize is the number of *extra* bytes
   pushed for the ... */
void g_call (unsigned Flags, const char* Label, int ArgSize)
/* Call the specified subroutine name */
{
    if ((Flags & CF_FIXARGC) == 0) {
        if (ArgSize)
            AddCodeLine("ldb %d", ArgSize);
        else
            AddCodeLine("clr b");
    }
    AddCodeLine ("jsr _%s", Label);
}



/* Flags tells us if it is varargs, ArgSize is the number of *extra* bytes
   pushed for the ... */
void g_callind (unsigned Flags, int Offs, int ArgSize)
/* Call subroutine indirect */
{
    char r;
    if ((Flags & CF_LOCAL) == 0) {
        /* Address is in d */
        if ((Flags & CF_FIXARGC) == 0) {
            if (ArgSize)
                AddCodeLine("ldb %d", ArgSize);
            else
                AddCodeLine("clr b");
        }
        if (Flags & CF_USINGX)
            AddCodeLine ("jsr (x)");
        else
            AddCodeLine ("jsr (a)");
    } else {
        /* TODO: */
        /* REVIEW: check flag type is right here */
        r = GenerateOffset(Flags, &Offs);
        AddCodeLine("ld%c %d(x)", Offs, r);
        if ((Flags & CF_FIXARGC) == 0) {
            if (ArgSize)
                AddCodeLine("ldb %d", ArgSize);
            else
                AddCodeLine("clr b");
        }
        /* We can probably fold this into an @offs(r) */
        AddCodeLine("jsr (%c)", r);
    }
}



void g_jump (unsigned Label)
/* Jump to specified internal label number */
{
    AddCodeLine ("bra %s", LocalLabelName (Label));
}



void g_truejump (unsigned flags attribute ((unused)), unsigned label)
/* Jump to label if zero flag clear */
{
    AddCodeLine ("jnz %s", LocalLabelName (label));
}



void g_falsejump (unsigned flags attribute ((unused)), unsigned label)
/* Jump to label if zero flag set */
{
    AddCodeLine ("jz %s", LocalLabelName (label));
}


void g_lateadjustSP (unsigned label)
/* Adjust stack based on non-immediate data */
{
    AddCodeLine ("ldb (%s)", LocalLabelName(label));
    AddCodeLine ("add b,s");
}

void g_drop (unsigned Space, int save_d)
/* Drop space allocated on the stack */
/* Should use the frame pointer for func end case */
{
    switch(Space) {
        case 2:
            AddCodeLine("inr s");
        case 1:
            AddCodeLine("inr s");
        case 0:
            break;
        default:
            AddCodeLine("ldx %d", Space);
            AddCodeLine("add x,s");
            break;
    }
}


void g_space (int Space, int save_d)
/* Create or drop space on the stack */
{
    /* There are some cases we could save X but not clear they matter REVIEW */
    if (Space < 0) {
        /* This is actually a drop operation */
        g_drop (-Space, save_d);
        return;
    }
    switch(Space) {
        case 2:
            AddCodeLine("dcr s");
        case 1:
            AddCodeLine("dcr s");
        case 0:
            break;
        default:
            AddCodeLine("ldx -%d", Space);
            AddCodeLine("add x,s");
            break;
    }
}


void g_cstackcheck (void)
/* Check for a C stack overflow */
{
    AddCodeLine ("jsr cstkchk");
}

void g_stackcheck (void)
/* Check for a stack overflow */
{
    AddCodeLine ("jsr stkchk");
}

void g_add (unsigned flags, unsigned long val)
/* Primary = TOS + Primary */
{
    unsigned L;

    if (flags & CF_CONST) {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (val == 1)
                        AddCodeLine("inrb al");
                    else {
                        AddCodeLine("ldbb %d", (unsigned char) val);
                        AddCodeLine("addb bl,al");
                    }
                    break;
                }
                /* Fall through */
            case CF_INT:
                if (flags & CF_USINGX) {
                    if (val == 1) {
                        AddCodeLine("inx");
                        break;
                    }
                    if (val == 2) {
                        AddCodeLine("inx");
                        AddCodeLine("inx");
                        break;
                    }
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("add b,x");
                } else
                    AddAConst(val);
                break;
            case CF_LONG:
                AddCodeLine("ldb %d", LO(val));
                AddCodeLine("add b,y");
                AddCodeLine("ldb %d", HI(val));
                AddCodeLine("add b,a");
                L = GetLocalLabel();
                AddCodeLine("bnl %s", LocalLabelName(L));
                AddCodeLine("inr y");
                g_defcodelabel(L);
                break;
        }
    } else {
        /* We can optimize some of these in terms of ,x */
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (s+)");
                    AddCodeLine("addb bl,al");
                    pop(flags);
                    return;
                }
            /* Fall through */
            case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("add b,a");
                pop(flags);
                return;
            case CF_LONG:
                AddCodeLine("ldb (s+)");
                AddCodeLine("add b,y");
                AddCodeLine("ldb (s+)");
                AddCodeLine("add b,a");
                L = GetLocalLabel();
                AddCodeLine("bnl %s", LocalLabelName(L));
                AddCodeLine("inr y");
                g_defcodelabel(L);
                pop(flags);
                return;
        }
    }
}



void g_sub (unsigned flags, unsigned long val)
/* Primary = TOS - Primary */
{
    unsigned L;
    if (flags & CF_CONST) {
        /* This shouldn't ever happen as the compiler will turn constant
           subtracts in this form into something else */
        flags &= ~CF_FORCECHAR; /* Handle chars as ints */
        g_push (flags & ~CF_CONST, 0);
    }
    /* It would be nice to spot these higher up and turn them from TOS - Primary
       into negate and add */
    switch(flags & CF_TYPEMASK) {
        case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (s+)");
                    AddCodeLine("subb bl,al");
                    pop(flags);
                    return;
                }
        case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,a");
                pop(flags);
                return;
        case CF_LONG:
                L = GetLocalLabel();
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,y");
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,a");
                AddCodeLine("bnl %s", LocalLabelName(L));
                AddCodeLine("dcr y");
                g_defcodelabel(L);
                pop(flags);
                return;
    }
}


/* rsub is actually not really useful versus sub. TODO remove rsub conversions */
void g_rsub (unsigned flags, unsigned long val)
/* Primary = Primary - TOS */
{
    static const char* const ops[4] = {
        "tosrsubax", "tosrsubax", "tosrsubeax", "tosrsubeax"
    };
    if (flags & CF_CONST) {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (val == 1)
                        AddCodeLine("dcr al");
                    else {
                        AddCodeLine("ldbb -%d", (unsigned char) val);
                        AddCodeLine("addb bl,al");
                    }
                    break;
                }
                /* Fall through */
            case CF_INT:
                if (flags & CF_USINGX) {
                    if (val == 1) {
                        AddCodeLine("dcr x");
                        break;
                    }
                    if (val == 2) {
                        AddCodeLine("dcr x");
                        AddCodeLine("dcr x");
                        break;
                    }
                    AddCodeLine("ldb %d", -(unsigned short) val);
                    AddCodeLine("add b,x");
                    break;
                }
                SubAConst(val);
                break;
            case CF_LONG:
                flags &= CF_CONST;
                g_push(flags & ~CF_CONST, 0);
                oper(flags, val, ops);
        }
    } else {
        oper (flags, val, ops);
    }
}



void g_mul (unsigned flags, unsigned long val)
/* Primary = TOS * Primary */
{
    static const char* const ops[4] = {
        "tosmulax", "tosumulax", "tosmuleax", "tosumuleax"
    };

    int p2;

    /* Do strength reduction if the value is constant and a power of two */
    if (flags & CF_CONST && (p2 = PowerOf2 (val)) >= 0) {
        /* Generate a shift instead */
        g_asl (flags, p2);
        return;
    }

    /* OPTIMIZE: Spot near powers of two by bit count for add/push/add/pop/add
       sequences ? */
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    /* Handle some special cases */
                    switch (val) {
                            /* FIXME CPU 4 forms */
                        case 3:
                            AddCodeLine ("xab");
                            AddCodeLine ("slab");
                            AddCodeLine ("addb bl,al");
                            return;

                        case 5:
                            AddCodeLine ("xab");
                            AddCodeLine ("slab");
                            AddCodeLine ("slab");
                            AddCodeLine ("addb bl,al");
                            return;

                        case 6:
                            AddCodeLine ("xab");
                            AddCodeLine ("slab");
                            AddCodeLine ("addb bl,al");
                            AddCodeLine ("slab");
                            return;

                        case 7:
                            AddCodeLine ("xab");
                            AddCodeLine ("slab");
                            AddCodeLine ("addb bl,al");
                            AddCodeLine ("slab");
                            AddCodeLine ("addb bl,al");
                            return;

                        case 10:
                            AddCodeLine ("xab");
                            AddCodeLine ("slab a, 2");
                            AddCodeLine ("addb bl,al");
                            AddCodeLine ("slab");
                            return;
                    }
                }
                /* FALLTHROUGH */

            case CF_INT:
                 switch (val) {
                        /* FIXME CPU 4 forms */
                    case 3:
                        AddCodeLine ("xab");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        return;

                    case 5:
                        AddCodeLine ("xab");
                        AddCodeLine ("sla");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        return;

                    case 6:
                        AddCodeLine ("xab");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        AddCodeLine ("sla");
                        return;

                    case 7:
                        AddCodeLine ("xab");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        return;

                    case 10:
                        AddCodeLine ("xab");
                        AddCodeLine ("sla");
                        AddCodeLine ("sla");
                        AddCodeLine ("add b,a");
                        AddCodeLine ("sla");
                        return;
                }
                break;

            case CF_LONG:
                break;

            default:
                typeerror (flags);
        }

        /* If we go here, we didn't emit code. Push the lhs on stack and fall
        ** into the normal, non-optimized stuff.
        */
        flags &= ~CF_FORCECHAR; /* Handle chars as ints */
        g_push (flags & ~CF_CONST, 0);

    }

    /* Use long way over the stack */
    oper (flags, val, ops);
}



void g_div (unsigned flags, unsigned long val)
/* Primary = TOS / Primary */
{
    static const char* const ops[4] = {
        "tosdivax", "tosudivax", "tosdiveax", "tosudiveax"
    };

    /* Do strength reduction if the value is constant and a power of two */
    int p2;


    if ((flags & CF_CONST) && (p2 = PowerOf2 (val)) >= 0) {
        /* Generate a shift instead */
        g_asr (flags, p2);
    } else {
        /* Generate a division */
        if (flags & CF_CONST) {
            /* lhs is not on stack */
            flags &= ~CF_FORCECHAR;     /* Handle chars as ints */
            g_push (flags & ~CF_CONST, 0);
        }
        oper (flags, val, ops);
    }
}



void g_mod (unsigned flags, unsigned long val)
/* Primary = TOS % Primary */
{
    static const char* const ops[4] = {
        "tosmodax", "tosumodax", "tosmodeax", "tosumodeax"
    };
    int p2;

    /* Check if we can do some cost reduction */
    if ((flags & CF_CONST) && (flags & CF_UNSIGNED) && val != 0xFFFFFFFF && (p2 = PowerOf2 (val)) >= 0) {
        /* We can do that with an AND operation */
        g_and (flags, val - 1);
    } else {
        /* Do it the hard way... */
        if (flags & CF_CONST) {
            /* lhs is not on stack */
            flags &= ~CF_FORCECHAR;     /* Handle chars as ints */
            g_push (flags & ~CF_CONST, 0);
        }
        oper (flags, val, ops);
    }
}



void g_or_ops (char *op, unsigned flags, unsigned long val)
/* Primary = TOS | Primary */
{
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if ((val & 0xFF) != 0) {
                        AddCodeLine ("ldbb %d", (unsigned char)val);
                        AddCodeLine ("%sb bl,al", op);
                    }
                    return;
                }
                /* FALLTHROUGH */
            case CF_INT:
                val &= 0xFFFF;
            case CF_LONG:
                /* TODO: FFFFxxxx xxxxFFFF cases for ori at least */
                if (LO(val)) {
                    AddCodeLine ("ldb %d", LO(val));
                    AddCodeLine ("%s b,a", op);
                }
                if (HI(val)) {
                    AddCodeLine ("ldb %d", HI(val));
                    AddCodeLine ("%s b,y", op);
                }
                return;

            default:
                typeerror (flags);
        }

        /* If we go here, we didn't emit code. Push the lhs on stack and fall
        ** into the normal, non-optimized stuff. Note: The standard stuff will
        ** always work with ints.
        */
        flags &= ~CF_FORCECHAR;
        g_push (flags & ~CF_CONST, 0);
    }

    /* We can optimize some of these in terms of ,x */
    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine("ldbb (-s)");
                AddCodeLine("%sb b,a", op);
                pop(flags);
                return;
            }
            /* Fall through */
        case CF_INT:
            AddCodeLine("ldb (s+)");
            AddCodeLine ("%s b,a", op);
            pop(flags);
            return;
        case CF_LONG:
            AddCodeLine("ldb (s+)");
            AddCodeLine("%s b,y", op);
            AddCodeLine("ldb (s+)");
            AddCodeLine("%s b,a", op);
            pop(flags);
            return;
    }
}

void g_or(unsigned flags, unsigned long val)
/* Primary = TOS | Primary */
{
    g_or_ops("ori", flags, val);
}

void g_xor (unsigned flags, unsigned long val)
/* Primary = TOS ^ Primary */
{
    g_or_ops("ore", flags, val);
}

static void GenerateAnd(char *r, unsigned long Val)
{
    if (Val == 0)
        AddCodeLine("clr a");
    if (Val != 0xFFFF) { 
        AddCodeLine("ldb %d", (unsigned short)Val);
        AddCodeLine("and b,a");
    }
}

void g_and (unsigned Flags, unsigned long Val)
/* Primary = TOS & Primary */
{
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (Flags & CF_CONST) {
        switch (Flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (Flags & CF_FORCECHAR) {
                    if ((Val & 0xFF) == 0x00) {
                        AddCodeLine ("clab");
                    } else if ((Val & 0xFF) != 0xFF) {
                        AddCodeLine ("ldbb %d", (unsigned char)Val);
                        AddCodeLine ("and b,a");
                    }
                    return;
                }
                /* FALLTHROUGH */

            case CF_INT:
                GenerateAnd("a", LO(Val));
                return;

            case CF_LONG:
                GenerateAnd("a", LO(Val));
                GenerateAnd("y", HI(Val));
                return;

            default:
                typeerror (Flags);
        }
    }
    /* We can optimize some of these in terms of ,x */
    switch (Flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                AddCodeLine("ldbb (-s)");
                AddCodeLine("andb b,a");
                pop(Flags);
                return;
            }
            /* Fall through */
        case CF_INT:
            AddCodeLine("ldb (s+)");
            AddCodeLine("and b,a");
            pop(Flags);
            return;

        case CF_LONG:
            AddCodeLine("ldb (s+)");
            AddCodeLine("and b,y");
            AddCodeLine("ldb (s+)");
            AddCodeLine("and b,a");
            pop(Flags);
            return;
    }
}



void g_asr (unsigned flags, unsigned long val)
/* Primary = TOS >> Primary */
{
    static const char* const ops[4] = {
        "tosasrax", "tosshrax", "tosasreax", "tosshreax"
    };

    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
            case CF_INT:
                if (flags & CF_UNSIGNED) {
                    LsrABy(val);
                    return;
                }
                if (CPU == CPU_6 && val > 2)
                    AddCodeLine("srr a,%d", (unsigned short)(val & 15));
                else while(val--)
                    AddCodeLine("sra");
                return;

            case CF_LONG:
                /* REVIEW: we could go with oversize shift = 0 better ? */
                val &= 0x1F;
                if (val >= 24) {
                    AddCodeLine("xfr yh,al");
                    AddCodeLine("clr y");
                    AddCodeLine("clrb ah");
                    AddCodeLine ("orib al,al");
                    if ((flags & CF_UNSIGNED) == 0) {
                        unsigned L = GetLocalLabel();
                        AddCodeLine ("bp %s", LocalLabelName (L));
                        AddCodeLine ("dcr y");
                        AddCodeLine ("dcrb ah");
                        g_defcodelabel (L);
                    }
                    if (val == 24)
                        return;
                    /* FIXME: ideally we want a byte LsrALBy */
                    if (flags & CF_UNSIGNED)
                        LsrABy(val - 24);
                    else
                        AddCodeLine("srrb al, %d", (unsigned short)(val - 24));
                    return;
                }
                if (val >= 16) {
                    AddCodeLine("xfr y,a");
                    AddCodeLine("clr y");
                    AddCodeLine("ori a,a");
                    if ((flags & CF_UNSIGNED) == 0) {
                        unsigned L = GetLocalLabel();
                        AddCodeLine ("bp %s", LocalLabelName (L));
                        AddCodeLine ("dcr y");
                        g_defcodelabel (L);
                    }
                    val -= 16;
                    if (val == 0)
                        return;
                    if (flags & CF_UNSIGNED)
                        LsrABy(val);
                    else
                        AddCodeLine("srr a, %d", (unsigned short)val);
                    return;
                }
                if (val >= 8) {
                    if (flags & CF_UNSIGNED) {
                        AddCodeLine ("jsr shreax8");
                    } else {
                        AddCodeLine ("jsr asreax8");
                    }
                    val -= 8;
                }
                if (val >= 4) {
                    if (flags & CF_UNSIGNED) {
                        AddCodeLine ("jsr shreax4");
                    } else {
                        AddCodeLine ("jsr asreax4");
                    }
                    val -= 4;
                }
                if (val > 0) {
                    if (flags & CF_UNSIGNED) {
                        AddCodeLine ("jsr shreax%ld", val);
                    } else {
                        AddCodeLine ("jsr asreax%ld", val);
                    }
                }
                return;

            default:
                typeerror (flags);
        }

        /* If we go here, we didn't emit code. Push the lhs on stack and fall
        ** into the normal, non-optimized stuff. Note: The standard stuff will
        ** always work with ints.
        */
        flags &= ~CF_FORCECHAR;
        g_push (flags & ~CF_CONST, 0);
    }

    /* Use long way over the stack */
    oper (flags, val, ops);
}

void g_asl (unsigned flags, unsigned long val)
/* Primary = TOS << Primary */
{
    static const char* const ops[4] = {
        "tosaslax", "tosshlax", "tosasleax", "tosshleax"
    };

    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
            case CF_INT:
                AslABy(val);
                return;

            case CF_LONG:
                val &= 0x1F;
                if (val >= 24) {
                    AddCodeLine ("clrb yl");
                    AddCodeLine ("xfrb al,yh");
                    AddCodeLine ("clr a");
                    val -= 24;
                }
                if (val >= 16) {
                    AddCodeLine ("xfr a,y");
                    AddCodeLine ("clr a");
                    val -= 16;
                }
                if (val >= 8) {
                    AddCodeLine("xfrb yl,yh");
                    AddCodeLine("xfrb ah,yl");
                    AddCodeLine("xfrb al,ah");
                    AddCodeLine("clrb al");
                    val -= 8;
                }
                if (val > 4) {
                    AddCodeLine ("jsr shleax4");
                    val -= 4;
                }
                if (val > 0) {
                    AddCodeLine ("jsr shleax%ld", val);
                }
                return;

            default:
                typeerror (flags);
        }

        /* If we go here, we didn't emit code. Push the lhs on stack and fall
        ** into the normal, non-optimized stuff. Note: The standard stuff will
        ** always work with ints.
        */
        flags &= ~CF_FORCECHAR;
        g_push (flags & ~CF_CONST, 0);
    }

    /* Use long way over the stack */
    oper (flags, val, ops);
}



void g_neg (unsigned Flags)
/* Primary = -Primary */
{
    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                AddCodeLine ("ivrb al");
                AddCodeLine ("incb al");
                return;
            }
            /* FALLTHROUGH */

        case CF_INT:
            AddCodeLine ("ivr a");
            AddCodeLine ("inr a");
            break;

        case CF_LONG:
            AddCodeLine ("jsr negeax");
            break;

        default:
            typeerror (Flags);
    }
}



void g_bneg (unsigned flags)
/* Primary = !Primary */
{
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            AddCodeLine ("jsr bnega");
            break;

        case CF_INT:
            AddCodeLine ("jsr bnegax");
            break;

        case CF_LONG:
            AddCodeLine ("jsr bnegeax");
            break;

        default:
            typeerror (flags);
    }
}



void g_com (unsigned Flags)
/* Primary = ~Primary */
{
    switch (Flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (Flags & CF_FORCECHAR) {
                AddCodeLine ("ivrb al");
                return;
            }
            /* FALLTHROUGH */

        case CF_INT:
            AddCodeLine ("ivr a");
            break;

        case CF_LONG:
            AddCodeLine ("ivr a");
            AddCodeLine ("ivr y");
            break;

        default:
            typeerror (Flags);
    }
}

void g_inc (unsigned flags, unsigned long val)
/* Increment the primary register by a given number */
{
    unsigned Label;

    /* Don't inc by zero */
    if (val == 0) {
        return;
    }

    /* Generate code for the supported types */
    flags &= ~CF_CONST;
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                if (val == 1)
                    AddCodeLine("inrb al");
                else {
                    AddCodeLine("ldbb %d", (unsigned char)val);
                    AddCodeLine("addb bl,al");
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            if (flags & CF_USINGX) {
                if (val == 1) {
                    AddCodeLine("inx");
                    break;
                }
                if (val == 2) {
                    AddCodeLine("inx");
                    AddCodeLine("inx");
                    break;
                }
                AddCodeLine("ldb %d", LO(val));
                AddCodeLine("add b,x");
            }
            AddAConst(val);
            break;

        case CF_LONG:
            AddCodeLine("ldb %d", HI(val));
            AddCodeLine("add b,y");
            AddCodeLine("ldb %d", LO(val));
            AddCodeLine("add b,a");
            Label = GetLocalLabel();
            AddCodeLine("bp %s", LocalLabelName (Label));
            AddCodeLine("inr y");
            g_defcodelabel (Label);
            break;

        default:
            typeerror (flags);

    }
}

void g_dec (unsigned flags, unsigned long val)
/* Decrement the primary register by a given number */
{
    /* Don't dec by zero */
    if (val == 0) {
        return;
    }

    /* Generate code for the supported types */
    flags &= ~CF_CONST;
    switch (flags & CF_TYPEMASK) {

        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                if (val == 1)
                    AddCodeLine("dcrb al");
                else {
                    AddCodeLine("ldbb %d", (unsigned char)val);
                    AddCodeLine("addb bl,al");
                }
                break;
            }
            /* FALLTHROUGH */

        case CF_INT:
            if (flags & CF_USINGX) {
                if (val == 1) {
                    AddCodeLine("dcx");
                    break;
                }
                if (val == 2) {
                    AddCodeLine("dcx");
                    AddCodeLine("dcx");
                    break;
                }
                AddCodeLine("ldb %d", (unsigned short)val);
                AddCodeLine("add b,x");
            }
            SubAConst(val);
            break;

        case CF_LONG:
            g_sub (flags | CF_CONST, val);
            break;

        default:
            typeerror (flags);

    }
}

/*
** Following are the conditional operators. They compare the TOS against
** the primary and put a literal 1 in the primary if the condition is
** true, otherwise they clear the primary register
*/



void g_eq (unsigned flags, unsigned long val)
/* Test for equal */
{
    unsigned L;

    /* OPTIMIZE look at x for NULL case only */
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (val) {
                        AddCodeLine ("ldbb %d", (unsigned char) val);
                        AddCodeLine ("sabb");
                    } else
                        AddCodeLine ("xfrb al,al");
                    AddCodeLine ("jsr booleq");
                    return;
                }
                /* FALLTHROUGH */

            case CF_INT:
                if (val == 0)
                    AddCodeLine("xfr a,a");
                else {
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                }
                AddCodeLine ("jsr booleq");
                return;

            case CF_LONG:
                L = GetLocalLabel();
                AddCodeLine("ldb %d", LO(val));
                AddCodeLine("sab");
                AddCodeLine("jnz %s", LocalLabelName(L));
                AddCodeLine("ldb %d", HI(val));
                AddCodeLine("sab");
                g_defcodelabel(L);
                AddCodeLine("jsr booleq");
                return;

            default:
                typeerror (flags);
        }
    }
    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine("ldbb (-s)");
                AddCodeLine ("sabb");
                AddCodeLine ("jsr booleq");
                pop(flags);
                return;
            }
            /* Fall through */
        case CF_INT:
            AddCodeLine("ldb (s+)");
            AddCodeLine("sab");
            AddCodeLine ("jsr booleq");
            pop(flags);
            return;
        case CF_LONG:
            AddCodeLine("ldb (s+)");
            AddCodeLine("sab");
            AddCodeLine("xfr b,x");
            AddCodeLine("ldb (s+)");
            AddCodeLine("sub y,b");
            AddCodeLine("ori x,b");
            AddCodeLine("jsr booleq");
            pop(flags);
            return;
    }
}



void g_ne (unsigned flags, unsigned long val)
/* Test for not equal */
{
    unsigned L;
    static const char* const ops[4] = {
        "tosneax", "tosneax", "tosneeax", "tosneeax"
    };

    /* OPTIMIZE look at x for NULL case only */
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (val) {
                        AddCodeLine ("ldbb %d", (unsigned char) val);
                        AddCodeLine ("sabb");
                    } else
                        AddCodeLine ("orib al,al");
                    AddCodeLine ("jsr boolne");
                    return;
                }
                /* FALLTHROUGH */

            case CF_INT:
                if (val) {
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                } else {
                    AddCodeLine("ori a,a");
                }
                AddCodeLine ("jsr boolne");
                return;

            case CF_LONG:
                /* TODO: expand this for 0 words to be smaller */
                /* spot special cases maybe like !=0 and != FFFFFFFF where
                   we can and or ori the words to check */
                L = GetLocalLabel();
                AddCodeLine("ldb %d", LO(val));
                AddCodeLine("sab");
                AddCodeLine("bnz %s", LocalLabelName(L));
                AddCodeLine("ldb %d", HI(val));
                AddCodeLine("sub y,b");
                g_defcodelabel(L);
                AddCodeLine("jsr boolne");
                return;
            default:
                typeerror (flags);
        }

        /* If we go here, we didn't emit code. Push the lhs on stack and fall
        ** into the normal, non-optimized stuff. Note: The standard stuff will
        ** always work with ints.
        */
        flags &= ~CF_FORCECHAR;
        g_push (flags & ~CF_CONST, 0);
    }

    switch (flags & CF_TYPEMASK) {
        case CF_CHAR:
            if (flags & CF_FORCECHAR) {
                AddCodeLine ("ldbb (-s)");
                AddCodeLine ("sabb");
                AddCodeLine ("jsr boolne");
                pop(flags);
                return;
            }
            /* Fall through */
        case CF_INT:
            AddCodeLine ("ldb (s+)");
            AddCodeLine ("sab");
            AddCodeLine ("jsr boolne");
            pop(flags);
            return;
        case CF_LONG:
            L = GetLocalLabel();
            AddCodeLine("ldx (s+)");
            AddCodeLine("ldb (s+)");
            AddCodeLine("sab");
            AddCodeLine("bnz %s", LocalLabelName(L));
            AddCodeLine("sub y,x");
            g_defcodelabel(L);
            AddCodeLine("jsr boolne");
            pop(flags);
            return;
    }

    /* Use long way over the stack */
    oper (flags, val, ops);
}


/*
 *	Because we have rsub the helpers are somewhat reversed too
 */

void g_lt (unsigned flags, unsigned long val)
/* Test for less than */
{
    unsigned L;

//    AddCodeLine(";g_lt");
    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {
        if (flags & CF_UNSIGNED) {

            /* Give a warning in some special cases */
            if (val == 0) {
                Warning ("Condition is never true");
                AssignA(0, 0);
                return;
            }

            /* Look at the type */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        AddCodeLine ("ldbb %d", (unsigned char)val);
                        AddCodeLine ("sabb");
                        AddCodeLine ("jsr boolult");
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    AddCodeLine ("ldb %d", LO(val));
                    AddCodeLine ("sab");
                    AddCodeLine ("jsr boolult");
                    return;

                case CF_LONG:
                    L = GetLocalLabel();
                    AddCodeLine ("ldb %d", HI(val));
                    AddCodeLine ("sub y,b");
                    AddCodeLine ("bnz %s", LocalLabelName(L));
                    AddCodeLine ("ldb %d", LO(val));
                    AddCodeLine ("sab");
                    g_defcodelabel(L);
                    AddCodeLine ("jsr boolult");
                    return;

                default:
                    typeerror (flags);
            }

        } else if (val == 0) {

            /* A signed compare against zero must only look at the sign bit */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        AddCodeLine ("slrb al");          /* Bit 7 -> carry */
                        AssignA(0, 1);
                        AddCodeLine ("rlrb al");	 /* 0 or 1 */
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    /* Just check the high byte */
                    AddCodeLine ("slrb ah");           /* Bit 15 -> carry */
                    AssignA(0, 1);
                    AddCodeLine ("rlrb al");
                    return;

                case CF_LONG:
                    /* Just check the high byte */
                    AddCodeLine ("xfr y,a");
                    AddCodeLine ("slrb ah");
                    AssignA(0, 1);
                    AddCodeLine ("rlrb al");
                    return;

                default:
                    typeerror (flags);
            }

        } else {

            /* Signed compare against a constant != zero */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        AddCodeLine ("ldbb %d", (unsigned char)val);
                        AddCodeLine ("sabb");
                        AddCodeLine ("jsr boollt");
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                    AddCodeLine ("jsr boollt");
                    return;

                case CF_LONG:
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sub y,b");
                    L = GetLocalLabel();
                    AddCodeLine("bnz %s", LocalLabelName(L));
                    AddCodeLine("ldb %d", HI(val));
                    AddCodeLine("sab");
                    g_defcodelabel(L);
                    AddCodeLine("jsr boollt");
                    return;

                default:
                    typeerror (flags);
            }

        }
    }
     else {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (-s)");
                    AddCodeLine("subb bl,al");
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr boolult");
                    else
                        AddCodeLine ("jsr boollt");
                    pop (flags);
                    return;
                }
            case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,a");
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolult");
                else
                    AddCodeLine ("jsr boollt");
                pop (flags);
                return;
            case CF_LONG:
                AddCodeLine("ldx (s+)");
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub x,y");
                L = GetLocalLabel();
                AddCodeLine("bnz %s", LocalLabelName(L));
                AddCodeLine("ldb %d", HI(val));
                AddCodeLine("sub b,a");
                g_defcodelabel(L);
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolult");
                else
                    AddCodeLine("jsr boollt");
                pop (flags);
                return;

        }
    }
}

void g_le (unsigned flags, unsigned long val)
/* Test for less than or equal to */
{
    unsigned L;

    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        /* Look at the type */
        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (flags & CF_UNSIGNED) {
                        /* Unsigned compare */
                        if (val < 0xFF) {
                            /* Use < instead of <= because the former gives
                            ** better code on the 6502 than the latter.
                            */
                            g_lt (flags, val+1);
                        } else {
                            /* Always true */
                            Warning ("Condition is always true");
                            AddCodeLine ("jsr return1");
                        }
                    } else {
                        /* Signed compare */
                        if ((long) val < 0x7F) {
                            /* Use < instead of <= because the former gives
                            ** better code on the 6502 than the latter.
                            */
                            g_lt (flags, val+1);
                        } else {
                            /* Always true */
                            Warning ("Condition is always true");
                            AddCodeLine ("jsr return1");
                        }
                    }
                    return;
                }
                /* FALLTHROUGH */

            case CF_INT:
                if (flags & CF_UNSIGNED) {
                    /* Unsigned compare */
                    if (val < 0xFFFF) {
                        /* Use < instead of <= because the former gives
                        ** better code on the 6502 than the latter.
                        */
                        g_lt (flags, val+1);
                    } else {
                        /* Always true */
                        Warning ("Condition is always true");
                        AddCodeLine ("jsr return1");
                    }
                } else {
                    /* Signed compare */
                    if ((long) val < 0x7FFF) {
                        g_lt (flags, val+1);
                    } else {
                        /* Always true */
                        Warning ("Condition is always true");
                        AddCodeLine ("jsr return1");
                    }
                }
                return;

            case CF_LONG:
                if (flags & CF_UNSIGNED) {
                    /* Unsigned compare */
                    if (val < 0xFFFFFFFF) {
                        /* Use < instead of <= because the former gives
                        ** better code on the 6502 than the latter.
                        */
                        g_lt (flags, val+1);
                    } else {
                        /* Always true */
                        Warning ("Condition is always true");
                        AddCodeLine ("jsr return1");
                    }
                } else {
                    /* Signed compare */
                    if ((long) val < 0x7FFFFFFF) {
                        g_lt (flags, val+1);
                    } else {
                        /* Always true */
                        Warning ("Condition is always true");
                        AddCodeLine ("jsr return1");
                    }
                }
                return;

            default:
                typeerror (flags);
        }
    }
    else {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (-s)");
                    AddCodeLine("sabb");
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr boolule");
                    else
                        AddCodeLine ("jsr boolle");
                    pop (flags);
                    return;
                }
            case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("sab");
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolule");
                else
                    AddCodeLine ("jsr boolle");
                pop (flags);
                return;
            case CF_LONG:
                L = GetLocalLabel();
                AddCodeLine("ldx (s+)");
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub y,x");
                AddCodeLine("bnz %s", LocalLabelName(L));
                AddCodeLine("sab");
                g_defcodelabel(L);
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolule");
                else
                    AddCodeLine ("jsr boolle");
                pop (flags);
                return;
        }
    }
}



void g_gt (unsigned flags, unsigned long val)
/* Test for greater than */
{
    unsigned L;

    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        /* Look at the type */
        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    if (flags & CF_UNSIGNED) {
                        if (val == 0) {
                            /* If we have a compare > 0, we will replace it by
                            ** != 0 here, since both are identical but the
                            ** latter is easier to optimize.
                            */
                            g_ne (flags, val);
                        } else if (val < 0xFF) {
                            /* Use >= instead of > because the former gives
                            ** better code on the 6502 than the latter.
                            */
                            g_ge (flags, val+1);
                        } else {
                            /* Never true */
                            Warning ("Condition is never true");
                            AssignA(0, 0);
                        }
                    } else {
                        if ((long) val < 0x7F) {
                            /* Use >= instead of > because the former gives
                            ** better code on the 6502 than the latter.
                            */
                            g_ge (flags, val+1);
                        } else {
                            /* Never true */
                            Warning ("Condition is never true");
                            AssignA(0, 0);
                        }
                    }
                    return;
                }
                /* FALLTHROUGH */

            case CF_INT:
                if (flags & CF_UNSIGNED) {
                    /* Unsigned compare */
                    if (val == 0) {
                        /* If we have a compare > 0, we will replace it by
                        ** != 0 here, since both are identical but the latter
                        ** is easier to optimize.
                        */
                        g_ne (flags, val);
                    } else if (val < 0xFFFF) {
                        /* Use >= instead of > because the former gives better
                        ** code on the 6502 than the latter.
                        */
                        g_ge (flags, val+1);
                    } else {
                        /* Never true */
                        Warning ("Condition is never true");
                        AssignA(0, 0);
                    }
                } else {
                    /* Signed compare */
                    if ((long) val < 0x7FFF) {
                        g_ge (flags, val+1);
                    } else {
                        /* Never true */
                        Warning ("Condition is never true");
                        AssignA(0, 0);
                    }
                }
                return;

            case CF_LONG:
                if (flags & CF_UNSIGNED) {
                    /* Unsigned compare */
                    if (val == 0) {
                        /* If we have a compare > 0, we will replace it by
                        ** != 0 here, since both are identical but the latter
                        ** is easier to optimize.
                        */
                        g_ne (flags, val);
                    } else if (val < 0xFFFFFFFF) {
                        /* Use >= instead of > because the former gives better
                        ** code on the 6502 than the latter.
                        */
                        g_ge (flags, val+1);
                    } else {
                        /* Never true */
                        Warning ("Condition is never true");
                        AssignA(0, 0);
                    }
                } else {
                    /* Signed compare */
                    if ((long) val < 0x7FFFFFFF) {
                        g_ge (flags, val+1);
                    } else {
                        /* Never true */
                        Warning ("Condition is never true");
                        AssignA(0, 0);
                    }
                }
                return;

            default:
                typeerror (flags);
        }
    }
    else {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (s+)");
                    AddCodeLine("subb bl,al");
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr boolugt");
                    else
                        AddCodeLine ("jsr boolgt");
                    pop (flags);
                    return;
                }
            case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,a");
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolugt");
                else
                    AddCodeLine ("jsr boolgt");
                pop (flags);
                return;
            case CF_LONG:
                L = GetLocalLabel();
                AddCodeLine("ldx (s+)");
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub x,y");
                AddCodeLine("bnz %s", LocalLabelName(L));
                AddCodeLine("sub b,a");
                g_defcodelabel(L);
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr boolugt");
                else
                    AddCodeLine ("jsr boolgt");
                pop (flags);
                return;
        }
    }
}

void g_ge (unsigned flags, unsigned long val)
/* Test for greater than or equal to */
{
    unsigned L;


    /* If the right hand side is const, the lhs is not on stack but still
    ** in the primary register.
    */
    if (flags & CF_CONST) {

        /* Because the handling of the overflow flag is too complex for
        ** inlining, we can handle only unsigned compares, and signed
        ** compares against zero here.
        */
        if (flags & CF_UNSIGNED) {

            /* Give a warning in some special cases */
            if (val == 0) {
                Warning ("Condition is always true");
                AddCodeLine ("jsr return1");
                return;
            }

            /* Look at the type */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        /* Do a subtraction. Condition is true if carry or z set */
                        AddCodeLine("ldbb %d", (unsigned char) val);
                        AddCodeLine("sabb");
                        /* Do not usr clr as it clears carry */
                        AddCodeLine ("jsr booluge");
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    /* Do a subtraction. Condition is true if carry clear */
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                    AddCodeLine ("jsr booluge");
                    return;

                case CF_LONG:
                    L = GetLocalLabel();
                    AddCodeLine("ldb %d", HI(val));
                    AddCodeLine("sab");
                    AddCodeLine("bnz %s", LocalLabelName(L));
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                    g_defcodelabel(L);
                    AddCodeLine ("jsr booluge");
                    return;

                default:
                    typeerror (flags);
            }

        } else if (val == 0) {

            /* A signed compare against zero must only look at the sign bit */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        AddCodeLine ("slrb al");
                        AddCodeLine ("ldab 0; noopt");
                        AddCodeLine ("rlrb al");
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    /* Just test the high byte */
                    AddCodeLine ("slrb ah");
                    AssignA(0, 1);
                    AddCodeLine ("rlrb al");
                    return;

                case CF_LONG:
                    AddCodeLine ("xfr y,b");
                    AddCodeLine ("slrb bh");
                    AssignA(0, 1);
                    AddCodeLine ("rlrb al");
                    return;

                default:
                    typeerror (flags);
            }

        } else {

            /* Signed compare against a constant != zero */
            switch (flags & CF_TYPEMASK) {

                case CF_CHAR:
                    if (flags & CF_FORCECHAR) {
                        AddCodeLine("ldbb %d", (unsigned char) val);
                        AddCodeLine("sabb");
                        if (flags & CF_UNSIGNED)
                            AddCodeLine ("jsr booluge");
                        else
                            AddCodeLine ("jsr boolge");
                        return;
                    }
                    /* FALLTHROUGH */

                case CF_INT:
                    /* Do a subtraction */
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr booluge");
                    else
                        AddCodeLine ("jsr boolge");
                    return;

                case CF_LONG:
                    L = GetLocalLabel();
                    AddCodeLine("ldb %d", HI(val));
                    AddCodeLine("sub y,b");
                    AddCodeLine("bnz %s", LocalLabelName(L));
                    AddCodeLine("ldb %d", LO(val));
                    AddCodeLine("sab");
                    g_defcodelabel(L);
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr booluge");
                    else
                        AddCodeLine ("jsr boolge");
                    return;

                default:
                    typeerror (flags);
            }
        }
    }
    else {
        switch (flags & CF_TYPEMASK) {
            case CF_CHAR:
                if (flags & CF_FORCECHAR) {
                    AddCodeLine("ldbb (+s");
                    AddCodeLine("sbbb b,a");
                    if (flags & CF_UNSIGNED)
                        AddCodeLine ("jsr booluge");
                    else
                        AddCodeLine ("jsr boolge");
                    pop (flags);
                    return;
                }
            case CF_INT:
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub b,a");
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr booluge");
                else
                    AddCodeLine ("jsr boolge");
                pop (flags);
                return;
            case CF_LONG:
                L = GetLocalLabel();
                AddCodeLine("ldx (s+)");
                AddCodeLine("ldb (s+)");
                AddCodeLine("sub x,y");
                AddCodeLine("bnz %s", LocalLabelName(L));
                AddCodeLine("sub b,a");
                g_defcodelabel(L);
                if (flags & CF_UNSIGNED)
                    AddCodeLine ("jsr booluge");
                else
                    AddCodeLine ("jsr boolge");
                pop (flags);
                return;
        }
    }
}



/*****************************************************************************/
/*                         Allocating static storage                         */
/*****************************************************************************/


void g_res (unsigned n)
/* Reserve static storage, n bytes */
{
    AddDataLine ("\t.ds\t%u", n);
}



void g_defdata (unsigned flags, unsigned long val, long offs)
/* Define data with the size given in flags */
{
    if (flags & CF_CONST) {

        /* Numeric constant */
        switch (flags & CF_TYPEMASK) {

            case CF_CHAR:
                AddDataLine ("\t.byte\t$%02lX", val & 0xFF);
                break;

            case CF_INT:
                AddDataLine ("\t.word\t$%04X", LO(val));
                break;

            case CF_LONG:
                AddDataLine ("\t.word\t$%04X", HI(val));
                AddDataLine ("\t.word\t$%04X", LO(val));
                break;

            default:
                typeerror (flags);
                break;

        }

    } else {

        /* Create the correct label name */
        const char* Label = GetLabelName (flags, val, offs, 1);

        /* Labels are always 16 bit */
        AddDataLine ("\t.word\t%s", Label);

    }
}



void g_defbytes (const void* Bytes, unsigned Count)
/* Output a row of bytes as a constant */
{
    unsigned Chunk;
    char Buf [128];
    char* B;

    /* Cast the buffer pointer */
    const unsigned char* Data = (const unsigned char*) Bytes;

    /* Output the stuff */
    while (Count) {

        /* How many go into this line? */
        if ((Chunk = Count) > 16) {
            Chunk = 16;
        }
        Count -= Chunk;

        /* Output one line */
        strcpy (Buf, "\t.byte\t");
        B = Buf + 7;
        do {
            B += sprintf (B, "0x%02X", *Data++);
            if (--Chunk) {
                *B++ = ',';
            }
        } while (Chunk);

        /* Output the line */
        AddDataLine ("%s", Buf);
    }
}



void g_zerobytes (unsigned Count)
/* Output Count bytes of data initialized with zero */
{
    if (Count > 0) {
        AddDataLine ("\t.ds\t%u", Count);
    }
}



void g_initregister (unsigned Label, unsigned Reg, unsigned Size)
/* Initialize a register variable from static initialization data */
{
    int offs = 0;
    /* Register variables do always have less than 128 bytes */
    while(Size > 1) {
        Size -= 2;
        LoadA(GetLabelName(CF_STATIC, Label, offs, 0), Size);
        StoreA(GetLabelName(CF_REGVAR, Reg, offs, 0), Size);
        offs += 2;
    }
    if (Size) {
        AddCodeLine("ldab (%s)", GetLabelName(CF_STATIC, Label, offs, 0));
        AddCodeLine("stab (%s)", GetLabelName(CF_REGVAR, Reg, offs, 0));
    }
}


/*
 *	Unlike CC65 we make it our responsibility to make the stack space.
 */
void g_initauto (unsigned Label, unsigned Size)
{
    unsigned CodeLabel = GetLocalLabel ();

    /* Work from end to start pushing bytes */
    AddCodeLine("ldb %d", Size);
    AddCodeLine("ldx %s+%d", GetLabelName (CF_STATIC, Label, 0, 1), Size);

    g_defcodelabel (CodeLabel);

    /* We always have at least one byte */
    /* FIXME: do words first */
    AddCodeLine("ldab (-x)");
    AddCodeLine("stab (-s)");
    AddCodeLine("dcr b");
    AddCodeLine ("bnz %s", LocalLabelName (CodeLabel));

    /* The caller will adjust the stack on the basis we made the pushes */
}



void g_initstatic (unsigned InitLabel, unsigned VarLabel, unsigned Size)
/* Initialize a static local variable from static initialization data */
{
    if (Size <= 8) {
        while(Size > 1) {
            Size -= 2;
            LoadA(GetLabelName(CF_STATIC, InitLabel, 0, 0), Size);
            StoreA(GetLabelName(CF_STATIC, VarLabel, 0, 0), Size);
        }
        if (Size) {
            AddCodeLine("ldab %s", GetLabelName(CF_STATIC, InitLabel, 0, 0));
            AddCodeLine("stab %s", GetLabelName(CF_STATIC, VarLabel, 0, 0));
        }
    } else {
        /* Use the easy way here: memcpy() */
        g_getimmed (CF_STATIC, VarLabel, 0);
        AddCodeLine ("sta (-s)");
        g_getimmed (CF_STATIC, InitLabel, 0);
        AddCodeLine ("sta (-s)");
        g_getimmed (CF_INT | CF_UNSIGNED | CF_CONST, Size, 0);
        AddCodeLine ("sta (-s)");
    }
    AddCodeLine ("jsr %s", GetLabelName (CF_EXTERNAL, (uintptr_t) "memcpy", 0, 0));
    AddCodeLine ("ldb -6");
    AddCodeLine  ("add b,s");
}


/* For one byte registers we end up saving an extra byte. It avoids having
   to touch D so who cares. We don't allow long registers */

void g_save_regvar(int Offset, int Reg, unsigned Size)
{
    /* TODO */
}

void g_restore_regvar(int Offset, int Reg, unsigned Size)
{
    /* TOOD */
}

/*****************************************************************************/
/*                             Switch statement                              */
/*****************************************************************************/



void g_switch (Collection* Nodes, unsigned DefaultLabel, unsigned Depth)
/* Generate code for a switch statement */
{
    unsigned NextLabel = 0;
    unsigned I;

    /* Setup registers and determine which compare insn to use */
    const char* Compare;
    switch (Depth) {
        case 1:
            Compare = "sabb";
            break;
        case 2:
            Compare = "sub ah,bh";
            break;
        case 3:
            Compare = "sub yl,bl";
            break;
        case 4:
            Compare = "sub yh, bh";
            break;
        default:
            Internal ("Invalid depth in g_switch: %u", Depth);
    }

    /* Walk over all nodes */
    for (I = 0; I < CollCount (Nodes); ++I) {

        /* Get the next case node */
        CaseNode* N = CollAtUnchecked (Nodes, I);

        /* If we have a next label, define it */
        if (NextLabel) {
            g_defcodelabel (NextLabel);
            NextLabel = 0;
        }

        /* Do the compare */
        AddCodeLine ("ldb %d", CN_GetValue (N));
        AddCodeLine (Compare);

        /* If this is the last level, jump directly to the case code if found */
        if (Depth == 1) {
            /* Branch if equal */
            g_falsejump (0, CN_GetLabel (N));

        } else {

            /* Determine the next label */
            if (I == CollCount (Nodes) - 1) {
                /* Last node means not found */
                g_truejump (0, DefaultLabel);
            } else {
                /* Jump to the next check */
                NextLabel = GetLocalLabel ();
                g_truejump (0, NextLabel);
            }

            /* Check the next level */
            g_switch (N->Nodes, DefaultLabel, Depth-1);

        }
    }

    /* If we go here, we haven't found the label */
    g_jump (DefaultLabel);
}



/*****************************************************************************/
/*                       Optimizer Hinting                                   */
/*****************************************************************************/

void g_statement(void)
{
    AddCodeLine(";statement");
}

/*****************************************************************************/
/*                       User supplied assembler code                        */
/*****************************************************************************/



void g_asmcode (struct StrBuf* B)
/* Output one line of assembler code. */
{
    AddCodeLine ("%.*s", (int) SB_GetLen (B), SB_GetConstBuf (B));
}
