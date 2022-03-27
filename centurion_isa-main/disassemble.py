#!/usr/bin/env python3

from collections import defaultdict
import struct

signed_wildcards = ("S")

label_id = 0

class MemInfo:
    def __init__(self):
        self.instruction = None
        self.label = None
        self.visited = False
        self.type = None
        self.comment = None
        self.pre_comment = None

memory_addr_info = defaultdict(MemInfo)

def bitstring_to_int(bitstring, signed=False):
    # bigendian
    limit = 1 << len(bitstring)
    while len(bitstring) % 8 != 0:
        bitstring = "0" + bitstring

    num = 0
    shift = 0
    while len(bitstring) != 0:
        byte = bitstring[-8:]
        bitstring = bitstring[:-8]
        num |= int(byte, 2) << shift

        if signed and len(bitstring) == 0 and num > (limit >> 1):
            num = num - limit


        shift += 8

    return num


class InvalidInstruction():
    newpc = None

    def to_string(self, dict):
        return dict["bytes"] + " <Invalid>"

class QuickInstuction:
    newpc = None
    def __init__(self, format):
        self.format = format

    def to_string(self, dict):
        return self.format.format(**dict)


class InstructionMatch:
    def __init__(self, pc, instruction, bytes, dict={}):
        self.disassembled = True
        self.valid = not isinstance(instruction, InvalidInstruction)
        self.instruction = instruction

        self.bytes = bytes
        self.next_pc = [pc + len(self.bytes)]

        self.dict = dict | {
            "bytes": " ".join([f"{b:02x}" for b in self.bytes]),
            "pc": pc,
            "next_pc": self.next_pc[0],
        }

        if self.instruction.newpc is not None:
            self.next_pc = instruction.newpc(**self.dict)

    def __repr__(self):
        return self.instruction.to_string(self.dict)


