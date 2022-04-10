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



RegNames16 = [
    "AX", "BX", "RT", "DX", "EX", "SP", "GX", "HX",
]

RegNames8 = [
    "AH", "AL", "BH", "BL", "RH", "RL", "DH", "DL", "EH", "EL", "SH", "SL", "GH", "GL", "HL", "HH",
]


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
            "RegNames8": RegNames8,
            "RegNames16": RegNames16,
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

class Memory():
    # Implements all opcodes 0x80 and above
    # Memory and load immediate


    def match(self, pc, bitstring, bytes):
        inst = bytes[0]

        if inst & 0x80 == 0x80:
            # Instructions that operate on A & B
            # bit 6: Accumulator select - 0 for "A", 1 for "B"
            reg = 0 if inst & 0x40 == 0 else 2
            # bit 5: Direction - 0 for read, 1 for write
            load = inst & 0x20 == 0
            # bit 4: Length - 0 for byte, 1 for word
            word = inst & 0x10 != 0
            if not word:
                reg += 1

            address_mode = inst & 0xf
        elif inst & 0xf0 == 0x60:
            # Instructions that operate on RT
            reg = 4
            word = True

            load = inst & 0x08 == 0
            address_mode = inst & 0x07
        else:
            return None


        index_name = None
        if address_mode == 0b101:
            index = bytes[1] >> 4
            index_name = RegNames16[index >> 1]
        elif address_mode & 0b1000:
            index = (address_mode & 0x7) << 1
            index_name = RegNames16[index >> 1]

        if word:
            reg_name = RegNames16[reg >> 1]
        else:
            reg_name = RegNames8[reg]


        address_modes = [
            (2 + word, "#{addr}"),               # 000 = immediate
            (3, "({addr})"),        # 001 = direct
            (3, "@({addr})"),
            (2, "(PC{offset})"),
            (2, "@(PC{offset})"), # 100 = PC relative
            (2, "indexed_modes"), # 101 = indexed with increment
            (2, "unknown"),
            (2, "unknown"),
            (1, "({index})"),     # indexed
            (1, "({index})"),
            (1, "({index})"),
            (1, "({index})"),
            (1, "({index})"),
            (1, "({index})"),
            (1, "({index})"),
            (1, "({index})"),
        ]

        indexed_modes = [
            "({index})", # guess
            "({index})+",
            "-({index})",
            "unknown_indexed"
            "unknown_indexed",
            "unknown_indexed",
            "unknown_indexed",
            "unknown_indexed",
            "{offset}({index})", # guess
            "{offset}({index})+",
            "{offset}-({index})",
            "unknown_indexed",
            "unknown_indexed",
            "unknown_indexed",
            "unknown_indexed",
            "unknown_indexed",
        ]

        offset_byte = bytes[1]
        addr = f"{struct.unpack_from('>xH', bytes)[0]:#06x}"

        if address_mode == 0 and not word:
            addr = addr[:4]

        format = ["st", "ld"][load]

        size, addr_format = address_modes[address_mode]
        if address_mode == 5:
            indexed_mode = bytes[1] & 0x0f
            addr_format = indexed_modes[indexed_mode]
            if indexed_mode & 8 != 0:
                offset_byte = bytes[2]
                size += 1

        offset = f"{struct.unpack_from('b', struct.pack('B', offset_byte))[0]:+#04x}"

        format = f"{format} {reg_name}, {addr_format}"

        return InstructionMatch(pc, QuickInstuction(format), bytes[:size], {
            "reg": reg_name,
            "index": index_name,
            "addr": addr,
            "offset": offset,
        })


OPs = [
    "inc", "dec", "clr", "not", "srl", "sll", "rrc", "rlc",
    "add", "sub", "and", "or", "xor", "mov", "unk6", "unk7"
]

ImplcitTable = [
    (0x10, 6),
    (0x00, 6),
    (0x13, 14),
    (0x02, 12)
]

