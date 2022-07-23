#ifndef __UNISTD_H
#define __UNISTD_H
#ifndef __TYPES_H
#include <types.h>
#endif
#ifndef _STDIO_H
#include <stdio.h>
#endif

#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif

#define STDIN_FILENO	0
#define STDOUT_FILENO	1
#define STDERR_FILENO	2

extern void swab(const void * __from, void * __to, ssize_t __count);

#ifndef __STDLIB_H
extern void exit(int __status);
#endif

extern int open(const char *path, int flags, ...);
extern int close(int fd);
extern ssize_t read(int fd, void *buf, int len);
extern ssize_t write(int fd, const void *buf, int len);
extern off_t lseek(int fd, off_t off, int from);

extern int remove(const char *path);
extern int rename(const char *path, const char *newpath);

extern int brk(void *p);
extern void *sbrk(intptr_t n);

#endif /* __UNISTD_H */
