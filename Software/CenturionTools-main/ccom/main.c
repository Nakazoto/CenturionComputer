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
/*                                  main.c                                   */
/*                                                                           */
/*                             cc65 main program                             */
/*                                                                           */
/*                                                                           */
/*                                                                           */
/* (C) 2000-2015, Ullrich von Bassewitz                                      */
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
#include <stdlib.h>
#include <errno.h>

/* common */
#include "abend.h"
#include "chartype.h"
#include "cmdline.h"
#include "cpu.h"
#include "debugflag.h"
#include "fname.h"
#include "mmodel.h"
#include "print.h"
#include "segnames.h"
#include "strbuf.h"
#include "target.h"
#include "version.h"
#include "xmalloc.h"

/* cc65 */
#include "asmcode.h"
#include "compile.h"
#include "codeopt.h"
#include "error.h"
#include "global.h"
#include "incpath.h"
#include "input.h"
#include "macrotab.h"
#include "output.h"
#include "scanner.h"
#include "segments.h"
#include "standard.h"



/*****************************************************************************/
/*                                   Code                                    */
/*****************************************************************************/



static void Usage (void)
/* Print usage information to stderr */
{
    printf ("Usage: %s [options] file\n"
            "Short options:\n"
            "  -Cl\t\t\t\tMake local variables static\n"
            "  -Dsym[=defn]\t\t\tDefine a symbol\n"
            "  -E\t\t\t\tStop after the preprocessing stage\n"
            "  -I dir\t\t\tSet an include directory search path\n"
            "  -O\t\t\t\tOptimize code\n"
            "  -Oi\t\t\t\tOptimize code, inline more code\n"
            "  -Or\t\t\t\tEnable register variables\n"
            "  -Os\t\t\t\tInline some standard functions\n"
            "  -T\t\t\t\tInclude source as comment\n"
            "  -V\t\t\t\tPrint the compiler version number\n"
            "  -W warning[,...]\t\tSuppress warnings\n"
            "  -d\t\t\t\tDebug mode\n"
            "  -g\t\t\t\tAdd debug info to object file\n"
            "  -h\t\t\t\tHelp (this text)\n"
            "  -j\t\t\t\tDefault characters are signed\n"
            "  -mm model\t\t\tSet the memory model\n"
            "  -o name\t\t\tName the output file\n"
            "  -r\t\t\t\tEnable register variables\n"
            "  -v\t\t\t\tIncrease verbosity\n"
            "\n"
            "Long options:\n"
            "  --add-source\t\t\tInclude source as comment\n"
            "  --bss-name seg\t\tSet the name of the BSS segment\n"
            "  --check-stack\t\t\tGenerate stack overflow checks\n"
            "  --code-name seg\t\tSet the name of the CODE segment\n"
            "  --codesize x\t\t\tAccept larger code by factor x%%\n"
            "  --cpu type\t\t\tSet cpu type (6800, 6803, 6303)\n"
            "  --create-dep name\t\tCreate a make dependency file\n"
            "  --create-full-dep name\tCreate a full make dependency file\n"
            "  --data-name seg\t\tSet the name of the DATA segment\n"
            "  --debug\t\t\tDebug mode\n"
            "  --dep-target target\t\tUse this dependency target\n"
            "  --eagerly-inline-funcs\tEagerly inline some known functions\n"
            "  --help\t\t\tHelp (this text)\n"
            "  --include-dir dir\t\tSet an include directory search path\n"
            "  --inline-stdfuncs\t\tInline some standard functions\n"
            "  --list-warnings\t\tList available warning types for -W\n"
            "  --local-strings\t\tEmit string literals immediately\n"
            "  --register-space b\t\tSet space available for register variables\n"
            "  --register-vars\t\tEnable register variables\n"
            "  --rodata-name seg\t\tSet the name of the RODATA segment\n"
            "  --signed-chars\t\tDefault characters are signed\n"
            "  --standard std\t\tLanguage standard (c89, c99, cc68)\n"
            "  --static-locals\t\tMake local variables static\n"
            "  --verbose\t\t\tIncrease verbosity\n"
            "  --version\t\t\tPrint the compiler version number\n"
            "  --writable-strings\t\tMake string literals writable\n",
            ProgName);
}

static void FileNameOption (const char* Opt, const char* Arg, StrBuf* Name)
/* Handle an option that remembers a file name for later */
{
    /* Cannot have the option twice */
    if (SB_NotEmpty (Name)) {
        AbEnd ("Cannot use option '%s' twice", Opt);
    }
    /* A typo in OptTab[] might allow a NULL Arg */
    if (Arg == 0) {
        Internal ("Typo in OptTab[]; option '%s' should require an argument", Opt);
    }
    /* Remember the file name for later */
    SB_CopyStr (Name, Arg);
    SB_Terminate (Name);
}



