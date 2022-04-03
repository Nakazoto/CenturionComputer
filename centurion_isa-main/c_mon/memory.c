
#include "memory.h"
#include "numbers.h"
#include "reg.h"
#include "labels.h"

static void parse_immediate(u8 word) {
    if (word) {
        u16 val = readhex16();
        write_byte(val >> 8);
        write_byte(val & 0xff);
    } else {
        write_byte(readhex8());
    }
}


void parse_mem(u8 store) {
    if (POP_CHAR != '.') {
        error("invalid nmemonic");
        return;
    }
    char c = POP_CHAR;
    if (c != 'b' && c != 'w') {
        error("invalid nmemonic");
        return;
    }
    u8 word = (c == 'w');
    consume_whitespace();

    u8 opcode = (store << 5) | (word << 4);

    // Register
    {
        u8 reg = parse_reg(word);
        if (!word) {
            reg--;
        }

        if (reg == 0) {
            opcode += 0x80;
        } else if (reg == 2) {
            opcode += 0xc0;
        } else if (reg != 4 || opcode != 0x10) {
            error("invalid register for mem op");
            return;
        } else {
            opcode == 0x60;
        }
    }

    if (POP_CHAR != ',') {
        error("expected comma");
        return;
    }
    consume_whitespace();

    // Addressing mode

    c = POP_CHAR;
    u8 index_mode = 0;

    if (c == '#') {
        // immediate
        write_byte(opcode);
        parse_immediate(word);
        return;
    }
    if (c == '-') {
        index_mode = 2;
        c = POP_CHAR;
    }
    //if (c == '@') {

    //}
    if (c == '(') {
        if (PEEK_CHAR == '#'){
            POP_CHAR;
            write_byte(opcode | 1);
            parse_immediate(1);
            return;
        }
        s16 reg = maybe_parse_reg(1);
        if (reg >= 0) {

        } else {
            u16 addr = match_label(0);
            write_byte(addr >> 8);
            write_byte(addr & 0xff);
            return;
        }


        if (POP_CHAR != ')') {
            error("expected )");
            return;
        }
        if (PEEK_CHAR == '+' && index_mode == 0) {
            POP_CHAR;
            index_mode = 1;
        }

        if (index_mode == 0) {
            // single byte index mode
            write_byte(opcode | 0x08 | (reg >> 1));
        } else {
            write_byte(opcode | 5);
            write_byte(reg << 4 | index_mode);
        }
        return;
    } else {
        RETURN_CHAR(1);
        // label immediate
        write_byte(opcode);
        u16 addr = match_label(0);
        write_byte(addr >> 8);
        write_byte(addr & 0xff);
        return;
    }
    error("invalid addressing mode");
}