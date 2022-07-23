/*
 *	A simple dead label and jump cleanup. This is very basic, we don't
 *	collect blocks of code into a graph we just kill the obvious dangly
 *	bits. Feel free to write a contribute a graph based one.
 *
 *	Do a pass over the assembler killing any dead labels and trying
 *	to adjust some easy cases
 *
 *	(C) 202 Alan Cox, GPL v3
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* True if this instruction is the end of a block */
int is_terminal(const char *p)
{
    if (strncmp(p, "\trts", 4) == 0 || strncmp(p, "\tjmp", 4) == 0)
        return 1;
    return 0;
}

/* True if this is a local label definition */
int is_label(const char *p, unsigned *l)
{
    if (*p != 'L')
        return 0;
    *l = strtoul(p + 1, NULL, 16);
    return 1;
}

/* True if this is an unconditional jump */
int is_jmp(const char *p)
{
    if (strncmp(p, "\tjmp ", 5) == 0)
        return 1;
    if (strncmp(p, "\tjra ", 5) == 0)
        return 1;
    return 0;
}

/* Consumber of a local label */
int is_jbra(const char *p, unsigned *l)
{
    if (*p == '\t' && p[1] == 'j' && p[4] == ' ' && p[5] == 'L') {
        *l = strtoul(p + 6, NULL, 16);
        return 1;
    }
    return 0;
}

/* Assembler comments and meta-foo */
static int is_meta(const char *p)
{
    if (*p == '\t' && (p[1] == '.' || p[1] == ';'))
        return 1;
    if (*p == ';')
        return 1;
    if (*p == 0)
        return 1;
    return 0;
}

/* Track all the labels, remember if they are seen and also remember any
   cases of a label that has a terminal before it and is just an unconditional
   jump so we can unpick a layer of branching */

struct label
{
    unsigned val;
    struct label *next;
    int flags;
    char *replace;
};

#define L_USED		1		/* Conditional ref */
#define L_USEDNC	2		/* Unconditional ref */

struct label *labels;

/* Probably should be done better but we don't have that many labels per
   file... */

struct label *lookup(unsigned val)
{
    struct label *l = labels;
    while(l) {
        if (l->val == val)
            return l;
        l = l->next;
    }    
    l = malloc(sizeof(struct label));
    if (l == NULL) {
        fprintf(stderr, "Out of memory.\n");
        exit(1);
    }
    l->replace = NULL;
    l->flags = 0;
    l->next = labels;
    l->val = val;
    labels = l;
    return l;
}

/* Pass 1: we saw a reference to this label */

void mark_used(unsigned val, int f)
{
    struct label *l = lookup(val);
    l->flags |= f;
}

/* Pass 1: saw a definition */
struct label *define_label(unsigned val)
{
    return lookup(val);
}


void pass1(FILE *in)
{
    char *p;
    unsigned l;
    struct label *lp;
    char buf[512];
    int terminal = 1;

    while((p = fgets(buf, 512, in)) != NULL) {
        if (is_meta(p))
            continue;
        if (is_label(p, &l)) {
            lp = define_label(l);
            p = fgets(buf, 512, in);
            if (p == NULL)
                break;
            if (is_jmp(p) && terminal)
                lp->replace = strdup(p + 4);
        }
        if (is_jbra(p, &l)) {
            if (is_jmp(p))
                mark_used(l, L_USEDNC);
            else
                mark_used(l, L_USED);
        }
        if (is_terminal(p))
            terminal = 1;
        else
            terminal = 0;
    }
}


void pass2(FILE *in)
{
    char *p;
    unsigned l;
    struct label *lp;
    char buf[512];

    while((p = fgets(buf, 512, in)) != NULL) {
        if (is_label(p, &l)) {
            lp = lookup(l);
            /* Do we need to output it ?
               L_USED: yes, L_USEDNC only if not replaceable */
            if (!((lp->flags & L_USED) || ((lp->flags & L_USEDNC) && lp->replace == NULL)))
                continue;
        }
        if (is_jbra(p, &l)) {
            lp = lookup(l);
            if (lp && lp->replace) {
                printf("%%replacing L%04X with %s.\n", l, lp->replace);
                strcpy(p + 5, lp->replace);
            }
        }
        fputs(buf, stdout);
    }
}

int main(int argc, char *argv[])
{
    FILE *in;

    if (argc != 2) {
        fprintf(stderr, "killdeadlabel infile.\n");
        exit(1);
    }
    
    in = fopen(argv[1], "r");
    if (in == NULL) {
        perror(argv[1]);
        exit(1);
    }
    pass1(in);
    rewind(in);
    pass2(in);
    fclose(in);
    return 0;
}
