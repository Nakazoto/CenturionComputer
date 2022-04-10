#!/usr/bin/env python3

filename = "roms/Diag_F3_Rev_1.0.BIN"

from diag_common import *


base_address = 0x9000


functions = [
    (0x09a, 0x112, "WriteString"), # Writes null-terminated string to serial
    (0x0b0, 0x102, "ReadChar"),
    (0x0ba, 0x110, "WriteHexWord"), # Prints out a 4 digit BCD number as ASCII to serial
    (0x0c5, 0x10a, "WriteHexByte"), # Prints out a 2 digit BCD number as ASCII to serial
    (0x0f6, 0x104, "FinishTest"), # Prints Pass or Fail. checks 0x108 to see if test passed or failed
    (0x128, 0x10e, "PressSpaceThenExit"),
    (0x164, 0x106, "PrintCtrlCToExit"), # prints out "(CONTROL-C TO EXIT)"
    (0x180,     0, "Init"),
    (0x1e3, 0x118, "Fn_1e3"),
    (0x286, 0x10c, "Fn_286"),
    (0x0a3, 0,     "WriteByte"),
]

labels = [
    (0x9156, "repeat_test", "Resets stack, takes 16bit test start address from RT"),
]

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

    #scan_calls(memory, base_address, base_address)

    for (addr, indirect_addr, name) in functions:
        memory_addr_info[base_address + addr].label = name
        if indirect_addr != 0:
            memory_addr_info[indirect_addr].label = name
        entry_points.append(base_address + addr)

    # print(entry_points)

    # for entry in entry_points:
    #     print(f"({entry & 0xfff:#05x}, \"\"),")

    # exit()

    entry_points.append(0x92d7)
    entry_points.append(0x9395)
    entry_points.append(0x9395)
    entry_points.append(0x95f1)
    entry_points.append(0x96a4)
    entry_points.append(0x9750)

    body_addr = parse_header(memory, base_address, base_address)

    scan_strings(memory, body_addr)


    disassemble(memory, entry_points)
