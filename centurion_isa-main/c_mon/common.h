#pragma once

#include <stddef.h>

typedef unsigned char u8;
typedef unsigned short u16;
typedef char s8;
typedef short s16;

#define MAX_LINE_SIZE 80

// globals
extern char buffer[MAX_LINE_SIZE + 2];
extern char* buffer_ptr;
extern u8 pass;
extern u16 dest_addr;

#define PEEK_CHAR       (*buffer_ptr)
#define POP_CHAR        (*(buffer_ptr++))
#define RETURN_CHAR(x)  do { buffer_ptr -= x; } while (0)
#define BUF_OFFSET      (buffer_ptr - buffer)

void error(const char* msg);
void consume_whitespace();
void write_byte(u8 val);