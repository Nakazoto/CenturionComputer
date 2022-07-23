#ifndef __MALLOC_H
#define __MALLOC_H
#ifndef __TYPES_H
#include <types.h>
#endif

extern void free(void *__ptr);
extern void *malloc(size_t __size);
extern void *realloc(void *__ptr, size_t __size);
extern void *calloc(size_t __nmemb, size_t __size);

#ifdef _MALLOC_PRIVATE
/* We assume this is a suitable alignment for anything. Must be such that
   BLKSIZE is an exact divide */
struct memh {
    struct memh *next;
    size_t size;
};

extern struct memh __mroot;
extern struct memh *__mfreeptr;

#define MH(p)	(((struct memh *)(p)) - 1)
#define BRKSIZE	(512 / sizeof(struct memh))

#endif

#endif
