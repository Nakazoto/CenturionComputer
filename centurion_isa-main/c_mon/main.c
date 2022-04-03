/*****
 * Monitor Prototype:
 * This is the c prototype of a monitor (with assembler and disassembler)
 * that is intended to be hand-translated into assembly. So the code isn't
 * very pretty c, the code is designed for low memory use, smallis code size
 * and makes use of goto at times.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>

#include "common.h"

#include "labels.h"
#include "instruction.h"


// Globals
char buffer[MAX_LINE_SIZE + 2];
char* buffer_ptr;

u8 mem[0x10000];
u16 dest_addr = 0x2000;
u8* dest = &mem[0x2000];
u8 instruction_bytes = 0;

u8 pass = 0;

jmp_buf error_jmp;

void write_byte(u8 val) {
    *dest = val;
    dest++;
    dest_addr++;
    instruction_bytes++;
}

// error:
// Halts the assembly process and prints out an error message.
void error(const char* msg) {
    // Print out the current line
    printf("%s", buffer);

    // Print out a marker showing position in line
    while (--buffer_ptr != buffer) {
        printf(" ");
    }
    printf("^\n");

    // Print error text
    printf("Error: %s\r\n", msg);

    dest -= instruction_bytes;
    dest_addr -= instruction_bytes;
    instruction_bytes = 0;

    // Jumps out of the current assembly process
    longjmp(error_jmp, 1);
}

void consume_whitespace() {
    // Loop until we find a non-whitespace character
    while (PEEK_CHAR == ' ' || PEEK_CHAR == '\t') {
        POP_CHAR;
    }
}

void assembleline() {
    // First, check for label
    u8 length = is_label();
    if (length) {
        if (pass == 1) {
            add_label(length);
        }
        else {
            printf("\n%s", buffer);
        }
        return;
    }

    instruction_bytes = 0;
    buffer_ptr = buffer;

    consume_whitespace();

    if (PEEK_CHAR == ';' || PEEK_CHAR == '\n') {
        // This line has no instruction
        return;
    }

    instruction();

    u8 comment = 0;

    while (1) {
        char c = POP_CHAR;
        if (c == ';' || c == '\n' || c == '!') {
            break;
        }

        if (c == ' ' || c == '\t') {
            continue;
        } else {
            error("unexpected char after instruction");
            return;
        }
    }

    if (pass == 1) {
        return;
    }

    // Print listing

    printf("%04x: ", dest_addr - instruction_bytes);
    u8 i = 0;
    for (;i < instruction_bytes; i++) {
        printf("%02x ", mem[dest_addr - instruction_bytes + i]);
    }
    while (i++ < 4) {
        printf("   ");
    }
    printf("%s", buffer);
}

void assembler_pass(FILE* fp) {
    dest_addr = 0x2000;
    dest = &mem[dest_addr];

    u8 running = 1;
    while (running) {
        // Read a line
        u8* dest = buffer;
        u8 count = MAX_LINE_SIZE;
        while (count--) {
            int c = fgetc(fp);
            if (c == -1 || c == 3) {
                running = 0;
                return;
            }
            if (c == '\n') {
                break;
            }
            // Convert to lowercase
            if (c >= 'A' && c <= 'Z') {
                c += 'a' - 'A';
            }
            *dest++ = c;
        }

        if (count == 0) {
            error("line too long");
            return;
        }

        // terminate the line
        *dest++ = '\n';
        *dest++ = '\0';
        //printf("%s", buffer);

        assembleline();
    }
    return;
}

int assembler(const char* filename) {
    if (setjmp(error_jmp)) {
        return -1;
    }

    FILE* fp = fopen(filename, "r");
    init_labels();

    // First pass, doesn't know about forwards labels
    pass = 1;
    assembler_pass(fp);

    // rewind to start of file
    rewind(fp);

    // Same as the first, but knows about forwards targets
    pass = 2;
    assembler_pass(fp);
    fclose(fp);

    return 0;
}


int main(int argc, char **argv) {
    if (argc > 2 && strcmp(argv[1], "assemble") == 0) {
        return assembler(argv[2]);
    } else {
        printf("Usage: %s assemble filename\n", argv[0]);
    }
    return -1;
}
