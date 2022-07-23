#ifndef __STDLIB_H
#define __STDLIB_H
#ifndef __TYPES_H
#include <types.h>
#endif
#include <malloc.h>

/* Don't overwrite user definitions of NULL */
#ifndef NULL
#define NULL ((void *) 0)
#endif

/* For program termination */
#define EXIT_FAILURE 1
#define EXIT_SUCCESS 0

extern void exit(int __status);
extern void abort(void);


#define RAND_MAX	32767

extern int rand(void);
extern void srand(unsigned int __seed);

/* FIXME: the *toa formats are not standard so belong in a private namespace */
/* FIXME: untangle all our excessive ultoa etc variants */
extern char *ultoa(unsigned long __value, char *__strP, int __radix);
extern char *ltoa(long __value, char *__strP, int __radix);

extern int atoi(const char *__nptr);
extern long atol(const char *__nptr);
extern double atof(const char *__nptr);

extern int abs(int __i);
extern long labs(long __i);
extern char *_itoa(int __value);
extern char *_uitoa(unsigned int __value);
extern char *_ltoa(long __value);
extern char *_ultoa(unsigned long __value);

extern char *__ultostr(unsigned long value, int __radix);
extern char *__ltostr(long __value, int __radix);

extern long strtol(const char *__nptr, char **__endptr, int __base);
extern unsigned long strtoul(const char *__nptr,
				   char **__endptr, int __base);


/* FIXME: atexit_t doesn't appear to be a standard type so should __atexit_t ?? */
typedef void (*atexit_t)(void);
extern int atexit(atexit_t __function);

extern char *crypt(char *__key, char *__salt);

typedef int (*cmp_func_t)(const void *__a, const void *__b);

extern int _bsearch;
extern void *bsearch(void *__key, void *__base, size_t __num, size_t __size, cmp_func_t __cmp);
extern void *lfind(void *__key, void *__base, size_t *__num, size_t __size, cmp_func_t __cmp);
extern void *lsearch(const void *__key, const void *__base, size_t *__num, size_t __size, cmp_func_t __cmp);
extern void *_qbuf;
extern void qsort(void *__base, size_t __num, size_t __size, cmp_func_t __cmp);

#define mb_len(a,b)	strnlen(a,b)

#include <getopt.h>

extern unsigned long jrand48(unsigned short __xsubi[3]);
extern void lcong48(unsigned short __param[7]);
extern long lrand48(void);
extern unsigned long mrand48(void);
extern long nrand48(unsigned short __xsubi[3]);
extern unsigned short *seed48(unsigned short __seed16v[3]);
extern void srand48(long __sedval);

/* Target provided */
extern void _exit(int __status);

#endif /* __STDLIB_H */
