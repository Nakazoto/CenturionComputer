#!/usr/bin/env python3

filename = "roms/Diag_F4_1133CMD.BIN"
base_address = 0x9800

from diag_common import *

functions = [
    (0x0a5, 0x112, "WriteString"),
    (0x0bb, 0x102, "ReadChar"),
    (0x0c5, 0x110, "Fn_0c5"),
    (0x0d0, 0x10a, "Fn_0d0"),
    (0x101, 0x104, "FinishTest"), # Prints Pass or Fail. checks 0x108 to see if test passed or failed
    (0x133, 0x10e, "PressSpaceThenExit"),
    (0x16f, 0x106, "PrintCtrlCToExit"), # prints out "(CONTROL-C TO EXIT)"
    (0x18b, 0x100, "Init"),
    (0x1ee, 0x118, "Fn_1ee"), # not called
    (0x291, 0x10c, "Fn_291"), # not called
]

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

    #scan_calls(memory, base_address, base_address)

    for (addr, indirect_addr, name) in functions:
        memory_addr_info[base_address + addr].label = name
        memory_addr_info[indirect_addr].label = name
        entry_points.append(base_address + addr)

    body_addr = parse_header(memory, base_address, base_address)

    scan_strings(memory, body_addr)

    entry_points.append(0x9ae2)
    entry_points.append(0x9d45)
    entry_points.append(0x9e08)
    entry_points.append(0x9ea7)

    disassemble(memory, entry_points)