static void DefineSym (const char* Def)
/* Define a symbol on the command line */
{
    const char* P = Def;

    /* The symbol must start with a character or underline */
    if (Def [0] != '_' && !IsAlpha (Def [0])) {
        InvDef (Def);
    }

    /* Check the symbol name */
    while (IsAlNum (*P) || *P == '_') {
        ++P;
    }

    /* Do we have a value given? */
    if (*P != '=') {
        if (*P != '\0') {
            InvDef (Def);
        }
        /* No value given. Define the macro with the value 1 */
        DefineNumericMacro (Def, 1);
    } else {
        /* We have a value, P points to the '=' character. Since the argument
        ** is const, create a copy and replace the '=' in the copy by a zero
        ** terminator.
        */
        char* Q;
        unsigned Len = strlen (Def)+1;
        char* S = (char*) xmalloc (Len);
        memcpy (S, Def, Len);
        Q = S + (P - Def);
        *Q++ = '\0';

        /* Define this as a macro */
        DefineTextMacro (S, Q);

        /* Release the allocated memory */
        xfree (S);
    }
}



static void CheckSegName (const char* Seg)
/* Abort if the given name is not a valid segment name */
{
    /* Print an error and abort if the name is not ok */
    if (!ValidSegName (Seg)) {
        AbEnd ("Segment name '%s' is invalid", Seg);
    }
}



static void OptAddSource (const char* Opt attribute ((unused)),
                          const char* Arg attribute ((unused)))
/* Add source lines as comments in generated assembler file */
{
    AddSource = 1;
}