class Alu():
    # Implements most opcodes between 0x20 and 0x5b

    class AluInstance():
        def __init__(self, op, word, src, dest, postfix):
            self.newpc = None
            self.op = op
            self.word = word
            self.src = src
            self.dest = dest
            self.postfix = postfix

        def to_string(self, dict):
            op = OPs[self.op]
            op += self.postfix

            if self.op < 8:
                if self.word:
                    return f"{op} {RegNames16[self.src >> 1]}"
                else:
                    return f"{op} {RegNames8[self.src]}"
            else:
                if self.word:
                    return f"{op} {RegNames16[self.dest >> 1]}, {RegNames16[self.src >> 1]}"
                else:
                    return f"{op} {RegNames8[self.dest]}, {RegNames8[self.src]}"

    def match(self, pc, bitstring, bytes):

        inst = bytes[0]
        if inst < 0x20 or inst >= 0x5f:
            return None

        word = inst & 0x10 != 0
        fast = inst & 0x08 != 0
        op = inst & 0x07

        if inst >= 0x40:
            op += 8

        # These don't fit the pattern
        if inst & 0x0e == 0x0e or inst > 0x5b:
           return None

        postfix = ""
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
            postfix = '!'
        else:
            bytetwo = bytes[1]
            dest = bytetwo & 0xf
            src = (bytetwo >> 4) & 0xf

            if inst < 0x40 and dest != 0:
                # these encoding make little sense, and there seems to be other instructions here
                return None
            bytes = [inst, bytetwo]

            expected, limit = ImplcitTable[op >> 4 - 2]
            if bytetwo == expected and op < limit:
                postfix = '*'

        return InstructionMatch(pc, self.AluInstance(op, word, src, dest, postfix), bytes, {})




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

    # these are instructions only used by the CPU6 ram mapping test
    I("00101110 00011100", "aaa"),
    I("00101110 00001100", "bbb"),
    I("11111NNN NNNNNNNN NNNNNNNN", "stb? A, [{N:#07x}]"),
    I("01000111 10000000 11111111 00000001 00000000 00000010 00000000", "check_parity_error"),
    I("01000111 01000000 11111111 00000001 00000000 00000010 00000000", "disable_parity_halt"),


    I("00110101 00000100", "set_data_bank {RegNames8[1]}"),
    I("01111110 NNNNNNNN", "long_call"),
    I("01111111 NNNNNNNN", "clear_data_bank??"),


    Memory(), # Implements 80-FF


    Alu(), # Implements (most of) 0x20-0x5f

# Sorted by opcode from here on
# 00

    #B("00000000", "HALT", kill_branch),
    I("00000000", "HALT"),

    # Flag instructions:
    I("00000001", "nop"),
    I("00000010", "fsn"),
    I("00000011", "fcn"),
    I("00000100", "fsi"), # enable interrupts
    I("00000101", "fci"), # disable interrupts
    I("00000110", "fsc"),
    I("00000111", "fcc"),
    I("00001000", "fca"), # Clears carry, sign, overflow and zero

    B("00001001", "ret", kill_branch),
    I("00001010", "reti"), #, kill_branch),

    I("00001110", "delay 4.5ms"),

# 10

    B("00010000 SSSSSSSS", "bc", relative_branch),
    B("00010001 SSSSSSSS", "bnc", relative_branch),
    B("00010010 SSSSSSSS", "bn", relative_branch),
    B("00010011 SSSSSSSS", "bnn", relative_branch),
    B("00010100 SSSSSSSS", "bz", relative_branch),
    B("00010101 SSSSSSSS", "bnz", relative_branch),
    B("00010110 SSSSSSSS", "blt", relative_branch),
    B("00010111 SSSSSSSS", "ble", relative_branch),
    B("00011000 SSSSSSSS", "bgt", relative_branch),
    B("00011001 SSSSSSSS", "ble", relative_branch), # lessthan or equal
    B("00011010 SSSSSSSS", "bs1", relative_branch),
    B("00011011 SSSSSSSS", "bs2", relative_branch),
    B("00011100 SSSSSSSS", "bs3", relative_branch),
    B("00011101 SSSSSSSS", "bs4", relative_branch),

