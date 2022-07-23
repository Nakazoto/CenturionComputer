/*
 *	CC6303:  A C compiler for the 6803/6303 processors
 *	(C) 2019 Alan Cox
 *
 *	This compiler is built out of a much modified CC65 and all new code
 *	is placed under the same licence as the original. Please direct all
 *	cc6303 bugs to the author not to the cc65 developers unless you find
 *	a bug that is also present in cc65.
 */
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
#include "global.h"
#include "segments.h"
#include "stackptr.h"
#include "textlist.h"
#include "util.h"
#include "codegen.h"


TextList CodeHead = {
    &CodeHead,
    &CodeHead,
    NULL
};

TextList RODataHead = {
    &RODataHead,
    &RODataHead,
    NULL
};

TextList DataHead = {
    &DataHead,
    &DataHead,
    NULL
};

TextList BSSHead = {
    &BSSHead,
    &BSSHead,
    NULL
};

/* ABS and global stuff */
TextList ABSHead = {
    &ABSHead,
    &ABSHead,
    NULL
};

TextList *CodeStack = NULL;

void TextListAppendAfter(TextList *head, const char *text)
{
    TextList *e = xmalloc(sizeof(TextList) + strlen(text) + 1);
    strcpy(e->str, text);
    e->prev = head;
    e->next = head->next;
    head->next->prev = e;
    head->next = e;
}

void TextListAppend(TextList *head, const char *text)
{
    TextListAppendAfter(head->prev, text);
}

static void TextListRemoveOne(TextList *t)
{
    t->prev->next = t->next;
    t->next->prev = t->prev;
}

void TextListRemoveRange(TextList *last, TextList *tail)
{
    while(last->next != tail)
        TextListRemoveOne(last->next);
}

void TextListRemoveTail(TextList *head, TextList *last)
{
    TextListRemoveRange(last, head);
}

void TextListSplice(TextList *at, TextList *start, TextList *end)
{
    /* Unhook the nodes */
    start->prev->next = end->next;
    end->next->prev = start->prev;
    /* Rehook */
    end->next = at->next;
    start->prev = at;
    at->next->prev = end;
    at->next = start;
}

    

/* This is a bit odd. We return a pointer to the last entry, which means
   m->Text for all the code below is really not the current mark but the
   previous to the current mark (we can't return the current text as it
   doesn't yet exist) */

void GetCodePos(CodeMark *m)
{
    m->Text = CodeHead.prev;
    m->SP = StackPtr;
    m->Movable = 0;
}

void GetCodePosMovable(CodeMark *m)
{
    m->Text = CodeHead.prev;
    m->SP = StackPtr;
    m->Movable = 1;
    g_moveable();
}

/* Turn a mark into the right text pointer remembering that the mark
   is the previous pointer */
static TextList *MarkToText(const CodeMark *m)
{
    return m->Text->next;
}


void RemoveCode(const CodeMark *m)
{
    TextListRemoveTail(&CodeHead, MarkToText(m)->prev);
    StackPtr = m->SP;
}

/* Move the code between Start (inclusive) and End (exclusive) to
** (before) Target. The code marks aren't updated.
*/
void MoveCode(const CodeMark *start,  const CodeMark *end, const CodeMark *target)
{
    if (!start->Movable)
       Internal("Moving non-movable block");
    TextListSplice(MarkToText(target)->prev, MarkToText(start), MarkToText(end)->prev);
}

void AppendCode(const char *txt)
{
    TextListAppend(&CodeHead, txt);
}

void PrintCode(void)
{
    TextList *t = CodeHead.next;
    if (CodeStack)
        Internal("Botched codestack");
    printf("\t.%s\n", GetSegName(SEG_CODE));
    while(t != &CodeHead) {
        if (strchr(t->str, ':') == NULL)
            printf("\t");
        printf("%s\n", t->str);
        t = t->next;
    }
    TextListRemoveRange(&CodeHead, &CodeHead);
}