class I:
    def __init__(self, pattern, format = "unknown"):
        self.pattern = pattern = pattern.replace(" ", "")
        assert len(pattern) % 8 == 0

        self.format = format
        self.newpc = None

    def match(self, pc, bitstring, bytes):
        bitstring = bitstring[0:len(self.pattern)]

        wildcard_bitstrings = defaultdict(str)

        for p, b in zip(self.pattern, bitstring):
            # if the pattern has a '0' or '1', it must match the bit
            if p in ("0", "1"):
                if b != p:
                    return None
                continue

            # otherwise, the pattern is a wildcard which we extract
            wildcard_bitstrings[p] += b

        bytes = bytes[0:len(self.pattern) // 8]

        dict = {}
        for key, bistring in wildcard_bitstrings.items():
            signed = key in signed_wildcards
            dict[key] = bitstring_to_int(bistring, signed)

        return InstructionMatch(pc, self, bytes, dict)

    def to_string(self, dict):
        return self.format.format(**dict)



RegNames16 = [
    "AX", "BX", "r2", "r3", "r4", "SP", "r6", "r7",
]

RegNames8 = [
    "AH", "AL", "BH", "BL", "r2_high", "r2_low", "r3_high", "r3_low",
    "SP_high", "SP_low", "r5_high", "r5_low", "r6_high", "r6_low", "r7_high", "r7_low",
]

class Memory():
    # Implements all opcodes 0x80 and above
    # Memory and load immediate


    def match(self, pc, bitstring, bytes):
        inst = bytes[0]


        # bit 7: 1 for all load/store operations
        if inst < 0x80:
            return None

        # bit 6: Accumulator select - 0 for "A", 1 for "B"
        reg = 0 if inst & 0x40 == 0 else 2
        # bit 5: Direction - 0 for read, 1 for write
        load = inst & 0x20 == 0
        # bit 4: Length - 0 for byte, 1 for word
        word = inst & 0x10 != 0
        if not word:
            reg += 1

        index_name = None
        address_mode = inst & 0xf

        if address_mode == 0b101:
            reg = bytes[1] & 0xf
            index = bytes[1] >> 4
            index_name = RegNames16[index >> 1]
        elif address_mode & 0x1000:
            index = address_mode & 0x7 << 1
            index_name = RegNames16[index >> 1]

        if word:
            reg_name = RegNames16[reg >> 1]
        else:
            reg_name = RegNames8[reg]


        address_modes = [
            (2 + word, "mov {reg}, {addr}", "unknown"),               # 000 = immediate
            (3, "mov {reg}, [{addr}]", "mov [{addr}], {reg}"),        # 001 = direct
            (2, "unknown", "unknown"),
            (2, "unknown", "unknown"),
            (2, "mov {reg}, [pc{offset}]","mov [PC{offset}], {reg}"), # 100 = PC relative
            (2, "mov {reg}, [{index}++]", "mov [--{index}], {reg}"), # 101 = indexed with increment
            (2, "unknown", "unknown"),
            (2, "unknown", "unknown"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),     # indexed
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
            (1, "mov {reg}, [{index}]", "mov [{index}], {reg}"),
        ]

        offset = f"{struct.unpack_from('xb', bytes)[0]:-#04x}"
        addr = f"{struct.unpack_from('>xH', bytes)[0]:#06x}"

        if address_mode == 0 and not word:
            addr = addr[:4]

        size, load_format, store_format = address_modes[address_mode]
        format = load_format if load else store_format

        return InstructionMatch(pc, QuickInstuction(format), bytes[:size], {
            "reg": reg_name,
            "index": index_name,
            "addr": addr,
            "offset": offset,
        })


OPs = [
    "inc?", "dec?", "clear", "neg?", "shift_right", "shift_left", "rotate_right", "rotate_left",
    "add", "sub", "and", "or", "xor", "mov"
]

class Alu():
    # Implements most opcodes between 0x20 and 0x5d

    class AluInstance():
        def __init__(self, op, word, src, dest):
            self.newpc = None
            self.op = op
            self.word = word
            self.src = src
            self.dest = dest

        def to_string(self, dict):
            if self.word:
                operands = f"{RegNames16[self.dest >> 1]}, {RegNames16[self.src >> 1]}"
            else:
                operands = f"{RegNames8[self.dest]}, {RegNames8[self.src]}"

            return f"{OPs[self.op]} {operands}"

    def match(self, pc, bitstring, bytes):

        inst = bytes[0]
        if inst < 0x20 or inst >= 0x60:
            return None

        word = inst & 0x10
        fast = inst & 0x08
        op = inst & 0x07

        if inst >= 0x40:
            op += 8

        # These don't fit the pattern
        if op >= len(OPs) or inst == 0x2e or inst == 0x2f:
            return None

        if fast:
            if inst > 0x40:
                src = 0
                dest = 2
            else:
                src = 0
                dest = 0
            if not word:
                src += 1
                dest += 1

            bytes = [inst]
        else:
            bytetwo = bytes[1]
            dest = bytetwo & 0xf
            src = (bytetwo >> 4) & 0xf
            bytes = [inst, bytetwo]

        return InstructionMatch(pc, self.AluInstance(op, word, src, dest), bytes, {})




def relative_branch(next_pc, S, **kwargs):
    return [next_pc, next_pc + S]

def relative_branch_unconditional(next_pc, S, **kwargs):
    return [next_pc + S]

def relative_call(next_pc, S, **kwargs):
    return [next_pc, next_pc + S]

def abolsute_branch_uncondtionional(N, **kwargs):
    return [N]

def absolute_call(next_pc, N, **kwargs):
    return [next_pc, N]

def kill_branch(**kwargs):
    return []

class B(I):
    def __init__(self, pattern, name, newpc):
        super().__init__(pattern, "")
        self.newpc = newpc
        self.name = name

    def to_string(self, dict):
        if self.newpc == kill_branch:
            return self.name.format(**dict)
        if self.newpc == relative_branch or self.newpc == relative_branch_unconditional:
            dest = dict["next_pc"] + dict["S"]
        elif self.newpc == relative_call:
            dest = dict["next_pc"] + dict["S"]
        else:
            dest = dict["N"]

        label = memory_addr_info[dest].label
        if label == None:
            label = f"{dest:#04x}"
        return f"{self.name.format(**dict)} {label}"


instructions = [
    # Um, this array is partially sorted for optimal decoding speed
    Memory(), # Implements 80-FF


    Alu(), # Implements (most of) 0x20-0x5f

# Sorted by opcode from here on
# 00

    #B("00000000", "HALT", kill_branch),
    I("00000000", "HALT"),

    # Flag instructions:
    I("00000001", "nop"),
    I("00000010", "flag2"),
    I("00000011", "flag3"),
    I("00000100", "flag4"),
    I("00000101", "flag5"),
    I("00000110", "set_carry"),
    I("00000111", "clear_carry"),
    I("00001000", "flag8"),

    B("00001001", "ret", kill_branch),

    I("00001110", "delay 4.5ms"),

# 10

    B("00010000 SSSSSSSS", "b0", relative_branch),
    B("00010001 SSSSSSSS", "b1", relative_branch),
    B("00010010 SSSSSSSS", "b2", relative_branch),
    B("00010011 SSSSSSSS", "b3", relative_branch),
    B("00010100 SSSSSSSS", "b_z", relative_branch),
    B("00010101 SSSSSSSS", "b_nz", relative_branch),
    B("00010110 SSSSSSSS", "b_lt", relative_branch),
    B("00010111 SSSSSSSS", "b7", relative_branch),
    B("00011000 SSSSSSSS", "b_gt", relative_branch),
    B("00011001 SSSSSSSS", "b_le", relative_branch), # lessthan or equal
    B("00011010 SSSSSSSS", "b_sense0", relative_branch),
    B("00011011 SSSSSSSS", "b_sense1", relative_branch),
    B("00011100 SSSSSSSS", "b_sense2", relative_branch),
    B("00011101 SSSSSSSS", "b_sense3", relative_branch),

# 20

    # Alu(),

# 28

    # Special cases that don't match the general ALU pattern
    I("00101110 ssssdddd", "?? r{d}, r{s}"),
    I("00101111 xxxxNNNN", "DMA load {x}, {N}"),

# 48
    # Special cases that don't match the general ALU pattern
    I("01011110", "mov r4, AX"),
    I("01011111", "mov SP, AX"), # sp is r5

# 60
    I("01100000 NNNNNNNN NNNNNNNN", "60 {N:#06x}"),  # 60 ??? Might be load immediate into index reg?
    I("01100001 NNNNNNNN NNNNNNNN", "61 {N:#06x}"),  # 61

    I("01100101 xxxxxxxx"), # suspect

    I("01101001 NNNNNNNN NNNNNNNN", "69 A, {N:#06x}"),  # 69

    I("01101101 xxxxxxxx"), # suspect


# 70

    B("01110001 NNNNNNNN NNNNNNNN", "jump {N:#06x}", abolsute_branch_uncondtionional),
    B("01110010 NNNNNNNN NNNNNNNN", "jump [{N:#06x}] ;", kill_branch),
    B("01110011 SSSSSSSS", "jump", relative_branch_unconditional),
    B("01110101 NNNNNNNN", "jump A + {N:#04x}", kill_branch),

# 78

    B("01111001 NNNNNNNN NNNNNNNN", "call", absolute_call),
    I("01111010 NNNNNNNN NNNNNNNN", "call [{N:#06x}]"),
    B("01111011 SSSSSSSS", "call", relative_call),
    I("01111101 NNNNNNNN", "call A + {N:#04x}"),

# 80

    # Memory(),


    I("xxxxxxxx"),
]


def disassemble_instruction(memory, pc):
    bytes = memory[pc:pc+3]
    bitstring = ""
    for byte in bytes:
        bitstring += format(byte, '08b')

    for instruction in instructions:
        match = instruction.match(pc, bitstring, bytes)
        if match:
            return match

    return InstructionMatch(pc, InvalidInstruction(), bitstring, {})



def recursive_disassemble(memory, entry):
    valid = True
    pc = entry
    while valid and pc < 0xfe00:
        if memory_addr_info[pc].visited:
            return

        memory_addr_info[pc].visited = True

        info = disassemble_instruction(memory, pc)
        valid = info.valid

        for i in range(pc+1, pc + len(info.bytes)):
            if memory_addr_info[i].visited:
                valid = False

        if valid:
            memory_addr_info[pc].instruction = info

        if len(info.next_pc) == 0:
            return

        for next_pc in info.next_pc[1:]:
            if memory_addr_info[next_pc].label == None:
                memory_addr_info[next_pc].label = f"L_{next_pc:04x}"
            recursive_disassemble(memory, next_pc)

        next_pc = info.next_pc[0]

        if next_pc != pc + len(info.bytes):
            if memory_addr_info[next_pc].label == None:
                memory_addr_info[next_pc].label = f"L_{next_pc:04x}"

        pc = next_pc

def disassemble(memory, entry_points):
    for entry in entry_points:
        recursive_disassemble(memory, entry)

    i = 0
    while i < 0xfe00:
        if i & 0x000f == 0:
            try:
                if memory[i:i+16] == b"\x00" * 16:
                    i += 16
                    continue
            except:
                pass
        info = memory_addr_info[i] if i in memory_addr_info else MemInfo()

        if info.label:
            print(f"\n{info.label}:")

        if info.pre_comment:
            lines = info.pre_comment.split("\n")
            for line in lines:
                print(f"    ; {line}")

        str = ""

        if info.type == "cstring":
            str += f"{i:04x}:    \""

            while c := memory[i] & 0x7f:
                # if char is printable, print it
                if c >= 32 and c <= 126:
                    str += chr(c)
                elif c == 10: # else escape it
                    str += "\\n"
                elif c == 13:
                    str += "\\r"
                else:
                    str += f"\\x{c:02x}"
                i += 1
            str += "\\0\""

            i += 1

        elif info.type != None:
            value = struct.unpack_from(info.type, memory[i:i+4])[0]
            bytes = struct.pack(info.type, value)

            str = f"{i:04x}:    "
            for b in bytes:
                str += f"{b:02x} "
            i += len(bytes)
            while len(str) < 22:
                str += " "
            str += f"({value:#x})"

        elif info.instruction:
            inst = info.instruction
            str = f"{i:04x}:    "
            for b in inst.bytes:
                str += f"{b:02x} "
            while len(str) < 22:
                str += " "

            str += inst.__repr__()

            i += len(inst.bytes)

        else:
            str += (f"{i:04x}:    {memory[i]:02x}")
            i += 1

        if info.comment:
            indent = len(str)
            lines = info.comment.split("\n")
            str += f" ; {lines[0]}"
            for line in lines[1:]:
                str += "\n" + " " * indent + f" ; {line}"

        print(str)

def apply_comments(comments):
    for addr, comment in comments:
        memory_addr_info[addr].comment = comment

if __name__ == "__main__":
    # print(disassemble_instruction( b"\x1510", 0).next_pc)]
    # exit()

    import sys

    filename = sys.argv[1]
    base_address = int(sys.argv[2], 16)

    with open(sys.argv[1], "rb") as f:
        bytes = f.read()

    memory = b"\0" * (base_address) + bytes + b"\0" * (0x10000 - (len(bytes) + base_address))

    entry_points = []

    for arg in sys.argv[3:]:
        entry = int(arg, 16)
        entry_points.append(entry)
        memory_addr_info[entry].label = f"Entry{label_id}"
        label_id += 1

    disassemble(memory, entry_points)

