#!/usr/bin/env python3

from disassemble import *

filename = "roms/bootstrap_unscrambled.bin"
base_address = 0xfc00

entry_points = [
    0xfc00,

    # Our disasmebler doesn't currently find all code in bootstrap ROM, so we manually add some
    # extra entry points for now
    0xfd1c,
    0xfd1e,
    0xfdad,
    0xfcfe,
    0xfdf7,
    # 0xfcba,
]

functions = [
    (0xfc00, "EntryPoint"),
    (0xfd00, "AlternativeEntryPoint"),
    (0x0103, "IPL_Entry_point"),
    (0xfc92, "WriteString"),
    (0xfc90, "ReadCharTramp"),
    (0xfca3, "ReadChar"),
    (0xfd11, "DiskCommand"), # takes arguments from pc
]

labels = [
    (0xfc7f, "PrintError"),
    (0xfc13, "Prompt"),
    (0xfc2f, "GetNextChar"),
    (0xfcbc, "LoadFromHawkTramp"),
    (0xfcc0, "LoadFromHawk"),
    (0xfd16, "WaitForHawkCommand"),
]

comments = [
    (0xfc00, "Check the Sense switch to see if we should jump straight to DIAG"),
    (0xfc09, "Configure the first port on the mux board to 9600 baud, 8N1"),
    (0xfc0e, "Write control code FF aka Form Feed to serial\n"
             "Should cause a printer to move to the next page, and\n"
             "cause a CRT terminal to clear the screen"),
    (0xfc16, "Setup stack at 0x1000 (probally)"),
    (0xfc1e, "B == 'F'"),
    (0xfc25, "B == 'C'"),
    (0xfc2a, "B == 'H'"),
    (0xfcac, "char | 0x80 - Force bit 7 to be set"),
    (0xfcb0, "Check if char is lowercase (greater than 0x60)"),
    (0xfcb5, "Clear bit 6, forcing it to be uppercase"),
    (0xfc35, "Reject anything below ASCI 0x30 aka '0'"),

    (0xfcc5, "HawkUnitSelect = A"),
    (0xfcd1, "HawkSectorAddressReg = (0, 0, 0)"),
    (0xfcd4, "DiskCommand(3) - ReturnTrackZero"),

    (0xfce9, "DMA transfer destination address"),
    (0xfcee, "DMA source address? It's 0xf1ae backwards."),
    (0xfcf3, "DiskCommand(0) - Read"),
    (0xfcf6, "Check Command Status (0 == success?)"),
    (0xfcfb, "Transfer control to the IPL that was loaded off disk"),

    (0xfd16, "0xf144"),
]

def add_string(mem, address):
    memory_addr_info[address].visited = True
    memory_addr_info[address].type = "cstring"

    while True:
        if mem[address] == 0:
            break
        address += 1

     # resume execution after string
    address += 1
    entry_points.append(address)

def add_byte(mem, address):
    memory_addr_info[address].visited = True
    memory_addr_info[address].type = ">B"

     # resume execution after byte
    address += 1
    entry_points.append(address)

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

    for (addr, name) in functions:
        memory_addr_info[addr].label = name
        entry_points.append(addr)

    for (addr, name) in labels:
        memory_addr_info[addr].label = name

    add_string(memory, 0xfc19) # "D=?\0"
    add_string(memory, 0xfc81) # "\r\nERROR\r\n\0"

    add_byte(memory, 0xfc6c)

    apply_comments(comments)

    disassemble(memory, entry_points)