static void OptBssName (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the --bss-name option */
{
    /* Check for a valid name */
    CheckSegName (Arg);

    /* Set the name */
    SetSegName (SEG_BSS, Arg);
}



static void OptCheckStack (const char* Opt attribute ((unused)),
                           const char* Arg attribute ((unused)))
/* Handle the --check-stack option */
{
    IS_Set (&CheckStack, 1);
}



static void OptCodeName (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the --code-name option */
{
    /* Check for a valid name */
    CheckSegName (Arg);

    /* Set the name */
    SetSegName (SEG_CODE, Arg);
}



static void OptCodeSize (const char* Opt, const char* Arg)
/* Handle the --codesize option */
{
    unsigned Factor;
    char     BoundsCheck;

    /* Numeric argument expected */
    if (sscanf (Arg, "%u%c", &Factor, &BoundsCheck) != 1 ||
        Factor < 0 || Factor > 1000) {
        AbEnd ("Argument for %s is invalid", Opt);
    }
    IS_Set (&CodeSizeFactor, Factor);
}



static void OptCreateDep (const char* Opt, const char* Arg)
/* Handle the --create-dep option */
{
    FileNameOption (Opt, Arg, &DepName);
}



static void OptCreateFullDep (const char* Opt attribute ((unused)),
                              const char* Arg)
/* Handle the --create-full-dep option */
{
    FileNameOption (Opt, Arg, &FullDepName);
}



static void OptCPU (const char* Opt, const char* Arg)
/* Handle the --cpu option */
{
    /* Find the CPU from the given name */
    CPU = FindCPU (Arg);
    if (CPU != CPU_4 && CPU != CPU_6) {
        AbEnd ("Invalid argument for %s: '%s'", Opt, Arg);
    }
}



static void OptDataName (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the --data-name option */
{
    /* Check for a valid name */
    CheckSegName (Arg);

    /* Set the name */
    SetSegName (SEG_DATA, Arg);
}



static void OptDebug (const char* Opt attribute ((unused)),
                      const char* Arg attribute ((unused)))
/* Compiler debug mode */
{
    ++Debug;
}



static void OptDepTarget (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the --dep-target option */
{
    FileNameOption (Opt, Arg, &DepTarget);
}



static void OptEagerlyInlineFuncs (const char* Opt attribute((unused)),
                                   const char* Arg attribute((unused)))
/* Eagerly inline some known functions */
{
    IS_Set (&InlineStdFuncs, 1);
    IS_Set (&EagerlyInlineFuncs, 1);
}



static void OptHelp (const char* Opt attribute ((unused)),
                     const char* Arg attribute ((unused)))
/* Print usage information and exit */
{
    Usage ();
    exit (EXIT_SUCCESS);
}



static void OptIncludeDir (const char* Opt attribute ((unused)), const char* Arg)
/* Add an include search path */
{
    AddSearchPath (SysIncSearchPath, Arg);
    AddSearchPath (UsrIncSearchPath, Arg);
}



static void OptInlineStdFuncs (const char* Opt attribute((unused)),
                               const char* Arg attribute((unused)))
/* Inline some standard functions */
{
    IS_Set (&InlineStdFuncs, 1);
}



static void OptListWarnings (const char* Opt attribute ((unused)),
                             const char* Arg attribute ((unused)))
/* List all warning types */
{
    /* List the warnings */
    ListWarnings (stdout);

    /* Terminate */
    exit (EXIT_SUCCESS);
}



static void OptLocalStrings (const char* Opt attribute ((unused)),
                             const char* Arg attribute ((unused)))
/* Emit string literals immediately */
{
    IS_Set (&LocalStrings, 1);
}



static void OptRegisterSpace (const char* Opt, const char* Arg)
/* Handle the --register-space option */
{
    /* Numeric argument expected */
    if (sscanf (Arg, "%u", &RegisterSpace) != 1 || RegisterSpace > 256) {
        AbEnd ("Argument for option %s is invalid", Opt);
    }
}



static void OptRegisterVars (const char* Opt attribute ((unused)),
                             const char* Arg attribute ((unused)))
/* Handle the --register-vars option */
{
    IS_Set (&EnableRegVars, 1);
}



static void OptRodataName (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the --rodata-name option */
{
    /* Check for a valid name */
    CheckSegName (Arg);

    /* Set the name */
    SetSegName (SEG_RODATA, Arg);
}



static void OptSignedChars (const char* Opt attribute ((unused)),
                            const char* Arg attribute ((unused)))
/* Make default characters signed */
{
    IS_Set (&SignedChars, 1);
}



static void OptStandard (const char* Opt, const char* Arg)
/* Handle the --standard option */
{
    /* Find the standard from the given name */
    standard_t Std = FindStandard (Arg);
    if (Std == STD_UNKNOWN) {
        AbEnd ("Invalid argument for %s: '%s'", Opt, Arg);
    } else if (IS_Get (&Standard) != STD_UNKNOWN) {
        AbEnd ("Option %s given more than once", Opt);
    } else {
        IS_Set (&Standard, Std);
    }
}



static void OptStaticLocals (const char* Opt attribute ((unused)),
                             const char* Arg attribute ((unused)))
/* Place local variables in static storage */
{
    IS_Set (&StaticLocals, 1);
}



static void OptVerbose (const char* Opt attribute ((unused)),
                        const char* Arg attribute ((unused)))
/* Increase verbosity */
{
    ++Verbosity;
}



static void OptVersion (const char* Opt attribute ((unused)),
                        const char* Arg attribute ((unused)))
/* Print the compiler version */
{
    fprintf (stderr, "%s V%s\n", ProgName, GetVersionAsString ());
    exit (EXIT_SUCCESS);
}



static void OptWarning (const char* Opt attribute ((unused)), const char* Arg)
/* Handle the -W option */
{
    StrBuf W = AUTO_STRBUF_INITIALIZER;

    /* Arg is a list of suboptions, separated by commas */
    while (Arg) {

        const char* Pos;
        int         Enabled = 1;
        IntStack*   S;

        /* The suboption may be prefixed with '-' or '+' */
        if (*Arg == '-') {
            Enabled = 0;
            ++Arg;
        } else if (*Arg == '+') {
            /* This is the default */
            ++Arg;
        }

        /* Get the next suboption */
        Pos = strchr (Arg, ',');
        if (Pos) {
            SB_CopyBuf (&W, Arg, Pos - Arg);
            Arg = Pos + 1;
        } else {
            SB_CopyStr (&W, Arg);
            Arg = 0;
        }
        SB_Terminate (&W);

        /* Search for the warning */
        S = FindWarning (SB_GetConstBuf (&W));
        if (S == 0) {
            InvArg (Opt, SB_GetConstBuf (&W));
        }
        IS_Set (S, Enabled);
    }

    /* Free allocated memory */
    SB_Done (&W);
}



static void OptWritableStrings (const char* Opt attribute ((unused)),
                                const char* Arg attribute ((unused)))
/* Make string literals writable */
{
    IS_Set (&WritableStrings, 1);
}



int main (int argc, char* argv[])
{
    /* Program long options */
    static const LongOpt OptTab[] = {
        { "--add-source",           0,      OptAddSource            },
        { "--bss-name",             1,      OptBssName              },
        { "--check-stack",          0,      OptCheckStack           },
        { "--code-name",            1,      OptCodeName             },
        { "--codesize",             1,      OptCodeSize             },
        { "--cpu",                  1,      OptCPU                  },
        { "--create-dep",           1,      OptCreateDep            },
        { "--create-full-dep",      1,      OptCreateFullDep        },
        { "--data-name",            1,      OptDataName             },
        { "--debug",                0,      OptDebug                },
        { "--dep-target",           1,      OptDepTarget            },
        { "--eagerly-inline-funcs", 0,      OptEagerlyInlineFuncs   },
        { "--help",                 0,      OptHelp                 },
        { "--include-dir",          1,      OptIncludeDir           },
        { "--inline-stdfuncs",      0,      OptInlineStdFuncs       },
        { "--list-warnings",        0,      OptListWarnings         },
        { "--local-strings",        0,      OptLocalStrings         },
        { "--register-space",       1,      OptRegisterSpace        },
        { "--register-vars",        0,      OptRegisterVars         },
        { "--rodata-name",          1,      OptRodataName           },
        { "--signed-chars",         0,      OptSignedChars          },
        { "--standard",             1,      OptStandard             },
        { "--static-locals",        0,      OptStaticLocals         },
        { "--verbose",              0,      OptVerbose              },
        { "--version",              0,      OptVersion              },
        { "--writable-strings",     0,      OptWritableStrings      },
    };

    unsigned I;

    /* Initialize the input file name */
    const char* InputFile  = 0;

    /* Initialize the cmdline module */
    InitCmdLine (&argc, &argv, "cc68");

    /* Initialize the default segment names */
    InitSegNames ();

    /* Initialize the include search paths */
    InitIncludePaths ();

    /* Parse the command line */
    I = 1;
    while (I < ArgCount) {

        const char* P;

        /* Get the argument */
        const char* Arg = ArgVec[I];

        /* Check for an option */
        if (Arg[0] == '-') {

            switch (Arg[1]) {

                case '-':
                    LongOption (&I, OptTab, sizeof(OptTab)/sizeof(OptTab[0]));
                    break;

                case 'd':
                    OptDebug (Arg, 0);
                    break;

                case 'h':
                case '?':
                    OptHelp (Arg, 0);
                    break;

                case 'j':
                    OptSignedChars (Arg, 0);
                    break;

                case 'o':
                    SetOutputName (GetArg (&I, 2));
                    break;

                case 'r':
                    OptRegisterVars (Arg, 0);
                    break;

                case 'u':
                    OptCreateDep (Arg, 0);
                    break;

                case 'v':
                    OptVerbose (Arg, 0);
                    break;

                case 'C':
                    P = Arg + 2;
                    while (*P) {
                        switch (*P++) {
                            case 'l':
                                OptStaticLocals (Arg, 0);
                                break;
                            default:
                                UnknownOption (Arg);
                                break;
                        }
                    }
                    break;

                case 'D':
                    DefineSym (GetArg (&I, 2));
                    break;

                case 'E':
                    PreprocessOnly = 1;
                    break;

                case 'I':
                    OptIncludeDir (Arg, GetArg (&I, 2));
                    break;

                case 'O':
                    IS_Set (&Optimize, 1);
                    P = Arg + 2;
                    while (*P) {
                        switch (*P++) {
                            case 'i':
                                IS_Set (&CodeSizeFactor, 200);
                                break;
                            case 'r':
                                IS_Set (&EnableRegVars, 1);
                                break;
                            case 's':
                                IS_Set (&InlineStdFuncs, 1);
                                break;
                            default:
                                UnknownOption (Arg);
                                break;
                        }
                    }
                    break;

                case 'T':
                    OptAddSource (Arg, 0);
                    break;

                case 'V':
                    OptVersion (Arg, 0);
                    break;

                case 'W':
                    OptWarning (Arg, GetArg (&I, 2));
                    break;

                default:
                    UnknownOption (Arg);
                    break;
            }
        } else {
            if (InputFile) {
                fprintf (stderr, "additional file specs ignored\n");
            } else {
                InputFile = Arg;
            }
        }

        /* Next argument */
        ++I;
    }

    /* Did we have a file spec on the command line? */
    if (InputFile == 0) {
        AbEnd ("No input files");
    }

    /* Add the default include search paths. */
    FinishIncludePaths ();

    /* Create the output file name if it was not explicitly given */
    MakeDefaultOutputName (InputFile);

    /* If no CPU given, use the default CPU for the target */
    if (CPU == CPU_UNKNOWN) {
            CPU = CPU_6;
    }

    /* If no language standard was given, use the default one */
    if (IS_Get (&Standard) == STD_UNKNOWN) {
        IS_Set (&Standard, STD_DEFAULT);
    }

    /* Go! */
    Compile (InputFile);

    /* Create the output file if we didn't had any errors */
    if (PreprocessOnly == 0 && (ErrorCount == 0 || Debug)) {

        /* Emit literals, externals, do cleanup and optimizations */
        FinishCompile ();

        /* Open the file */
        OpenOutputFile ();

        /* Write the output to the file */
        WriteAsmOutput ();
        Print (stdout, 1, "Wrote output to '%s'\n", OutputFilename);

        /* Close the file, check for errors */
        CloseOutputFile ();

        /* Create dependencies if requested */
        CreateDependencies ();
    }

    /* Return an apropriate exit code */
    return (ErrorCount > 0)? EXIT_FAILURE : EXIT_SUCCESS;
}
