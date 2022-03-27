#!/usr/bin/env python3

filename = "roms/Diag_F2_Rev_1.0.BIN"

from diag_common import *


base_address = 0x8800

functions = [
    (0x5a1, "Fn_5a1"),
    (0x6d9, "Fn_6d9"),
    (0x7cc, "WriteString"),
]

labels = [
    (0x8f62, "ChecksumLoop"),
    (0x8fa6, "ChecksumFail"),
    (0x8f9b, "WaitForKey"),
]

strings = [
    0x8f76,
    0x8f8c,
    0x8fa8,
    0x8850,
    0x8dc2,
    0x8dfc,
    0x8f38
]

comments = [
    (0x8883, "This is a testing that the 60 3 byte instruction is working.\n"
             "Which it will use later to test other multi-byte insturctions\n"
             "If the operand isn't consuemed, then a HALT instruction will be executed"),
    (0x888b, "This might be installing an exception handler?"),
    (0x8894, "clearing all regsiters?"),
    (0x8898, "if A is empty. This would set the overflow flag"),

    (0x88a9, "branch 10 is expected to not branch here"),
    (0x88ab, "The author could have used any branch here, but using 11 here\n"
             "implies 11 is the opposite of 10"),
    (0x88b0, "likewise, 13 is the opposite of 12 (and so on, below)"),

    (0x889a, "Some tests for all the branch instructions"),
    (0x88f9, "This is potentially increment, "),
    (0x8951, "Using 60 in the operand means the following branch will be skipped\n"
             "if 22 doesn't consume it's operand"),
    (0x89c1, "Is B0 a two byte instrution that we haven't encountered yet?"),

    (0x8f62, "Load Byte via base+index, post-increment index"),
    (0x8f6f, "Load Byte via base+index"),


]

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

   # scan_calls(memory, base_address, base_address)

    for (addr, name) in functions:
        memory_addr_info[base_address + addr].label = name
        entry_points.append(base_address + addr)

    for (addr, name) in labels:
        memory_addr_info[addr].label = name

    for addr in strings:
        add_string(memory, addr)

    body_addr = parse_header(memory, base_address, base_address)

    entry_points.append(0x8da1) # CPU test refrences this

    # testing of return instruction breaks our disassembly
    entry_points.append(0x8d3a)
    entry_points.append(0x8d4b)


    apply_comments(comments)


    disassemble(memory, entry_points)
