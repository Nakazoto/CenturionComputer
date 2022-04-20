#!/usr/bin/env python3

from disassemble import *

filename = "roms/DSK-MM1702A"
base_address = 0xef00

entry_points = [
    0xef00,
]

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

    entry_points.append(base_address)

    # for (addr, name) in functions:
    #     memory_addr_info[addr].label = name
    #     entry_points.append(addr)

    # for (addr, name) in labels:
    #     memory_addr_info[addr].label = name

    # apply_comments(comments)

    disassemble(memory, entry_points)
