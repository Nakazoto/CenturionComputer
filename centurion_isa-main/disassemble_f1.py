#!/usr/bin/env python3

filename = "roms/Diag_F1_Rev_1.0.BIN"

from diag_common import *


base_address = 0x8000

strings = [
    0x85b3,
    0x8614,
    0x8734,
    0x8788,
]

functions = [
    (0x8077, "Fail", "Takes 4 bit error code, displays ((error code << 4) | 0xf) on hex displays"),

    (0x850e, "WriteByte"),
    (0x8519, "WriteHexByte"),
    (0x8520, "WriteHexNibble"),
    (0x8566, "WriteByteTramp"),
    (0x8623, "WriteString"),
    (0x8634, "ReadChar"),
    (0x8728, "AuxiliaryTestMenu"),
    (0x8557, "CheckForReset"),
    (0x8500, "ReadByteWithEcho"),
    (0x8568, "AsciiToHexNibble"), # sets flags if conversion fails
    (0x853a, "ReadHexWord"),

    # Tests
    (0x846f, "TOS_Entry", "TestOS: This is a Monitor that operates over serial console"),

]

lables = [
    (0x8055, "TestFunctions", "This is the table of test functions\n"
             "The above code indexes into it based on DIP switches"),
    (0x8774, "NextRom"),
    (0x84a3, "TOS_PromptLoop"),
    (0x84bf, "G_Command"),
    (0x84c3, "Q_Command"),
    (0x8001, "DiagEntryPoint"),
    (0x874f, "Aux_ReadTestEntry"),
    (0x876b, "Aux_PrintTestName"),
    (0x879f, "Aux_CheckDIPs", "If the DIPs are nolonger configured for the Auxiliary Test Menu, then\n"
                              "jump back to start of DIAG"),
    (0x87ad, "Aux_CheckSerial"),
    (0x87bf, "Aux_GotByte")

]

comments = [
    (0x8002, "This is the first word in Diag's 1KB of RAM"),
    (0x8013, "Set stack pointer just beyond top of Diag's 1KB of RAM"),

    (0x801b, "This is writing a pointer directly into registers."),
    (0x801f, "Something really funky is going on here."),
    (0x8022, "I assume this is calling or jumpting to that function"),

    (0x8024, "Turn Decimal Point 1 off"),
    (0x8027, "Turn Decimal Point 2 off"),
    (0x802a, "Turn Decimal Point 3 off"),
    (0x802d, "Turn Decimal Point 4 off"),
    (0x8030, "A = Dip swiches value"),
    (0x8035, "A = A & 0x0f"),
    (0x8037, "Write A to hex displays"),
    (0x803a, "Unblank the hex displys"),
    (0x803f, "Compare with 0b1011"),

    (0x8042, "If dipswitches == 0xb111: \n"
             "    Display Auxiliary Test Menu"),


    (0x8063, "TOS_Entry"),




    (0x8498, "Configure UART"),
    (0x84a3, "'\'"),
    (0x84ab, "'M'"),
    (0x84b0, "'G'"),
    (0x84b5, "'Q'"),

    (0x84ba, "Start of ROM"),



    (0x8500, "Jumps back to the start of F1 if some condition is met"),

    (0x853c, "Diag SRAM"),
    (0x8592, "'\\n'"),
    (0x8596, "This is the ascii DEL charater"),

    # (0x875b, "will wrap around to 0x800, the length of each ROM"),
    # (0x8774, "will wrap around to 0x800, the length of each ROM"),
    (0x8766, "Print the Test Number"),
    (0x8769, "'='"),
    (0x876b, "Print('=')"),
    (0x8770, "Print the Test Name"),

    (0x87a1, "Read DIP switches"),
    (0x87bf, "Echo Testnum back to terminal"),
    (0x87c2, "Convert to hex; Since there aren't many tests, this counts as convert to interger"),


]

if __name__ == "__main__":
    with open(filename, "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))
    entry_points.append(0x8001)


    for (addr, name, *extra) in functions:
        memory_addr_info[addr].label = name
        if len(extra) >= 1:
            memory_addr_info[addr].pre_comment = extra[0]

        entry_points.append(addr)

    for (addr, name, *extra) in lables:
        memory_addr_info[addr].label = name
        if len(extra) >= 1:
            memory_addr_info[addr].pre_comment = extra[0]

    for addr in strings:
        add_string(memory, addr)


    apply_comments(comments)


    # There is a table of tests here:
    for testnum, addr in enumerate(range (0x8055, 0x8075, 2)):
        dest = struct.unpack(">H", memory[addr:addr+2])[0]

        memory_addr_info[addr].type = ">H"
        entry_points.append(dest)

        if memory_addr_info[dest].label is None:
            memory_addr_info[dest].label = f"Test_{testnum:02x}"

        memory_addr_info[addr].comment = f"{memory_addr_info[dest].label}"

        # copy the comment
        if memory_addr_info[dest].pre_comment:
            memory_addr_info[addr].comment += f": {memory_addr_info[dest].pre_comment}"



    disassemble(memory, entry_points)
