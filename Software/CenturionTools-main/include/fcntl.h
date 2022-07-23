#ifndef _FCNTL_H
#define _FCNTL_H

#include <sys/types.h>

/* These happen to match Fuzix but for our purposes are arbitrary numbers
   to be mapped by the per target I/O support */

#define O_RDONLY        0
#define O_WRONLY        1
#define O_RDWR          2
#define O_ACCMODE	3

#define O_APPEND	4
#define O_SYNC		8
#define O_NDELAY	16
#define O_CREAT		256
#define O_EXCL		512
#define O_TRUNC		1024
#define O_NOCTTY	2048
#define O_CLOEXEC	4096
#define O_SYMLINK	8192
#define O_BINARY	16384	/* Doesn't match Fuzix but doesn't matter */

#define O_NONBLOCK	O_NDELAY

#ifndef SEEK_SET
#define SEEK_SET 0
#define SEEK_CUR 1
#define SEEK_END 2
#endif

#endif

