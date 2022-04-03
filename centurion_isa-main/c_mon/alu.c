#include "alu.h"
#include "reg.h"

static u8 alu_implicit_operand[4] = { 0x10, 0x00, 0x31, 0x20 };

void parse_alu(u8 offset) {
    if (POP_CHAR != '.'){
        error("invalid nmemonic");
        return;
    }
    char c = POP_CHAR;
    if (c != 'b' && c != 'w') {
        error("invalid nmemonic");
        return;
    }
    u8 word = (c == 'w');

    u8 opcode;
    u8 implicit_operand;
    if (offset >= 8) {
        implicit_operand = 0x31;
        opcode = 0x40 | (offset - 8) | word << 4;
    } else {
        implicit_operand = 0x10;
        opcode = 0x20 | offset | word << 4;
    }

    // a '*' suffix means we force the operand to be explicit even if it could be encoded as implicit
    u8 explict = 0;
    c = PEEK_CHAR;
    if (c == '*') {
        explict = 1;
        POP_CHAR;
    } else if (c == '!') {
        goto implicit;
    }

    consume_whitespace();

    u8 src = parse_reg(word);
    u8 operend = src << 4;

    if (offset >= 8) {
        if (POP_CHAR != ',') {
            error("expected comma");
            return;
        }
        consume_whitespace();
        u8 dest = parse_reg(word);
        operend |= dest;
    }

    if (word) {
        // implicit word operands are just the same as implcit byte operands without
        // the lower bits of each nibble set
        implicit_operand &= 0xee;
    }

    if (!explict && operend == implicit_operand) {
implicit:
        // There is a single byte version of this, and we should use it
        write_byte(opcode |= 0x08);
    } else {
        write_byte(opcode);
        write_byte(operend);
    }
}

