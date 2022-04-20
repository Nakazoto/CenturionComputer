#include "common.h"



u8 labels[4096];
u8* next_label;

u8 is_label() {
    for (u8 i=0; i<80; i++) {
        char c = buffer[i];
        if (c == ':') {
            return i-1;
        }

        if (c < 'A') {
            return 0;
        }
    }
    return 0;
}

void add_label(u8 length) {
    if (((next_label - labels) + length + 4) >= sizeof(labels)) {
        error("Too many labels");
    }

    for(int i=0; i<=length; i++) {
        *(next_label++) = buffer[i];
    }
    *(next_label++) = '\0';
    *(next_label++) = dest_addr >> 8;
    *(next_label++) = dest_addr & 0xff;
    *next_label = '\0'; // null terminate whole list
}

void init_labels() {
    labels[0] = '\0'; // NULL terminator
    next_label = &labels[0];
}

u16 match_label() {
    u8 length = 0;
    while (buffer_ptr[length] > 0x5e)
        length++;

    char* my_buf_ptr = buffer_ptr;

    char* label_ptr = &labels[0];
    while (*label_ptr != '\0') {
        for (int i = length; i != 0; i--) {
            char c = *label_ptr;
            if (c == 0 || c != *my_buf_ptr++) {
                goto next_label;
            }
            label_ptr++;
        }
        if (*my_buf_ptr > 0x5e) {
            goto next_label;
        }

        // label matched
        u16 addr = label_ptr[1] << 8;
        addr |= label_ptr[2];
        buffer_ptr += length;
        return addr;

next_label:
        while (*(label_ptr) != '\0') {
            label_ptr++;
        }
        label_ptr += 3;
        my_buf_ptr = buffer_ptr;
    }
    if (pass == 2) {
        error("Unknown label");
    }
    buffer_ptr += length;
    return 2;
}