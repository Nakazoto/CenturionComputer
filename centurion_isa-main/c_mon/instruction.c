
#include "common.h"
#include "alu.h"
#include "memory.h"
#include "numbers.h"
#include "labels.h"

#define NUM_MNEMONICS 56
// mnemonics_table, 168 bytes
// This table is 3 chars per mnemonic, with nothing between them
// a null byte can be used as a wildcard
static char mnemonics[NUM_MNEMONICS*3]  =
    // Flag manipulate instructions, 00-07
    "hlt" "nop" "fsn" "fcn" "fsi" "fci" "fsc" "fcc"
    // misc instructions  08-0f
    "fca" "ret" "rti" "???" "???" "???" "dly" "???"
    // branch instructions 10-1f
    "bcs" "bcc" "bns" "bnc" "bz\0" "bnz" "blt" "ble"
    "bgt" "bge" "bs0" "bs1" "bs2" "bs3" "bs4" "bs5"
    // One arg ALU instructions 20-3f
    "inc" "dec" "clr" "not" "srl" "sll" "rrc" "rlc"
    // Two arg ALU instructions 40-5f
    "add" "sub" "and" "or\0" "xor" "mov" "???" "???"
    // all remaining instructions
    "ld\0" "st\0" "jmp" "cal" "sys"
    // Declare data pseudo-instructions
    "db\0" "dw\0" "ds\0"
;

#define SIMPLE_END 0x10
#define BRANCH_END 0x20
#define ALU_START  0x20
#define ALU_END    0x30

static u8 scan_mnemonic_table() {
    register u8 count = 0;
    register char* index = mnemonics;
    while (count < NUM_MNEMONICS) {
        register u8 i = 0;
        while (1) {
            char c = *(index++);
            if (i == 3 || c == '\0') {
                buffer_ptr += i;
                return count;
            }
            if (c != buffer_ptr[i]) {
                index += 2 - i;
                goto next;
            }
            i++;
        }
        return count;

    next:
        count++;
    }

    // In assembly version, set a flag to indicate no match
    return 0xff;
}



void parse_offset_arg() {
    consume_whitespace();

    char c = PEEK_CHAR;
    if (c == '-' || c == '+') {
        buffer[0] = c;
        write_byte(readint8());
        return;
    }

    u16 target;

    if (c == '#') {
        POP_CHAR;
        target = readhex16();
    } else {
        target = match_label();
    }

    s16 offset = target - (dest_addr + 1);
    if (offset <= 0x7f && offset >= -0x80) {
        write_byte(offset);
    } else {
        if (pass == 2)
            error("Target too far");
    }
}

void instruction() {
    u8 offset = scan_mnemonic_table();
    if (offset < BRANCH_END) {
        // For these, their offset in their table is their opcode
        u8 opcode = offset;
        write_byte(opcode);

        if (opcode < SIMPLE_END) {
            // These don't have any arugments, we are finished;
            return;
        } else {
            // These are branch instructions that take an offset
            parse_offset_arg();
            return;
        }

    }
    if (offset < ALU_END) {
        parse_alu(offset - ALU_START);
        return;
    }
    if (offset < (ALU_END + 2)) {
        parse_mem((offset - (ALU_END + 2)) & 1);
        return;
    }

    error("Unknown mnemonic");
}