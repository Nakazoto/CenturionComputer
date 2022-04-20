import struct
from disassemble import *

entry_points = []

def labelname(name):
    name = name.replace(" ", "_")
    return "Entry_" + "".join([c for c in name if c.isalnum() or c in "_"])

def parse_header(memory, base_address, address):
    test_id = 0
    while True:
        offset = struct.unpack_from(">H", memory[address:address+2])[0]
        memory_addr_info[address].visited = True
        memory_addr_info[address].type = ">H"
        memory_addr_info[address].label = f"TEST_{test_id}"
        test_id += 1
        memory_addr_info[address+1].visited = True
        address += 2

        if offset == 0:
            return address

        name = ""
        memory_addr_info[address].type = "cstring"

        while True:
            memory_addr_info[address].visited = True
            if memory[address] == 0:
                break

            name += chr(memory[address] & 0x7f)
            address += 1

        address += 1

        entry_points.append(base_address + offset)
        memory_addr_info[base_address + offset].label = labelname(name)

def verify_string(memory, address):
    for i in range(64):
        if memory[address + i] == 0:
            return True

        if memory[address + i] & 0x80 == 0:
            return False

    return False

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

def scan_strings(mem, address):
    while True:
        if mem[address] == 0x7a and mem[address+1] == 0x01 and mem[address+2] == 0x12:
            address += 3
            add_string(mem, address)



        address += 1
        if address >= 0xfd00:
            break

def scan_calls (mem, base_address, addr):
    # F3/F4 use this pattern setting up calls, and we can just detect them all

    while True:
        if mem[addr] == 0x90 and mem[addr+3] == 0x50 and mem[addr+4] == 0x80:
            dest = struct.unpack_from(">H", mem[addr+1:addr+3])[0]
            if dest < 0x800:
                entry_points.append(dest + base_address)
                memory_addr_info[dest + base_address].label = f"Fn_{dest:x}"

        addr += 1
        if addr >= 0x10000:
            break
