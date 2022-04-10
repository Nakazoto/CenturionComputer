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

    (0x80e3, "FlashFail", "Takes a error code, sets the fail decimal places and flashes the error\n"
                          "code until button is pressed (450ms on, 450ms off)\n"
                          "continues execution"),

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

    (0x808e, "DmaRegTest", "Test_01: Write every single bit pattern to DMA's address and count\n"
                           "registers, checks that it reads back correctly\n"
                           "On error, flashes hex 11 if address failed, and hex 12 if count failed\n"
                           "waits for button press to continue.\n"
                           "On success, lights the success DP pattern and loops."),

    (0x811b, "MemoryTest", "Test_02: A basic memory test.\n"
                           "Writes every memory word from 0x0100 to 0x7fff with it's address,\n"
                           "then loops back and checks the the memory value hasn't changed.\n"
                           "Also installs an interrupt handler, which probally catches parity errors\n"
                           "On invalid memory data, flashes an error with some hex value ?2\n"
                           "On parity interrupt, shows some error hex value ?2\n"
                           "On any other interrupt, shows error hex ?f where x is the interrupt\n"
                           "On success, lights the success DP pattern and loops.\n"),

    (0x8171, "Test02_Vector"),

    (0x81a3, "Test03_Vector"),

    (0x81dc, "MuxSendTest", "Test_04: Continually writes U to mux port 0.\n"
                              "Fails if MMIO f200 & 0x1c is not zero"),
    (0x8203, "MuxRecvTest", "Test_05: Echos whatever is received on mux port 0 back\n"
                              "Fails if MMIO f200 & 0x1c is not zero"),

    (0x8229, "CheckMuxStatus", "Check (UART_status & 0x1c == 0); Pass/Fail"),
    (0x826f, "Test06_Vector"),
    (0x8467, "Test09_Vector"),

    (0x8247, "MuxRecvInterruptTest", "Test_06: Same as Test_05, but uses interrupts instead of polling\n"),
    (0x837f, "HawkTest", "Test_09: Tests Hawk and DMA"),
    (0x846f, "TOS_Entry", "TestOS: This is a Monitor that operates over serial console"),

    (0x859d, "Bootstrap_test", "Test_0b: This seems to be a copy/paste of bootstrap, letting you\n"
                               "boot off a disk. But doesn't support CMD/Phoenix"),
    (0x86b2, "Diag_self_test", "Test_0c: Checksum's the F1 rom, flashes 1c if fail.\n"
                               "Then test diag's sram from b800 to bfff, flashes 2c if fail.\n"
                               "If everything passes, it lights up all decimal points, sets the\n"
                               "hex displays to 88 (aka Christmas tree) and loops. "),
]

lables = [
    (0x8055, "TestFunctions", "This is the table of test functions\n"
             "The above code indexes into it based on DIP switches"),
    (0x8774, "NextRom"),
    (0x84a3, "TOS_PromptLoop"),
    (0x84bf, "G_Command", "Go: Takes a "),
    (0x84c3, "Q_Command"),
    (0x84e3, "M_Command"),
    (0x8001, "DiagEntryPoint"),
    (0x874f, "Aux_ReadTestEntry"),
    (0x876b, "Aux_PrintTestName"),
    (0x879f, "Aux_CheckDIPs", "If the DIPs are nolonger configured for the Auxiliary Test Menu, then\n"
                              "jump back to start of DIAG"),
    (0x87ad, "Aux_CheckSerial"),
    (0x87bf, "Aux_GotByte"),

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

    (0x827a, "Copy the stack pointer from Interrupt level 0"),


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
