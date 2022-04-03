#include "reg.h"

static char regs[16] = "wxyzrtklmnspghij";

u8 parse_reg(u8 word) {
    char *idx = regs;
    char c = POP_CHAR;

    for (u8 i = 0; ; i++) {
        if (c == *idx++) {
            break;
        }
        if (i > 15) {
            error("Invalid register");
            return 0;
        }
    }


    if (word) {
        if (POP_CHAR != *idx) {
            error("Invalid 16bit register");
            return 0;
        }
    }
    idx--;
    return idx - regs;
}

s16 maybe_parse_reg(u8 word) {
    char *idx = regs;
    char c = POP_CHAR;

    for (u8 i = 0; ; i++) {
        if (c == *idx++) {
            break;
        }
        if (i > 15) {
            RETURN_CHAR(1);
            return -1;
        }
    }

    if (word) {
        if (POP_CHAR != *idx) {
            RETURN_CHAR(2);
            return -1;
        }
    }
    idx--;
    return idx - regs;
}
