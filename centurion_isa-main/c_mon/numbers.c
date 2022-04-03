

#include "numbers.h"

#include <stdlib.h>

u8 readint8() {
    char* end_ptr = NULL;
    int val = strtol(buffer_ptr, &end_ptr, 10);
    if (end_ptr == buffer_ptr) {
        error("Expected number");
        return 0;
    }
    if (val > 0x7f || val < -0x80) {
        error("Too large");
        return 0;
    }

    buffer_ptr = end_ptr;
    return val;
}

u8 readhex8() {
    char* end_ptr = NULL;
    unsigned int val = strtol(buffer_ptr, &end_ptr, 16);
    if (end_ptr == buffer_ptr) {
        error("Expected hex number");
        return 0;
    }
    if (val > 0xff) {
        error("Too large");
        return 0;
    }

    buffer_ptr = end_ptr;
    return val;
}

u16 readhex16() {
    char* end_ptr = NULL;
    unsigned int val = strtol(buffer_ptr, &end_ptr, 16);
    if (end_ptr == buffer_ptr) {
        error("Expected hex number");
        return 0;
    }
    if (val > 0xffff) {
        error("Too large");
        return 0;
    }

    buffer_ptr = end_ptr;
    return val;
}