# 20
    I("00100010 00110010", "cpu_id"), # Returns 0 on CPU5, something else on CPU6
    I("00100xxx xxxxxxxx", "special20"),

# 28

    # Special cases that don't match the general ALU pattern
    I("00101110 ssssdddd", "?? r{d}, r{s}"),
    # ugly, but indexing dynamic indexing into RegNames16 isn't supported :(
    I("00101111 00000000", "dma_load_addr WX"),
    I("00101111 00100000", "dma_load_addr YZ"),
    I("00101111 01000000", "dma_load_addr RT"),
    I("00101111 01100000", "dma_load_addr KL"),
    I("00101111 10000000", "dma_load_addr MN"),
    I("00101111 10100000", "dma_load_addr SP"),
    I("00101111 00000010", "dma_load_count WX"),
    I("00101111 00100010", "dma_load_count YZ"),
    I("00101111 01000010", "dma_load_count RT"),
    I("00101111 01100010", "dma_load_count KL"),
    I("00101111 10000010", "dma_load_count MN"),
    I("00101111 10100010", "dma_load_count SP"),
    I("00101111 00000001", "dma_store_addr WX"),
    I("00101111 00100001", "dma_store_addr YZ"),
    I("00101111 01000001", "dma_store_addr RT"),
    I("00101111 01100001", "dma_store_addr KL"),
    I("00101111 10000001", "dma_store_addr MN"),
    I("00101111 10100001", "dma_store_addr SP"),
    I("00101111 00000011", "dma_store_count WX"),
    I("00101111 00100011", "dma_store_count YZ"),
    I("00101111 01000011", "dma_store_count RT"),
    I("00101111 01100011", "dma_store_count KL"),
    I("00101111 10000011", "dma_store_count MN"),
    I("00101111 10100011", "dma_store_count SP"),

    I("00101111 dddd0100", "dma_set_mode {d}"),
    I("00101111 00000110", "dma_enable"),


    I("00101111 xxxxNNNN", "dma? {x}, {N}"),

# 30
    I("00111110", "inc {RegNames16[2]}"),
    I("00111111", "dec {RegNames16[2]}"),
    I("00110xxx xxxxxxxx", "special30"),

# 48
    # Special cases that don't match the general ALU pattern
    I("01011100", "mov {RegNames16[3]}, {RegNames16[0]}"),
    I("01011101", "mov {RegNames16[1]}, {RegNames16[0]}"),
    I("01011110", "mov {RegNames16[4]}, {RegNames16[0]}"),
    I("01011111", "mov {RegNames16[5]}, {RegNames16[0]}"),

# 60
    # ld.w RT, .... instruction are here. Handled by Memory()

# 70

    B("01110001 NNNNNNNN NNNNNNNN", "jump #{N:#06x}", abolsute_branch_uncondtionional),
    B("01110010 NNNNNNNN NNNNNNNN", "jump @({N:#06x}) ;", kill_branch),
    B("01110011 SSSSSSSS", "jump (PC{S:+#05x})", relative_branch_unconditional),
    B("01110101 NNNNNNNN", "jump (A + {N:#04x})", kill_branch),
    B("01110110", "syscall", kill_branch), # "Return to interrupt level 15"

# 78

    B("01111001 NNNNNNNN NNNNNNNN", "call #{N:#06x}", absolute_call),
    I("01111010 NNNNNNNN NNNNNNNN", "call @({N:#06x})"),
    B("01111011 SSSSSSSS", "call (PC{S:+#05x})", relative_call),
    I("01111101 NNNNNNNN", "call (A + {N:#04x})"),
# 80

    # Memory(),


    I("xxxxxxxx"),
]


def disassemble_instruction(memory, pc):
    bytes = memory[pc:pc+7]
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