static void DumpCode(char *info, TextList *t)
{
#if 0
    int n = 0;
    TextList *p = t->next;
    fprintf(stderr, "%s: \n", info);
    while(n++ < 10 && p != t) {
     fprintf(stderr, "|%s\n", p->str);
     p = p->next;
    }
    fprintf(stderr, "---\n");
#endif
}

void PushCode(void)
{
    TextList *n = xmalloc(sizeof(TextList));
    DumpCode("Pushed ", &CodeHead);
    *n = CodeHead;
    /* Fix back pointers to match the copy instead */
    n->next->prev = n;
    n->prev->next = n;
    n->stack = CodeStack;
    CodeStack = n;
    CodeHead.prev = CodeHead.next = &CodeHead;
}

/* Pop a block of text and place it before the existing text */
void PopCode(void)
{
    TextList *t;
    if (CodeStack == NULL)
        Internal ("code pop without push");
    DumpCode("Popping before ", &CodeHead);
    t = CodeStack;
    DumpCode("With ", t);
    CodeStack = CodeStack->stack;
    /* We restore the stacked code and append the new to it */
    /* Chain the new code onto the old */
    t->prev->next = CodeHead.next;	/* Link the old code onto the end of the stacked */
    CodeHead.next->prev = t->prev;	/* Fix the back pointer */
    CodeHead.next = t->next;		/* Link the popped code to the front */
    t->next->prev = &CodeHead;		/* End the list */
    free(t);
}

/* Pop a block of text and place it afte the existing text */
void PopCodeTail(void)
{
    TextList *t;
    if (CodeStack == NULL)
        Internal ("code pop without push");
    DumpCode("Popping after ", &CodeHead);
    t = CodeStack;
    DumpCode("With ", t);
    CodeStack = CodeStack->stack;
    /* We restore the stacked code and append it to the old */
    /* The stacked code goes at the end */
    CodeHead.prev->next = t->next;	/* Link it onto the end */
    t->next->prev = CodeHead.prev;	/* Fix the back pointer */
    CodeHead.prev = t->prev;		/* Fix the head back pointer */
    t->prev->next = &CodeHead;		/* End of list */
    /* The start of chain pointers are still valid */
    free(t);
}

void AppendROData(const char *txt)
{
    TextListAppend(&RODataHead, txt);
}

void PrintROData(void)
{
    TextList *t = RODataHead.next;
    printf("\t.%s\n",
     GetSegName(SEG_RODATA));	/* No separate rodata in our toolchain so we usually use code */
    while(t != &RODataHead) {
        printf("%s\n", t->str);
        t = t->next;
    }
    TextListRemoveRange(&RODataHead, &RODataHead);
}

void AppendData(const char *txt)
{
    TextListAppend(&DataHead, txt);
}

void PrintData(void)
{
    TextList *t = DataHead.next;
    printf("\t.%s\n",
     GetSegName(SEG_DATA));	/* No separate rodata in our toolchain */
    while(t != &DataHead) {
        printf("%s\n", t->str);
        t = t->next;
    }
    TextListRemoveRange(&DataHead, &DataHead);
}

void AppendBSS(const char *txt)
{
    TextListAppend(&BSSHead, txt);
}


void PrintBSS(void)
{
    TextList *t = BSSHead.next;
    printf("\t.%s\n",
     GetSegName(SEG_BSS));	/* No separate rodata in our toolchain */
    while(t != &BSSHead) {
        printf("%s\n", t->str);
        t = t->next;
    }
    TextListRemoveRange(&BSSHead, &BSSHead);
}

void AppendABS(const char *txt)
{
    TextListAppend(&ABSHead, txt);
}

void PrintABS(void)
{
    TextList *t = ABSHead.next;
    while(t != &ABSHead) {
        printf("%s\n", t->str);
        t = t->next;
    }
    TextListRemoveRange(&ABSHead, &ABSHead);
}
