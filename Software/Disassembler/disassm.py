#!/usr/bin/python3
#
# Centurion Disassembler by ren14500. Public domain.
#
# The disassembler works by starting at the entrypoint and disassembling in
# a loose version of the execution order. There is a limited virtual machine
# built in to track memory, registers, and flags to attempt to properly figure
# out SVC/subroutine calls and arguments. This process is not perfect, so a few
# options are provided to supplement the automatic handling for more complex
# programs.
#
# Basic options:
#  -base ADDR Specify the base address to load the executable to. Defaults to
#             0x8000, where typical user executables run in OPSYS.
#  -rom If specified, do not perform the CVX process to assemble and relocate
#       the executable. It is instead assumed to be ROM code with no
#       relocatable addresses and is taken as-is, loaded at the base address
#       given by -base.
#  -cpu5 If specified, use CPU5 CVX rules, which means 0xFF indicates end-of-
#        sector instead of a negative relocation offset. Also simulate SVC
#        calls by interpreting JSR$ X'005A' and recognizing the CPU5 SVC call
#        numbers which don't all match up with CPU6 numbering.
#  -table If specified, there is a table of entrypoints at the entrypoint.
#  -entry ADDR Specify the entrypoint relative to the start of the executable,
#              not the base address it was loaded to. This should generally be
#              used with -rom; CVX executables specify the entrypoint.
#              Specifying anything other than 0 will override the CVX value.
#  -noaddr If specified, the address of each instruction is omitted and the
#          output is created in the form of a full source file suitable for
#          use with XASSM, which should assemble back to an exact duplicate of
#          the original (after CVX relocation) in most cases.
#  -minimal If specified, omit formatting and comments to make the file smaller.
#           This is usually used with -noaddr.
#  -name NAME Specify the program. Defaults to the input filename with a leading
#             X removed if present.
#
# Pre-disassembly options (choose zero or one):
#  -cvxasm FILE Perform the first step of CVX (assembling the executable parts
#               into a contiguous memory block), then save that to FILE.
#  -cvxrel FILE Perform both steps of CVX (assembly and relocation to the
#               base address), then save that to FILE.
#
# Force disassembly hints:
#  -force ADDRS A space-separated list of addresses which should be disassembled
#               even though no apparent execution path leads to them. This is
#               useful in executables that use indirect or indexed jumps where
#               it cannot be easily determined where every jump may lead. These
#               addresses are relocated, so if the base address is 0x8000, the
#               example below would force disassembly starting at the first
#               and eleventh bytes of the executable:
#               -force "0x8000 0x800a"
#
# Known JSR argument lengths:
#  -jsrs ADDRLENS A space-separated list of address:length mappings which will
#                 prevent recursion into the JSR. This is useful when the logic
#                 to determine the argument length after a JSR is too complex
#                 for the disassembler to determine. The address given is the
#                 (relocated) address where the JSR occurs, not the subroutine
#                 it calls. The length is given in bytes. If all calls to a
#                 subroutine are overridden with a specification in this list,
#                 you will need to add the subroutine address to the -force
#                 list. The example below specifies that the JSR at 0x8100 has
#                 4 bytes of arguments and the JSR at 0x8200 has 7 bytes of
#                 arguments. When disassembly hits each of those JSRs, the
#                 amounts specified will be skipped and disassembly resumed
#                 thereafter.
#                 -jsrs "0x8100:4 0x8200:7"
#
# Known subroutine argument length determination:
#  -subs ADDRCODES A double-semicolon-separated list of address:code mappings
#                  which will determine the length of arguments following a JSR
#                  to the given address. Single semicolons are converted to
#                  newlines. This is useful when the arguments to an often-
#                  called subroutine are long and difficult or impossible to
#                  determine within the limits imposed by infinite loop
#                  detection. The address given is the (relocated) address
#                  where the subroutine starts (the JSR target address), not the
#                  JSR address. The code provided must return the arguments
#                  length in bytes. The code is run by eval() and given a local
#                  variable named 'args' that is the memory immediately
#                  following the JSR targeting the given address. The subroutine
#                  start address is added to the -force list as well. The
#                  example below specifies that the subroutine at 0x8010 will
#                  read arguments until a 0x00 byte is found and the subroutine
#                  at 0x8300 will read arguments until a 0x00 followed by 0x01
#                  is found. The terminating characters are considered part of
#                  the arguments in these cases.
#             -subs '0x8010:args.index(0) + 1;;0x8300:args.index(b"\0\x01") + 2'
#
# Known indirect subroutine argument length determination:
#  -isubs ADDRCODES A double-semicolon-separated list of address:code mappings
#                   which will determine the lengh of arguments following an
#                   indirect JSR (JSR$ or JSR*). Single semicolons are converted
#                   to newlines. This is useful because it is almost impossible
#                   for the disassembler to figure out the actual subroutine
#                   location and attempt to determine the arguments used. The
#                   (relocated) indirect address where the subroutine address
#                   should be looked up is specified. The code provided must
#                   return the arguments length in bytes. The code is run by
#                   eval() and given a local variable named 'args' that is the
#                   memory immediately following the JSR. The example below
#                   specifies that the subroutine whose address is found at
#                   0x0118 (e.g., JSR$ X'0118') uses 3 bytes of arguments and
#                   the subroutine whose address is at 0x11a uses 7 bytes. See
#                   -subs for more interesting examples. The only difference
#                   with -isubs is specifying the indirect address instead of
#                   the subroutine's actual address.
#                   -isubs '0x0118:3;;0x011a:7'
#
# Known labels:
# -flabels ADDRNAMES A space-separated list of address:name mappings which will
#                    override the default names for each function address given.
#                    This makes the disassembly more readable once functions are
#                    understood. These addresses are relocated, so if the base
#                    address is 0x8000, the example below would set the label at
#                    0x8379 to "PRINT" and at 0x8314 to "INIT".
#                    -labels "0x8379:PRINT 0x8314:INIT"
# -vlabels ADDRNAMES A space-separated list of address:name mappings which will
#                    override the default names for each variable address given.
#                    This makes the disassembly more readable once variables are
#                    understood. These addresses are relocated, so if the base
#                    address is 0x8000, the example below would set the label at
#                    0x8123 to "MYVAR" and at 0x8567 to "VAR3".
#                    -labels "0x8123:MYVAR 0x8567:VAR3"
import argparse
import inspect
import sys
from pathlib import Path
from datetime import date
from typing import Dict, List, Set, Tuple, Union

# Main function.
def main():
  # Parse arguments.
  cmdline = argparse.ArgumentParser(prog='disassm.py',
                                    description='Disassembles Executables',
                                    add_help=True, allow_abbrev=True)
  cmdline.add_argument('filename')
  cmdline.add_argument('-base', default='0x8000', help='Base load address')
  cmdline.add_argument('-rom', action='store_true', help='Non-CVX executable')
  cmdline.add_argument('-cpu5', action='store_true', help='CPU5 CVX rules')
  cmdline.add_argument('-table', action='store_true', help='Table of entries')
  cmdline.add_argument('-entry', default='0', help='Entry point for non-CVX')
  cmdline.add_argument('-noaddr', action='store_true',
                        help='Omit addresses; create XASSM input')
  cmdline.add_argument('-minimal', action='store_true', help='Smallest output')
  cmdline.add_argument('-name', default='', help='Program name')
  cmdline.add_argument('-cvxasm', default='',
                       help='Filename to save assembled but not relocated')
  cmdline.add_argument('-cvxrel', default='', help='Filename to save relocated')
  cmdline.add_argument('-force', default='',
    help='Force addresses to disassemble (ex: "0x8000 0x8010")')
  cmdline.add_argument('-jsrs', default='',
    help='Addresses of JSRs and their arg size (ex: "0x8000:10 0x8010:12")')
  cmdline.add_argument('-subs', default='',
    help='Addresses of subroutines and code to eval arg length')
  cmdline.add_argument('-isubs', default='',
    help='Indirect addresses of subroutines and code to eval arg length')
  cmdline.add_argument('-flabels', default='',
    help='Override function labels (ex: "0x8379:PRINT 0x8314:INIT")')
  cmdline.add_argument('-vlabels', default='',
    help='Override variable labels (ex: "0x8123:MYVAR 0x8567:VAR3")')
  cmdargs = cmdline.parse_args()

  # Read the file.
  inpath = Path(cmdargs.filename)
  infile = inpath.read_bytes()

  # Parse.
  parser = Parser(cmdargs, infile, inpath.stem)
  if not parser.parse():
    return 1

  # If we wrote assembled or relocated output, we're done.
  if cmdargs.cvxasm != '' or cmdargs.cvxrel != '':
    return 0

  # Analyze. Catch errors and defer them.
  err = None
  try:
    parser.analyze()
  except ValueError as ve:
    err = ve

  # Write output.
  parser.write_output()

  # Print the error if there was one.
  if err is not None:
    print()
    print('Exception caught:')
    print(err)

  # Success.
  return 0

# Returns True if the byte is ASCII or False if not. Omit single quote (A7) here
# because you can't put one in a DC. Underscore (DF) is the same as delete.
def is_ascii(val: int) -> bool:
  return val >= 0xA0 and val < 0xFF and val != 0xA7 and val != 0xDF

# Returns True if all the bytes are ASCII or False if not.
def all_ascii(val: bytes) -> bool:
  for b in val:
    if not is_ascii(b):
      return False
  return True

# Returns True if the byte is ASCII but not the lowercase letters which can get
# modified to uppercase.
def is_ascii_nolower(val: int) -> bool:
  return is_ascii(val) and (val < 0xE1  or val > 0xFA)

# Returns True if all the bytes are ASCII or False if not.
def all_ascii_nolower(val: bytes) -> bool:
  for b in val:
    if not is_ascii_nolower(b):
      return False
  return True

# Returns True if the byte is ASCII or an allowed control or False if not.
def is_printable(val: int) -> bool:
  return is_ascii(val) or \
         val == 0x00 or \
         val == 0x84 or val == 0x87 or (val >= 0x8A and val <= 0x8D) or \
         val == 0xA7 or val == 0xDF

# Returns the printable string for the given bytes, which must be all_ascii()
# True.
def printable(val: bytes) -> str:
  return ''.join(chr(x - 0x80) for x in val)

# Returns the quoted printable string for the given ASCII/printable value.
def qprintable(val: int) -> str:
  if is_ascii(val):
    return "'{0}'".format(chr(val - 0x80))
  elif val == 0x00:
    return 'NUL'
  elif val == 0x84:
    return 'EOT'
  elif val == 0x87:
    return 'BEL'
  elif val == 0x8A:
    return 'LF'
  elif val == 0x8B:
    return 'VT'
  elif val == 0x8C:
    return 'FF'
  elif val == 0x8D:
    return 'CR'
  elif val == 0xA7:
    return "'"
  elif val == 0xDF:
    return 'DEL'

# Returns a byte with the Centurion ASCII value for the given 1-character
# string.
def ascii_b(s: str) -> int:
  return s.encode()[0] + 0x80

# Returns a word with the Centurion ASCII value for the given 2-character
# string.
def ascii_w(s: str) -> int:
  return int.from_bytes(s.encode()[0:2], 'big') + 0x8080

# Returns True if the byte value is negative or False if not.
def is_neg_b(val: int) -> bool:
  return (val & 0x80) != 0

# Returns the negative number for the given byte value.
def neg_b(val: int) -> int:
  return -((~val & 0xFF) + 1)

# Returns True if the word value is negative or False if not.
def is_neg_w(val: int) -> bool:
  return (val & 0x8000) != 0

# Returns the negative number for the given word value.
def neg_w(val: int) -> int:
  return -((~val & 0xFFFF) + 1)

# Returns True if the variable-length value is negative or False if not.
def is_neg_v(val: int, width: int) -> bool:
  return (val & (1 << ((width * 8) - 1))) != 0

# Returns the negative number for the given variable-length value.
def neg_v(val: int, width: int) -> int:
  return -((~val & ((1 << (width * 8)) - 1)) + 1)

# Attributes for a string of bytes.
class Attrs:
  # An argument label.
  class ArgLabel:
    def __init__(self, addr: int, prefix: str):
      self.addr = addr
      self.prefix = prefix
      self.offset = 0

  # Initialize.
  def __init__(self, num_bytes: int):
    # The string length.
    self.num_bytes = num_bytes

    # Initialize default attributes for this set of bytes.
    self.fixedup = False
    self.fixup_target = False
    self.is_something = False
    self.is_opcode = False
    self.is_string = False
    self.is_word = False
    self.is_byte = False

    # Initialize information.
    self.label = ''
    self.labeledFunc = False
    self.opcode = ''
    self.args = ''
    self.comment = ''
    self.arglabels = [ Attrs.ArgLabel(0, '') ]
    self.arglabels = [ ]

# Register address. EE200 Figure 2-1, page 2-2.
regaddress_word = [
  'A', 'A', 'B', 'B', 'X', 'X', 'Y', 'Y', 'Z', 'Z',
  'S', 'S', 'C', 'C', 'P', 'P'
]
regaddress_byte = [
  'AU', 'AL', 'BU', 'BL', 'XU', 'XL', 'YU', 'YL', 'ZU', 'ZL',
  'SU', 'SL', 'CU', 'CL', 'PU', 'PL'
]

# Get source and destination register values/strings.
def get_regs(regs: int) -> tuple:
  return regs >> 4, regs & 0x0F
def get_regs_bb(regs: int) -> tuple:
  r1, r2 = get_regs(regs)
  return regaddress_byte[r1], regaddress_byte[r2]
def get_regs_bw(regs: int) -> tuple:
  r1, r2 = get_regs(regs)
  return regaddress_byte[r1], regaddress_word[r2]
def get_regs_wb(regs: int) -> tuple:
  r1, r2 = get_regs(regs)
  return regaddress_word[r1], regaddress_byte[r2]
def get_regs_ww(regs: int) -> tuple:
  r1, r2 = get_regs(regs)
  return regaddress_word[r1], regaddress_word[r2]

# Virtual machine.
class VM:
  # Initialize.
  def __init__(self,
               src: Union[bytearray, 'VM'], base: int = 0, entry: int = 0):
    # Registers. Initialize X to an unlikely address because some executables
    # like transient modules will try to return to whatever called them and
    # we want to stop disassembly at that point. Start the stack at a high
    # memory location again in case it was assumed to be set elsewhere.
    self._regs = [ 0, 0, 0xFFFF, 0, 0, 0xF000, 0, 0 ]

    # Program counter, flags, and memory.
    self._pc = 0
    self._f = 0
    self._l = 0
    self._m = 0
    self._v = 0
    self._ram = bytearray(65536)

    # Set the program counter and memory if a bytearray is given.
    if isinstance(src, bytearray):
      self._pc = entry + base
      for i in range(len(src)):
        self._ram[base + i] = src[i]
    else:
      # Copy registers, program counter, flags, and memory if copying from
      # another VM.
      for i in range(len(self._regs)):
        self._regs[i] = src._regs[i]
      self._pc = src._pc
      self._f = src._f
      self._l = src._l
      self._m = src._m
      self._v = src._v
      for i in range(len(src._ram)):
        self._ram[i] = src._ram[i]

  # Get the register index for the given register number.
  @classmethod
  def get_reg_index(cls, reg: int) -> int:
    return reg // 2

  # Get the register index for the given word register name.
  @classmethod
  def get_reg_index_w(cls, reg: str) -> int:
    return {'A':0, 'B':1, 'X':2, 'Y':3, 'Z':4, 'S':5, 'C':6, 'P':7}.get(reg)
  
  # Get the register index for the given byte register name.
  @classmethod
  def get_reg_index_b(cls, reg: str) -> int:
    return {'AU':0, 'AL':0, 'BU':1, 'BL':1,
            'XU':2, 'XL':2, 'YU':3, 'YL':3, 'ZU':4, 'ZL':4,
            'SU':5, 'SL':5, 'CU':6, 'CL':6, 'PU':7, 'PL':7}.get(reg)

  # Get the value of the given word register.
  def get_reg_w(self, reg: Union[int, str]) -> int:
    if isinstance(reg, int):
      return self._regs[VM.get_reg_index(reg)]
    return self._regs[VM.get_reg_index_w(reg)]

  # Get the value of the given byte register.
  def get_reg_b(self, reg: Union[int, str]) -> int:
    if isinstance(reg, int):
      word = self._regs[VM.get_reg_index(reg)]
      return word & 0x00FF if (reg & 1) != 0 else word >> 8
    word = self._regs[VM.get_reg_index_b(reg)]
    return word & 0x00FF if reg.endswith('L') else word >> 8

  # Set the value of the given word register.
  def set_reg_w(self, reg: Union[int, str], val: int) -> None:
    if isinstance(reg, int):
      self._regs[VM.get_reg_index(reg)] = val
    else:
      self._regs[VM.get_reg_index_w(reg)] = val

  # Set the value of the given byte register.
  def set_reg_b(self, reg: Union[int, str], val: int) -> None:
    if isinstance(reg, int):
      is_u = (reg & 1) == 0
      index = VM.get_reg_index(reg)
    else:
      is_u = reg.endswith('U')
      index = VM.get_reg_index_b(reg)
    if is_u:
      self._regs[index] = (self._regs[index] & 0x00FF) | (val << 8)
    else:
      self._regs[index] = (self._regs[index] & 0xFF00) | val

  # Get/set a byte from memory.
  def get_mem_b(self, addr: int) -> int:
    if addr >= len(self._ram):
      return 0
    return self._ram[addr]
  def set_mem_b(self, addr: int, val: int) -> None:
    if addr < len(self._ram):
      self._ram[addr] = val

  # Get/set a word from memory.
  def get_mem_w(self, addr: int) -> int:
    if addr >= len(self._ram) - 1:
      return 0
    return int.from_bytes(self._ram[addr:addr+2], 'big')
  def set_mem_w(self, addr: int, val: int) -> None:
    if addr < len(self._ram) - 1:
      self._ram[addr] = val >> 8
      self._ram[addr + 1] = val & 0x00FF

  # Push/pop a byte to/from the stack.
  def push_b(self, val: int) -> None:
    s = self.get_reg_w('S') - 1
    self.set_reg_w('S', s)
    self.set_mem_b(s, val)
  def pop_b(self) -> int:
    s = self.get_reg_w('S')
    self.set_reg_w('S', s + 1)
    return self.get_mem_b(s)

  # Push/pop a word to/from the stack.
  def push_w(self, val: int) -> None:
    s = self.get_reg_w('S') - 2
    self.set_reg_w('S', s)
    self.set_mem_w(s, val)
  def pop_w(self) -> int:
    s = self.get_reg_w('S')
    self.set_reg_w('S', s + 2)
    return self.get_mem_w(s)

  # Get/set/increment the program counter.
  def get_pc(self) -> int:
    return self._pc
  def set_pc(self, addr: int) -> None:
    self._pc = addr
  def incr_pc(self, amt: int = 1) -> None:
    self._pc += amt

  # Get/set/reset/update the fault flag.
  def get_f(self) -> int:
    return self._f
  def set_f(self) -> None:
    self._f = 1
  def reset_f(self) -> None:
    self._f = 0
  def update_f_b(self, old: int, new: int) -> None:
    # F flag is set if the high bit changes.
    if (old & 0x80) != (new & 0x80):
      self.set_f()
    else:
      self.reset_f()
  def update_f_w(self, old: int, new: int) -> None:
    # F flag is set if the high bit changes.
    if (old & 0x8000) != (new & 0x8000):
      self.set_f()
    else:
      self.reset_f()

  # Get/set/reset/update the link flag.
  def get_l(self) -> int:
    return self._l
  def set_l(self) -> None:
    self._l = 1
  def reset_l(self) -> None:
    self._l = 0
  def update_l_b(self, val: int) -> None:
    # L flag is set if there is overflow.
    if (val & 0x100) != 0:
      self.set_l()
    else:
      self.reset_l()
  def update_l_w(self, val: int) -> None:
    # L flag is set if there is overflow.
    if (val & 0x10000) != 0:
      self.set_l()
    else:
      self.reset_l()

  # Get/set/reset/update the minus flag.
  def get_m(self) -> int:
    return self._m
  def set_m(self) -> None:
    self._m = 1
  def reset_m(self) -> None:
    self._m = 0
  def update_m_b(self, val: int) -> None:
    # M flag is set if the value has the high bit set.
    if (val & 0x80) != 0:
      self.set_m()
    else:
      self.reset_m()
  def update_m_w(self, val: int) -> None:
    # M flag is set if the value has the high bit set.
    if (val & 0x8000) != 0:
      self.set_m()
    else:
      self.reset_m()

  # Get/set/reset/update the value flag.
  def get_v(self) -> int:
    return self._v
  def set_v(self) -> None:
    self._v = 1
  def reset_v(self) -> None:
    self._v = 0
  def update_v(self, val: int) -> None:
    # V flag is set if the value is 0, reset if not.
    if val == 0:
      self.set_v()
    else:
      self.reset_v()

# Branch tracking.
class Branches:
  # Maximum hit count.
  max_hits = 20

  # A branch address and choice.
  class AddrChoice:
    def __init__(self, addr: int, choice: bool):
      self.addr = addr
      self.choice = choice

    def __repr__(self):
      return f"{self.addr},{self.choice}"

    def __eq__(self, other: "Branches.AddrChoice") -> bool:
      return self.addr == other.addr and self.choice == other.choice

    def __hash__(self) -> int:
      return self.addr | (self.choice << 16)

  # Initialize.
  def __init__(self, addr: int, sub: int, x: int):
    # The address where the branch context was started.
    self.start = addr

    # The address of the subroutine being called.
    self.sub_start = sub

    # The X register value when the context was started.
    self.x = x

    # The hit counts.
    self._hits = { } # type: Dict[Branches.AddrChoice, int]

  # Update the hit count. Returns True if the count is less than the max or
  # False if the max has been hit.
  def hit(self, addr: int, choice: bool) -> bool:
    # If there is no entry yet, it's the first hit.
    ac = Branches.AddrChoice(addr, choice)
    if ac not in self._hits:
      self._hits[ac] = 1
      return True
    else:
      # Increment the count and check it.
      self._hits[ac] += 1
      return self._hits.get(ac) <= Branches.max_hits

# Parser.
class Parser:
  # Sector size.
  sector_bytes = 400

  # Datestamp base.
  date_base = 693594

  # Initialize.
  def __init__(self, cmdargs, file: bytes, fname: str):
    # Store reference to the input file.
    self._infile = file

    # Get arguments.
    self._baseaddr = int(cmdargs.base, 0)
    self._isrom = cmdargs.rom
    self._iscpu5 = cmdargs.cpu5
    self._has_entry_table = cmdargs.table
    self._entrypoint = int(cmdargs.entry, 0)
    self._printaddr = not cmdargs.noaddr
    self._minimal = cmdargs.minimal
    self._name = cmdargs.name
    if len(self._name) == 0:
      self._name = fname.upper().lstrip('X')
    self._cvxasm = cmdargs.cvxasm
    self._cvxrel = cmdargs.cvxrel
    if self._cvxasm != '' and self._cvxrel != '':
      raise ValueError("Specify only cvxasm or cvxrel.")
    self._forceaddrs = \
      [ int(x, 0) - self._baseaddr for x in cmdargs.force.split() ]
    self._jsrs = \
      { int(x.split(':')[0], 0) - self._baseaddr: int(x.split(':')[1], 0) \
        for x in cmdargs.jsrs.split() }
    if len(cmdargs.subs) != 0:
      subs = cmdargs.subs.split(';;')
      self._subs = \
        { int(x.split(':')[0], 0) - self._baseaddr: \
            x[x.index(':')+1:].replace(';', '\n') for x in subs }
      self._forceaddrs += self._subs.keys()
    else:
      self._subs = { }
    if len(cmdargs.isubs) != 0:
      isubs = cmdargs.isubs.split(';;')
      self._isubs = \
        { int(x.split(':')[0], 0): \
            x[x.index(':')+1:].replace(';', '\n') for x in isubs }
    else:
      self._isubs = { }
    self._flabels = \
      { int(x.split(':')[0], 0) - self._baseaddr: x.split(':')[1] \
        for x in cmdargs.flabels.split() }
    self._vlabels = \
      { int(x.split(':')[0], 0) - self._baseaddr: x.split(':')[1] \
        for x in cmdargs.vlabels.split() }

    # Relocated file.
    self._relocated = bytearray()

    # Attributes.
    self._attrs = { } # type: Dict[int, Attrs]

    # Machine state and snapshots to resume.
    self._vm = VM(self._relocated)
    self._snapshots = [ ] # type: List[VM]

    # Branch tracking and stack of contexts.
    self._bh = Branches(0, 0, 0)
    self._branches = [ ] # type: List[Branches]

    # Known data addresses.
    self._datas = set() # type: Set[int]

  # Parse the file.
  def parse(self) -> bool:
    # Create the chunk list from the CVX'd input file if not a ROM format.
    if not self._isrom:
      if not self._cvx():
        return False
    else:
      # If ROM format, create the chunk list from the input file.
      if not self._rom():
        return False

    # Success.
    return True

  # Analyze the chunks, creating smaller chunks and assigning attributes.
  def analyze(self) -> None:
    # Put force addresses in first so they will be processed last as snapshots.
    # Use the force address as the entry point.
    for addr in self._forceaddrs:
      self._snapshots.append(VM(self._relocated, self._baseaddr, addr))

    # Set the initial machine state.
    main_entry = self._entrypoint
    if self._has_entry_table:
      # Read the entry table. Add a VM for each entry point.
      off = main_entry
      attrs = self._new_attr_word(off)
      attrs.comment += ' [Entry point count - 2]'
      num_entries = int.from_bytes(self._relocated[off:off+2], 'big') + 2
      for i in range(num_entries):
        off += 2
        attrs = self._get_attrs(off, -1)
        attrs.comment += ' [Entry point]'
        curr_entry = int.from_bytes(self._relocated[off:off+2], 'big')
        curr_entry -= self._baseaddr
        self._vm = VM(self._relocated, self._baseaddr, curr_entry)
        self._snapshots.append(self._vm)
    else:
      # If this is a normal executable, set up the VM with the single entry
      # point.
      self._vm = VM(self._relocated, self._baseaddr, main_entry)
      self._snapshots.append(self._vm)

    # Follow the execution path starting at the entry point to identify opcodes.
    # Catch errors and defer them.
    err = None
    try:
      self._read_opcodes()
    except ValueError as ve:
      err = ve

    # Mark the chunk with the entry point as such. Also mark additional entry
    # points if they exist.
    attrs = self._get_attrs(main_entry, -1)
    attrs.label = 'ENTRY'
    if self._has_entry_table:
      off = main_entry
      for i in range(num_entries):
        off += 2
        curr_entry = int.from_bytes(self._relocated[off:off+2], 'big')
        curr_entry -= self._baseaddr
        attrs = self._get_attrs(curr_entry, -1)
        attrs.label = "ENT{0:02d}".format(i)

    # Create label placeholders.
    self._label_placeholders()

    # User-defined labels.
    for off, label in self._flabels.items():
      try:
        attrs = self._get_attrs(off, -1)
        attrs.label = label
        attrs.labeledFunc = True
      except:
        print('***Address 0x{0:04X} for function {1} not defined.'.format(
          off + self._baseaddr, label))
    for off, label in self._vlabels.items():
      try:
        attrs = self._get_attrs(off, -1)
        attrs.label = label
      except:
        print('***Address 0x{0:04X} for variable {1} not defined.'.format(
          off + self._baseaddr, label))

    # Determine data types for non-opcode sections.
    self._read_data()

    # Format arguments.
    self._format_args()

    # Raise a deferred error.
    if err is not None:
      raise err

  # Write the output.
  def write_output(self) -> None:
    # Describe the label naming scheme.
    if not self._minimal:
      print('* Label naming:')
      print('* ENTRY = Main entry point')
      print('* ENTnn = Additional entry point')
      print('* B = Byte')
      print('* D = Displaced branch/jump target')
      print('* F = Function JSR target')
      print('* I = 32-bit integer')
      print('* J = Jump target')
      print('* L = Label (generic)')
      print('* N = Bignum')
      print('* P = Pointer')
      print('* S = String')
      print('* W = Word')
      print('*')

    # Start the program.
    if not self._printaddr:
      print(" TITLE '{0}'".format(self._name))
      if self._isrom:
        print("{0} BEGIN X'{1:04X}'".format('Z' + self._name, self._baseaddr))
      else:
        print("{0} BEGIN 0".format('Z' + self._name))
      if not self._minimal:
        print('*')

    # Write each chunk.
    addr = 0
    comment = ''
    next_end = False
    prev_end = False
    endaddr = len(self._relocated)
    while addr < endaddr:
      # Get the attributes, which must exist. Format the comment.
      attrs = self._get_attrs(addr, -1)
      if not self._minimal:
        comment = " ; {0}".format(attrs.comment) if attrs.comment != '' else ''

      if not self._minimal:
        # If this chunks looks like it starts a function, mark it.
        if attrs.label.startswith('F') or attrs.label.startswith('ENT') or \
           attrs.labeledFunc:
          if not prev_end:
            print('*')
          print("* Function {0}".format(attrs.label))
          print('*')
        prev_end = False

      # Print with address if desired.
      if self._printaddr:
        fixedaddr = addr + self._baseaddr
        if attrs.opcode == 'DS':
          machinecode = ''
        else:
          trimmedlen = min(attrs.num_bytes, 3)
          machinecode = self._relocated[addr:addr+trimmedlen].hex().upper() + \
                        (' ' if trimmedlen == attrs.num_bytes else '+')
        if self._minimal:
          print("{0:x}({1}){2} {3} {4}".format(fixedaddr,
                                               machinecode,
                                               attrs.label,
                                               attrs.opcode,
                                               attrs.args))
        else:
          print("{0:04x}({1:7s}){2:5s} {3:5s} {4:10s}{5}".format(
            fixedaddr,
            machinecode,
            attrs.label,
            attrs.opcode,
            attrs.args,
            comment))
      else:
        # Or without, in XASSM-input format.
        if self._minimal:
          print("{0} {1} {2}".format(attrs.label, attrs.opcode, attrs.args))
        else:
          print("{0:5s} {1:5s} {2:10s}{3}".format(attrs.label,
                                                  attrs.opcode,
                                                  attrs.args,
                                                  comment))
      addr += attrs.num_bytes

      if not self._minimal:
        # If the chunk just written looks like it ends a function or the SVC
        # calls to abort/exit with the code in AL, mark it.
        if next_end or \
           attrs.opcode == 'RI' or \
           attrs.opcode == 'RSR' or \
           attrs.opcode == 'RSV' or \
           (attrs.opcode == 'SVC' and \
             (attrs.args == "X'6B'" or attrs.args == "X'6C'")):
          print('*')
          next_end = False
          prev_end = True
        elif attrs.opcode == 'SVC' and \
             (attrs.args == "X'09'" or attrs.args == "X'0A'"):
          # The next chunk is the argument for aborting/exiting, so end the
          # function after that.
          next_end = True
        elif attrs.opcode.startswith('JMP'):
          # If this is an unconditional jump and the next chunk is data, it's
          # the end of the function.
          if addr < len(self._relocated):
            next_attrs = self._get_attrs(addr, -1)
            if next_attrs.opcode == 'DB' or next_attrs.opcode == 'DC' or \
               next_attrs.opcode == 'DS' or next_attrs.opcode == 'DW':
              print('*')
              next_end = False
              prev_end = True
        elif attrs.opcode == 'DB' or attrs.opcode == 'DC' or \
             attrs.opcode == 'DS' or attrs.opcode == 'DW':
          # If there are data chunks followed by a displaced target, jump
          # target, or force target, separate the data from the code.
          if addr < len(self._relocated):
            next_attrs = self._get_attrs(addr, -1)
            if next_attrs.label.startswith('D') or \
               next_attrs.label.startswith('J') or \
               addr in self._forceaddrs or \
               addr in self._jsrs or \
               addr in self._subs:
              print('*')

    # End the program.
    if self._printaddr:
      fixedaddr = len(self._relocated) + self._baseaddr
      if self._minimal:
        print("{0:x}:ENDPT".format(fixedaddr))
      else:
        print("{0:04x}:ENDPT".format(fixedaddr))
    else:
      print('ENDPT END ENTRY')

  # CVX the input file to create the chunk list.
  def _cvx(self) -> bool:
    # Keep reading records until the entry point record is hit or we hit the
    # end.
    offset = 0
    endoff = len(self._infile) - 4
    while offset <= endoff:
      # Reset the checksum.
      csum = 0

      # Read the record type.
      rt = self._infile[offset]
      csum += rt
      offset += 1

      # Read the length.
      rlen = self._infile[offset]
      csum += rlen
      offset += 1

      # Read the address.
      addr = int.from_bytes(self._infile[offset:offset+2], 'big')
      csum += self._infile[offset]
      csum += self._infile[offset + 1]
      offset += 2

      # Handle each record type.
      if rt == 0x80 or (self._iscpu5 and rt == 0xFF):
        # End of sector. Skip to the next sector.
        offset = ((offset + (Parser.sector_bytes - 1)) // \
                 Parser.sector_bytes) * Parser.sector_bytes
      elif rt == 0x00:
        # Copy or entry point.
        if rlen == 0:
          # Zero length means the address is the entry point. But don't
          # override a provided one.
          if self._entrypoint == 0:
            self._entrypoint = addr
        else:
          # Copy the chunk to the address.
          cdata = bytearray(self._infile[offset:offset+rlen])
          if addr == len(self._relocated):
            # If it's at the next spot, just append it.
            self._relocated += cdata
          elif addr < len(self._relocated):
            # ORG can change the assembly position to overwrite things. Cases:
            # 1. It overwrites a subset of uninitialized memory.
            # 2. It overlaps uninitialized and inititialized memory.
            # 3. It overwrites a subset of initialized memory.
            # 4. It overwrites initialized memory and extends beyond curr size.

            # Determine the new ending address.
            new_end = addr + rlen

            # Handle parent block.
            p_attrs, _ = self._get_parent(addr)
            if p_attrs is not None:
              raise ValueError("TODO: Overlaying parent.")
            else:
              # If we're at the end, just remove and replace.
              if new_end >= len(self._relocated):
                self._relocated = self._relocated[0:addr] + cdata
              else:
                raise ValueError("TODO: Overlaying middle.")
          else:
            # If there is a hole, fill it.
            hb = addr - len(self._relocated)
            hole = bytearray(hb)
            attrs = self._get_attrs(len(self._relocated), hb)
            self._relocated += hole
            attrs.is_something = True
            attrs.opcode = 'DS'
            attrs.args = "{0}".format(hb)
            attrs.comment = "=0x{0:04x} [Uninitialized memory]".format(hb)

            # And then append.
            self._relocated += cdata
          offset += rlen

          # Add each value to the checksum.
          for i in cdata:
            csum += i

        # Add the checksum byte and verify.
        csum += self._infile[offset]
        offset += 1
        if csum & 0xFF != 0:
          print("Invalid checksum at 0x{0:04x}".format(offset - 1),
                file=sys.stderr)
          return False

        # If we hit the entry point record, we're done.
        if rlen == 0:
          offset = endoff + 1
      elif rt == 0x01 or rt == 0xFF:
        # If length is odd, it's an error.
        if (rlen & 1) != 0:
          print("Invalid fixup length at 0x{0:04x}".format(offset - 3),
                file=sys.stderr)
          return False

        # If we're saving assembled, don't do the relocations.
        if self._cvxasm != '':
          offset += rlen + 1
          continue

        # Perform each fixup.
        while rlen != 0:
          # Get the address that needs fixing.
          fixaddr = int.from_bytes(self._infile[offset:offset+2], 'big')

          # Extract that word. Apply the fixup.
          val = int.from_bytes(self._relocated[fixaddr:fixaddr+2], 'big')
          if rt == 0x01:
            val += addr + self._baseaddr
          else:
            val -= addr + self._baseaddr
          val &= 0xFFFF
          self._relocated[fixaddr] = val >> 8
          self._relocated[fixaddr + 1] = val & 0xFF

          # Mark it as a fixup and a word.
          attrs = self._new_attr_word(fixaddr)
          attrs.fixedup = True
          attrs.args = '{0}'
          attrs.arglabels.append(Attrs.ArgLabel(val, 'W'))

          # Add to the checksum and move to the next.
          csum += self._infile[offset]
          csum += self._infile[offset + 1]
          offset += 2
          rlen -= 2

        # Add the checksum byte and verify.
        csum += self._infile[offset]
        offset += 1
        if csum & 0xFF != 0:
          print("Invalid checksum at 0x{0:04x}".format(offset - 1),
                file=sys.stderr)
          return False
      else:
        print("Unknown record type at 0x{0:04x}".format(offset - 4),
              file=sys.stderr)
        return False

    # Save the assembled if desired.
    if len(self._cvxasm) != 0:
      outpath = Path(self._cvxasm)
      outpath.write_bytes(self._relocated)
      print("Entry point: 0x{0:04x}".format(self._entrypoint))

    # Save the relocated if desired.
    if len(self._cvxrel) != 0:
      outpath = Path(self._cvxrel)
      outpath.write_bytes(self._relocated)
      print("Entry point: 0x{0:04x}".format(self._entrypoint))

    # Success.
    return True

  # Copy the input file as a single chunk for ROM files.
  def _rom(self) -> bool:
    # The whole file is one chunk with no known attributes.
    self._relocated = bytearray(self._infile)
    return True

  # Return the attributes for the given address. If the length is less than
  # zero, the attributes must already exist; if greater than zero they must
  # not already exist; if zero they may or may not exist.
  def _get_attrs(self, addr: int, num_bytes: int) -> Attrs:
    if num_bytes < 0 and addr not in self._attrs:
      raise ValueError("No attributes found for 0x{0:04x}".format(addr))
    if num_bytes > 0 and addr in self._attrs:
      raise ValueError("Attributes already exist for 0x{0:04x}".format(addr))
    if num_bytes >= 0 and addr not in self._attrs:
      self._attrs[addr] = Attrs(num_bytes)
    return self._attrs.get(addr, Attrs(num_bytes))

  # Return the attributes that apply to the given address (and possibly more)
  # and the address of the parent start. Returns None, 0 if there are no
  # attributes that cover the address.
  def _get_parent(self, addr: int) -> tuple:
    # Scan backwards to find a parent block.
    p_attrs = None
    p_addr = addr
    while p_addr >= 0:
      if p_addr in self._attrs:
        p_attrs = self._attrs.get(p_addr)
        if p_addr + p_attrs.num_bytes <= addr:
          p_attrs = None
          p_addr = 0
        break
      p_addr -= 1
    return p_attrs, p_addr

  # Remove the attributes for the given address of the given size. Returns True
  # if the removed range is a fixup or False if not.
  def _rm_attrs(self, addr: int, num_bytes: int) -> Attrs:
    if addr in self._attrs:
      attrs = self._attrs.pop(addr)
      if attrs.num_bytes != num_bytes:
        raise ValueError("Size mismatch for 0x{0:04x}".format(addr))
      return attrs.fixedup
    return False

  # Create attributes for the byte at the given address. Returns the attributes.
  def _new_attr_byte(self, addr: int) -> Attrs:
    if addr in self._attrs:
      attrs = self._attrs.get(addr)
      if not attrs.is_byte:
        raise ValueError('Address is not a byte.')
    else:
      attrs = self._get_attrs(addr, 1)
      self._attr_byte(addr, attrs)
    self._datas.add(addr)
    return attrs

  # Create attributes for the word at the given address. Returns the attributes.
  def _new_attr_word(self, addr: int) -> Attrs:
    if addr in self._attrs:
      attrs = self._attrs.get(addr)
      if not attrs.is_word:
        raise ValueError('Address is not a word.')
    else:
      attrs = self._get_attrs(addr, 2)
      self._attr_word(addr, attrs)
    self._datas.add(addr)
    self._datas.add(addr + 1)
    return attrs

  # Create attributes for the word which is an address at the given address.
  # Returns the attributes.
  def _new_attr_address(self, addr: int, prefix: str, desc: str) -> Attrs:
    # Create as a word.
    attrs = self._new_attr_word(addr)

    # Set the description.
    attrs.comment += " [{0}]".format(desc)

    # Create the argument label if it is in range.
    val = int.from_bytes(self._relocated[addr:addr+2], 'big')
    if val >= self._baseaddr and val < self._baseaddr + len(self._relocated):
      attrs.args = '{0}'
      attrs.arglabels = [ Attrs.ArgLabel(val, prefix) ]

    # Mark it as data if not given the F prefix for a function call.
    if prefix != 'F':
      self._datas.add(addr)
      self._datas.add(addr + 1)

    # Return the attributes.
    return attrs

  # Create attributes for the opcode at the given address. Returns the
  # attributes.
  def _new_attr_opcode(self, addr: int, num_bytes: int, opcode: str) -> Attrs:
    attrs = self._get_attrs(addr, num_bytes)
    attrs.opcode = opcode
    attrs.is_something = True
    attrs.is_opcode = True
    return attrs

  # Set attributes for the byte at the given address.
  def _attr_byte(self, addr: int, attrs: Attrs) -> None:
    # Get the value.
    val = self._relocated[addr]

    # Set the attributes.
    attrs.is_something = True
    attrs.is_byte = True

    # Create the opcode, args, and comment.
    attrs.opcode = 'DB'
    attrs.args = "X'{0:02X}'".format(val)
    attrs.comment = "=0x{0:02x} ={0}".format(val)
    if is_neg_b(val):
      attrs.comment += "({0})".format(neg_b(val))
    if is_printable(val):
      attrs.comment += " ={0}".format(qprintable(val))

    # Mark it as data.
    self._datas.add(addr)

  # Set attributes for the word at the given address.
  def _attr_word(self, addr: int, attrs: Attrs) -> None:
    # Get the value.
    b1 = self._relocated[addr]
    b2 = self._relocated[addr + 1]
    val = int.from_bytes(self._relocated[addr:addr+2], 'big')

    # Set the attributes.
    attrs.is_something = True
    attrs.is_word = True

    # Create the opcode, args, and comment.
    attrs.opcode = 'DW'
    attrs.args = "X'{0:04X}'".format(val)
    attrs.comment = "=0x{0:04x} ={0}".format(val)
    if is_neg_w(val):
      attrs.comment += "({0})".format(neg_w(val))
    if is_printable(b1) and is_printable(b2):
      attrs.comment += " ={0},{1}".format(qprintable(b1), qprintable(b2))

    # Mark it as data.
    self._datas.add(addr)
    self._datas.add(addr + 1)

  # Set attributes for the string at the given address.
  def _attr_string(self, addr: int, attrs: Attrs) -> None:
    # Get the value.
    rel = self._relocated
    endaddr = addr + attrs.num_bytes
    val = bytes([ch & 0x7F for ch in rel[addr:endaddr]]).decode()

    # Set the attributes.
    attrs.is_something = True
    attrs.is_string = True

    # Create the opcode, args, and comment.
    attrs.opcode = 'DC'
    attrs.args = "'{0}'".format(val)
    if attrs.num_bytes <= 10:
      attrs.comment = "hex:{0}".format(rel[addr:endaddr].hex())
      if attrs.num_bytes == 1:
        attrs.comment += " dec:{0}".format(rel[addr])
        if is_neg_b(rel[addr]):
          attrs.comment += "({0})".format(neg_b(rel[addr]))
      elif attrs.num_bytes == 2:
        ival = int.from_bytes(rel[addr:addr+2], 'big')
        attrs.comment += " dec:{0}".format(ival)
        if is_neg_b(ival):
          attrs.comment += "({0})".format(neg_b(ival))

    # Mark it as data.
    for i in range(attrs.num_bytes):
      self._datas.add(addr + i)

  # Set attributes for the byte-sized argument at the given address.
  def _attr_byte_arg(self, addr: int, attrs: Attrs) -> None:
    # Get the value.
    val = self._relocated[addr]

    # Put in the value.
    attrs.args += "X'{0:02X}'".format(val)
    attrs.comment += "={0}".format(val)
    if is_neg_b(val):
      attrs.comment += "({0})".format(neg_b(val))
    if is_printable(val):
      attrs.comment += " ={0}".format(qprintable(val))

  # Set attributes for the word-sized argument at the given address. Returns
  # the word value.
  def _attr_word_arg(self, addr: int, prefix: str, attrs: Attrs) -> int:
    # Get the value.
    b1 = self._relocated[addr]
    b2 = self._relocated[addr + 1]
    val = int.from_bytes(self._relocated[addr:addr+2], 'big')

    # If it is a fixup, create a format to fill in later with the label name.
    # Do the same if this is a ROM and the word value is within our memory
    # space and the target is a function. Also mark the target as data if the
    # word doesn't represent a function address.
    if self._rm_attrs(addr, 2) or \
       (prefix == 'F' and self._isrom and
        addr >= self._baseaddr and
        addr < len(self._relocated) + self._baseaddr):
      attrs.args += "{{{0}}}".format(len(attrs.arglabels))
      attrs.arglabels.append(Attrs.ArgLabel(val, prefix))
      if prefix != 'F':
        target = val - self._baseaddr
        self._datas.add(target)
        if prefix == 'W':
          self._datas.add(target + 1)
    else:
      # If not a fixup, put in the value.
      attrs.args += "X'{0:04X}'".format(val)
    attrs.comment += "=0x{0:04x} ={0}".format(val)
    if is_neg_w(val):
      attrs.comment += "({0})".format(neg_w(val))
    if is_printable(b1) and is_printable(b2):
      attrs.comment += " ={0},{1}".format(qprintable(b1), qprintable(b2))

    # Return the value.
    return val

  # Set attributes for the displacement argument at the given address. Returns
  # the displacement value.
  def _attr_displace_arg(self, addr: int, prefix: str, attrs: Attrs) -> int:
    # Get the value.
    disp = self._relocated[addr]
    if is_neg_b(disp):
      disp = neg_b(disp)

    # Create a format to fill in later with the label name. The displaced
    # address will be an opcode at some point.
    attrs.args = "{{{0}}}".format(len(attrs.arglabels))
    attrs.arglabels.append(Attrs.ArgLabel(addr + 1 + disp + self._baseaddr,
                                          prefix))
    attrs.comment = "={0:+}".format(disp)

    # Mark it as data if not given the D prefix for a branch/jump displacement
    # or F prefix for a function call.
    if prefix != 'D' and prefix != 'F':
      self._datas.add(addr)
      if prefix == 'W':
        self._datas.add(addr + 1)

    # Return the value.
    return disp

  # Set the arguments for dual-register arguments.
  def _attr_regs(self, sr: str, dr: str, desc: str, attrs: Attrs) -> None:
    # Set the arguments.
    attrs.args = "{0},{1}".format(sr, dr)

    # Format the comment.
    attrs.comment = desc.format(sr, dr)

  # Set the arguments and size for indexed addressing. The address given is of
  # the r+M' byte. The base register, pre-decrement flag, post-increment flag,
  # indirect flag, and displacement are returned.
  def _attr_indexed(self,
                    addr: int,
                    desc: str,
                    attrs: Attrs) -> Tuple[str, bool, bool, bool, int]:
    # Get the info. EE200 page 2-12.
    r, m = get_regs(self._relocated[addr])
    r = regaddress_word[r]
    argsuff = ''
    if (m & 0x2) != 0:
      opsuff = '-'
      argsuff = '-'
    elif (m & 0x1) != 0:
      opsuff = '+'
      argsuff = '+'
    else:
      opsuff = '+'
    indir = (m & 0x4) != 0
    disp = (m & 0x8) != 0

    # Handle indirect.
    if indir:
      argpre = '*'
    else:
      argpre = ''

    # Set the base register and pre-decrement or post-increment.
    attrs.opcode += opsuff
    attrs.args = "{0}{1}{2}".format(argpre, r, argsuff)

    # Handle displacement.
    if disp:
      attrs.num_bytes += 1
      damt = self._relocated[addr + 1]
      if is_neg_b(damt):
        damt = neg_b(damt)
      dispdec = "{0}".format(damt)
      attrs.args += ",{0}".format(dispdec)
    else:
      damt = 0

    # Create the comment.
    pre = False
    post = False
    attrs.comment = "[{0} indexed".format(desc)
    if argsuff == '-':
      attrs.comment += ', pre-decremented'
      pre = True
    if disp:
      attrs.comment += ', displaced'
    if indir:
      attrs.comment += ', indirect'
    else:
      attrs.comment += ', direct'
    if argsuff == '+':
      attrs.comment += ', post-incremented'
      post = True
    attrs.comment += ']'

    # Return the register, pre-decrement/post-increment, indirect, and
    # displacement amount.
    return r, pre, post, indir, damt

  # Create attribute placeholders for all argument label targets.
  def _label_placeholders(self) -> None:
    # Look at each attributes.
    for i in list(self._attrs.items()):
      # If there are labels to resolve, do them.
      attrs = i[1]
      for al in attrs.arglabels:
        # Get the parent attributes in case we need them later.
        addr = al.addr - self._baseaddr
        p_attrs, p_addr = self._get_parent(addr)

        # If there are parent attributes, handle adjusting them.
        if p_attrs is not None:
          # If it's the start of something, mark it as a fixup target.
          diff = addr - p_addr
          if diff == 0:
            p_attrs.fixup_target = True
          elif p_attrs.opcode == 'DS':
            # If not at the start and it's uninitialized memory, adjust the
            # settings in the target and parent to split the block.
            t_attrs = self._get_attrs(addr, p_attrs.num_bytes - diff)
            t_attrs.is_something = True
            t_attrs.opcode = 'DS'
            t_attrs.fixup_target = True
            t_attrs.args = "{0}".format(t_attrs.num_bytes)
            t_attrs.comment = \
              "=0x{0:04x} [Uninitialized memory]".format(t_attrs.num_bytes)
            p_attrs.num_bytes = diff
            p_attrs.args = "{0}".format(p_attrs.num_bytes)
            p_attrs.comment = \
              "=0x{0:04x} [Uninitialized memory]".format(p_attrs.num_bytes)
          else:
            # If not at the start and is not uninitialized, set it as an offset.
            al.offset = diff
        else:
          # Create placeholder attributes of zero length and marked as a fixup
          # target.
          t_attrs = self._get_attrs(addr, 0)
          t_attrs.fixup_target = True

  # Determine data types for non-opcode sections.
  def _read_data(self) -> None:
    # Scan all addresses for non-opcodes and give them meaning.
    addr = 0
    rel = self._relocated
    endaddr = len(rel)
    ascfunc = is_ascii if self._printaddr else is_ascii_nolower
    while addr < endaddr:
      # Get the attributes.
      attrs = self._get_attrs(addr, 0)
      if not attrs.is_something:
        # If it looks like ASCII, print it as a string.
        ch = rel[addr]
        if ascfunc(ch):
          # Started with an ASCII char. Get the run of chars.
          curraddr = addr + 1
          while curraddr < endaddr and curraddr not in self._attrs:
            ch = rel[curraddr]
            if curraddr - addr < 60 and ascfunc(ch):
              curraddr += 1
            else:
              break
          # Set the length.
          attrs.num_bytes = curraddr - addr
          # If we consumed the whole chunk, set its type.
          if curraddr == endaddr or curraddr in self._attrs:
            self._attr_string(addr, attrs)
          elif rel[curraddr] == 0x00:
            # If the end of ASCII was null, set attributes for the ASCII and
            # null terminator.
            self._attr_string(addr, attrs)
            self._new_attr_byte(curraddr)
            curraddr += 1
          elif rel[curraddr] == 0x8D:
            # If the end of ASCII was CR, set attributes for the ASCII and CR.
            self._attr_string(addr, attrs)
            attrs = self._new_attr_byte(curraddr)
            curraddr += 1
          else:
            # Otherwise split at the first non-ASCII character.
            self._attr_string(addr, attrs)
        elif ch == 0:
          # Find the end of the run of zeros.
          curraddr = addr + 1
          while curraddr < endaddr and curraddr not in self._attrs:
            ch = rel[curraddr]
            if ch == 0:
              curraddr += 1
            else:
              break
          # Set the length.
          attrs.num_bytes = curraddr - addr
          # If the run is one byte and this is the target of a fixup and the
          # next byte is not attributed, call it a word.
          if attrs.num_bytes == 1 and attrs.fixup_target and \
             curraddr < endaddr and curraddr not in self._attrs:
            curraddr += 1
            attrs.num_bytes = 2
            self._attr_word(addr, attrs)
          elif attrs.num_bytes == 1:
            # If the run is one, the next byte is not attributed, but the one
            # after is, this is probably a word with high byte zero.
            if curraddr not in self._attrs and curraddr + 1 in self._attrs:
              curraddr += 1
              attrs.num_bytes = 2
              self._attr_word(addr, attrs)
            else:
              # If the run is one byte, define as a byte.
              self._attr_byte(addr, attrs)
          elif attrs.num_bytes == 2:
            # If the run is two bytes, define as a word.
            self._attr_word(addr, attrs)
          else:
            # Longer runs define as repeated bytes.
            attrs.is_something = True
            attrs.is_string = True
            attrs.opcode = 'DB'
            attrs.args = "0,{0}".format(attrs.num_bytes)
            attrs.comment = "=0x00,0x{0:04x}".format(attrs.num_bytes)
        elif addr + 1 < len(self._relocated) and addr + 1 not in self._attrs:
          # More than a byte. Check if the next byte is ASCII.
          curraddr = addr + 1
          if curraddr < endaddr and ascfunc(self._relocated[curraddr]):
            # Call it a byte because the next byte may start an ASCII string.
            attrs.num_bytes = 1
            self._attr_byte(addr, attrs)
          else:
            # Call it a word.
            attrs.num_bytes = 2
            self._attr_word(addr, attrs)
            curraddr = addr + 2
        else:
          # Exactly one byte, so call it one.
          attrs.num_bytes = 1
          self._attr_byte(addr, attrs)
          curraddr = addr + 1
      else:
        # Attributes already define something, so skip to the next possible
        # address.
        curraddr = addr + attrs.num_bytes
      # Move to the next chunk.
      addr = curraddr

  # Format arguments.
  def _format_args(self) -> None:
    # Look at each attributes.
    for _, attrs in self._attrs.items():
      # If there are labels to resolve, do them.
      if len(attrs.arglabels) != 0:
        # Do each label.
        labels = []
        for al in attrs.arglabels:
          addr = al.addr - self._baseaddr - al.offset
          if addr == len(self._relocated):
            labels.append('ENDPT')
          else:
            target_attrs = self._attrs.get(addr)
            # If there is no label yet, create one based on the type.
            if target_attrs.label == '':
              target_attrs.label = "{0}{1:04X}".format(
                'S' if target_attrs.is_string and not al.prefix == 'N' else
                al.prefix, al.addr - al.offset)
            # Add this label.
            if al.offset == 0:
              labels.append(target_attrs.label)
            else:
              labels.append("{0}+{1}".format(target_attrs.label, al.offset))
        # Format with the labels.
        attrs.args = attrs.args.format(*labels)

  # Check for too much recursion. If there are too many branches from the same
  # start point, it's recursing without end.
  def _check_recursion(self) -> bool:
    counts = { } # type: Dict[int, int]
    for b in self._branches:
      if b.start in counts:
        counts[b.start] += 1
      else:
        counts[b.start] = 1
    for _, c in counts.items():
      if c > Branches.max_hits:
        return False
    return True

  # Return the length of arguments following a JSR to the given subroutine
  # address. Returns -1 if unknown.
  def _sub_args(self, jsr_addr: int, jsr_bytes: int, sub_addr: int) -> int:
    # Check for known JSR location.
    if jsr_addr in self._jsrs:
      return self._jsrs.get(jsr_addr)

    # Check for known subroutine.
    if sub_addr not in self._subs:
      return -1

    # Evaluate the provided expression to determine the argument length given
    # the memory following the JSR.
    expression = self._subs[sub_addr]
    arg_mem = self._relocated[jsr_addr+jsr_bytes:]
    return eval(expression, { }, { 'args': arg_mem })

  # Return the length of arguments following an indirect JSR to the given
  # indirect address. Returns -1 if unknown.
  def _isub_args(self, jsr_addr: int, jsr_bytes: int, ind_addr: int) -> int:
    # Check for known JSR location.
    if jsr_addr in self._jsrs:
      return self._jsrs.get(jsr_addr)

    # Check for known subroutine.
    if ind_addr not in self._isubs:
      return -1

    # Evaluate the provided expression to determine the argument length given
    # the memory following the JSR.
    expression = self._isubs[ind_addr]
    arg_mem = self._relocated[jsr_addr+jsr_bytes:]
    return eval(expression, { }, { 'args': arg_mem })

  # Read opcodes for each snapshotted state.
  def _read_opcodes(self) -> None:
    # Process all snapshots.
    virtstart = self._baseaddr
    virtend = virtstart + len(self._relocated)
    while len(self._snapshots) != 0:
      # Get the machine state.
      self._vm = self._snapshots.pop()
      pc = self._vm.get_pc()

      # If the current location is already disassembled, we don't need to use
      # this snapshot.
      addr = pc - self._baseaddr
      p_attrs, _ = self._get_parent(addr)
      if p_attrs is not None:
        continue

      # Create a fresh branch context.
      self._bh = Branches(0xFFFF, 0xFFFF, self._vm.get_reg_w('X'))
      self._branches = [ ]

      # Read until EOF.
      while pc >= virtstart and pc < virtend:
        # Get the address. Check that we didn't go in the middle of an
        # instruction.
        addr = pc - self._baseaddr
        if addr not in self._attrs:
          p_attrs, _ = self._get_parent(addr)
          if p_attrs is not None:
            break

        # Get the first byte of the opcode and dispatch to the appropriate
        # handler.
        first = self._relocated[addr]
        self._ophandlers[first](self, addr)
        pc = self._vm.get_pc()

  # Opcode 00 (HALT)
  def _op00(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'HLT')
      attrs.comment = '[Halt]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 01 (NOP)
  def _op01(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'NOP')
      attrs.comment = '[No operation]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 02 (SF)
  def _op02(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SF')
      attrs.comment = '[Set fault]'
    # Execute.
    vm = self._vm
    vm.set_f()
    vm.incr_pc()

  # Opcode 03 (RF)
  def _op03(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'RF')
      attrs.comment = '[Reset fault]'
    # Execute.
    vm = self._vm
    vm.reset_f()
    vm.incr_pc()

  # Opcode 04 (EI)
  def _op04(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'EI')
      attrs.comment = '[Enable interrupt system]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 05 (DI)
  def _op05(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DI')
      attrs.comment = '[Disable interrupt system]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 06 (SL)
  def _op06(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SL')
      attrs.comment = '[Set link]'
    # Execute.
    vm = self._vm
    vm.set_l()
    vm.incr_pc()

  # Opcode 07 (RL)
  def _op07(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'RL')
      attrs.comment = '[Reset link]'
    # Execute.
    vm = self._vm
    vm.reset_l()
    vm.incr_pc()

  # Opcode 08 (CL)
  def _op08(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'CL')
      attrs.comment = '[Complement link]'
    # Execute.
    vm = self._vm
    if vm.get_l():
      vm.reset_l()
    else:
      vm.set_l()
    vm.incr_pc()

  # Opcode 09 (RSR)
  def _op09(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'RSR')
      attrs.comment = '[Return from subroutine]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    aaddr = ea - self._baseaddr
    if aaddr not in self._attrs:
      parent, paddr = self._get_parent(aaddr)
      if parent is not None and paddr != aaddr:
        # If the return address is in the middle of something already known, we
        # probably are in a snapshot and X got overupdated or similar, so just
        # end disassembly.
        vm.set_pc(0xFFFF)
        return
    else:
      attrs = self._get_attrs(aaddr, -1)
      if not attrs.is_opcode:
        # If the return address is to known data, we are probably in a snapshot
        # with incorrect X updates, so just end disassembly.
        vm.set_pc(0xFFFF)
        return
    # Add an entry for this JSR so if it is hit again we can skip over it.
    argbytes = ea - self._bh.x
    if argbytes >= 0:
      if self._bh.start not in self._jsrs:
        self._jsrs[self._bh.start] = argbytes
      if argbytes == 0 and self._bh.sub_start not in self._subs:
        self._subs[self._bh.sub_start] = '0'
    # Set the new effective address and pop X.
    vm.set_pc(ea)
    vm.set_reg_w('X', vm.pop_w())
    # Pop the branch context.
    if len(self._branches) != 0:
      self._bh = self._branches.pop()
    else:
      self._bh = Branches(0xFFFF, ea - self._baseaddr, 0xFFFF)

  # Opcode 0A (RI)
  def _op0A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'RI')
      attrs.comment = '[Return from interrupt]'
    # Execute. Can't continue because execution would return to a different
    # interrupt level and PC.
    self._vm.set_pc(0xFFFF)

  # Opcode 0B (Illegal opcode)
  def _op0B(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode 0B]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 0C (SYN)
  def _op0C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SYN')
      attrs.comment = '[Flash abort light for 200ns]'
    # Execute. Nothing to do.
    self._vm.incr_pc()

  # Opcode 0D (PCX)
  def _op0D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'PCX')
      attrs.comment = '[Transfer PC to X]'
    # Execute.
    vm = self._vm
    pc = vm.get_pc()
    vm.set_reg_w('X', pc)
    vm.incr_pc()

  # Opcode 0E (DLY)
  def _op0E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DLY')
      attrs.comment = '[Delay 4.55 ms]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 0F (RSV)
  def _op0F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'RSV')
      attrs.comment = '[Return from service call]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 10 (BL)
  def _op10(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BL')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on link]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if vm.get_l():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 11 (BNL)
  def _op11(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BNL')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on no link]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if not vm.get_l():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 12 (BF)
  def _op12(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BF')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on fault]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if vm.get_f():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 13 (BNF)
  def _op13(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BNF')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on no fault]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if not vm.get_f():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.set_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.reset_f()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 14 (BZ)
  def _op14(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BZ')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if zero]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if vm.get_v():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 15 (BNZ)
  def _op15(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BNZ')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if not zero]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if not vm.get_v():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.set_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.reset_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 16 (BM)
  def _op16(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BM')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on minus]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if vm.get_m():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_m()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_m()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 17 (BP)
  def _op17(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BP')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch on plus]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if not vm.get_m():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.set_m()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.reset_m()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 18 (BGZ)
  def _op18(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BGZ')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if greater than zero]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if not vm.get_m() and not vm.get_v():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.set_m()
          snap.set_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.reset_m()
          snap.reset_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 19 (BLE)
  def _op19(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BLE')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if less than or equal to zero]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if vm.get_m() or vm.get_v():
      if self._bh.hit(addr, True):
        vm.set_pc(true_ea)
        if unseen and false_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(false_ea)
          snap.reset_m()
          snap.reset_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)
    else:
      if self._bh.hit(addr, False):
        vm.set_pc(false_ea)
        if unseen and true_ea - self._baseaddr not in self._attrs:
          snap = VM(vm)
          snap.set_pc(true_ea)
          snap.set_m()
          snap.set_v()
          self._snapshots.append(snap)
      else:
        vm.set_pc(0xFFFF)

  # Opcode 1A (BS1)
  def _op1A(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BS1')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if Sense Switch 1 set]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 1B (BS2)
  def _op1B(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BS2')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if Sense Switch 2 set]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 1C (BS3)
  def _op1C(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BS3')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if Sense Switch 3 set]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 1D (BS4)
  def _op1D(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BS4')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if Sense Switch 4 set]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 1E (BI)
  def _op1E(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BI')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if interrupts enabled]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 1F (BCK)
  def _op1F(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'BCK')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Branch if clock interrupt enabled]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute. Assume it is set.
    vm = self._vm
    false_ea = (vm.get_pc() + 2) & 0xFFFF
    true_ea = (false_ea + disp) & 0xFFFF
    if self._bh.hit(addr, True):
      vm.set_pc(true_ea)
      if unseen and false_ea - self._baseaddr not in self._attrs:
        snap = VM(vm)
        snap.set_pc(false_ea)
        snap.reset_m()
        snap.reset_v()
        self._snapshots.append(snap)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 20 (INRB)
  def _op20(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'INRB')
      attrs.args = sr
      attrs.comment = "[Increment {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr)
    new = old + amt
    newmod = new & 0xFF
    vm.set_reg_b(sr, newmod)
    vm.update_f_b(old, newmod)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 21 (DCRB)
  def _op21(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'DCRB')
      attrs.args = sr
      attrs.comment = "[Decrement {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr)
    new = old - amt
    newmod = new & 0xFF
    vm.set_reg_b(sr, newmod)
    vm.update_f_b(old, newmod)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 22 (CLRB)
  def _op22(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    _, val = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/value. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'CLRB')
      attrs.args = sr
      if val == 0:
        attrs.comment = "[Clear {0}]".format(sr)
      else:
        attrs.args += ",{0}".format(val)
        attrs.comment = "[Set {0} to {1}]".format(sr, val)
    # Execute.
    vm = self._vm
    vm.set_reg_b(sr, val)
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.update_v(val)
    vm.incr_pc(2)

  # Opcode 23 (IVRB)
  def _op23(self, addr: int) -> None:
    # Get the register.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register.
      attrs = self._new_attr_opcode(addr, 2, 'IVRB')
      attrs.args = sr
      if amt == 0:
        attrs.comment = "[Invert {0}]".format(sr)
      else:
        attrs.comment = "[Invert {0} and add {1}]".format(sr, amt)
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr)
    new = ~old & 0xFF
    vm.set_reg_b(sr, new)
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc(2)

  # Opcode 24 (SRRB)
  def _op24(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'SRRB')
      attrs.args = sr
      attrs.comment = "[Arithmetic right shift {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr)
    old |= (0xFFFF00 if (old & 0x80) != 0 else 0)
    new = (old >> amt) & 0xFF
    vm.set_reg_b(sr, new)
    if ((old >> (amt - 1)) & 0x1) == 0:
      vm.reset_l()
    else:
      vm.set_l()
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc(2)

  # Opcode 25 (SLRB)
  def _op25(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'SLRB')
      attrs.args = sr
      attrs.comment = "[Left shift {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr)
    new = old << amt
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b(sr, newmod)
    vm.update_f_b(old, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 26 (RRRB)
  def _op26(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'RRRB')
      attrs.args = sr
      attrs.comment = "[Right rotate {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr) | (vm.get_l() << 8)
    new = (old >> amt) | (old << (9 - amt))
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b(sr, newmod)
    vm.update_f_b(old, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 27 (RLRB)
  def _op27(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    _, amt = get_regs(regs)
    sr, _ = get_regs_bb(regs)
    amt += 1
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
      attrs = self._new_attr_opcode(addr, 2, 'RLRB')
      attrs.args = sr
      attrs.comment = "[Left rotate {0} by {1}]".format(sr, amt)
      if amt != 1:
        attrs.args += ",{0}".format(amt)
    # Execute.
    vm = self._vm
    old = vm.get_reg_b(sr) | (vm.get_l() << 8)
    new = (old << amt) | (old >> (9 - amt))
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b(sr, newmod)
    vm.update_f_b(old, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 28 (INAB)
  def _op28(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'INAB')
      attrs.comment = '[Increment AL]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_b('AL')
    new = old + 1
    newmod = new & 0xFF
    vm.set_reg_b('AL', newmod)
    vm.update_f_b(old, newmod)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 29 (DCAB)
  def _op29(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DCAB')
      attrs.comment = '[Decrement AL]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_b('AL')
    new = old - 1
    newmod = new & 0xFF
    vm.set_reg_b('AL', newmod)
    vm.update_f_b(old, newmod)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 2A (CLAB)
  def _op2A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'CLAB')
      attrs.comment = '[Clear AL]'
    # Execute.
    vm = self._vm
    vm.set_reg_b('AL', 0)
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.set_v()
    vm.incr_pc()

  # Opcode 2B (IVAB)
  def _op2B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'IVAB')
      attrs.comment = '[Invert AL]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_b('AL')
    new = ~old
    newmod = new & 0xFF
    vm.set_reg_b('AL', newmod)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 2C (SRAB)
  def _op2C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SRAB')
      attrs.comment = '[Arithmetic right shift AL]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_b('AL')
    new = old >> 1
    vm.set_reg_b('AL', new)
    vm.update_f_b(old, new)
    if (old & 0x1) == 0:
      vm.reset_l()
    else:
      vm.set_l()
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc()

  # Opcode 2D (SLAB)
  def _op2D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SLAB')
      attrs.comment = '[Left shift AL]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_b('AL')
    new = old << 1
    newmod = new & 0xFF
    vm.set_reg_b('AL', newmod)
    vm.update_f_b(old, newmod)
    vm.update_l_b(new)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 2E (Page map instructions)
  def _op2E(self, addr: int) -> None:
    # Get the selector and extended addressing modes.
    maddr = addr + 1
    smm = self._relocated[maddr]
    selector = smm >> 4
    mm = [ (smm >> 2) & 0x3, smm & 0x3 ]
    maddr += 1
    # Handle each selector.
    desc = ''
    desclit = ''
    opcode = ''
    is_count = False
    if selector == 0:
      # LDM. Has a count, not an index.
      opcode = 'LDM'
      desc = 'Load entries to page map'
      desclit = 'Load entries [0, {0}) to page map {1}'
      is_count = True
    elif selector == 1:
      # STM. Has a count, not an index.
      opcode = 'STM'
      desc = 'Store entries of page map'
      desclit = 'Store entries [0, {0}) of page map {1}'
      is_count = True
    elif selector == 2:
      # LSM.
      opcode = 'LSM'
      desc = 'Load an entry to page map'
      desclit = 'Load entry {0} to page map {1}'
    elif selector == 3:
      # SSM.
      opcode = 'SSM'
      desc = 'Store an entry of page map'
      desclit = 'Store entry {0} of page map {1}'
    elif selector == 4:
      # FLM.
      opcode = 'FLM'
      desc = 'Load entries to map'
      desclit = 'Load entries [{0}, 32) to page map {1}'
    else:
      raise ValueError("Unknown selector.")
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(1)
    else:
      # Start with the 1 opcode byte.
      attrs = self._new_attr_opcode(addr, 1, opcode)
    # Create the arguments and comments.
    mstr = ''
    regs = [ ]
    for i in range(2):
      m = mm[i]
      if m == 0:
        # Direct.
        attrs.args += '/'
        self._attr_word_arg(maddr, 'W', attrs)
        mstr += ', direct'
        maddr += 2
      elif m == 1:
        # Indexed with displacement. Get the registers.
        r1i, r2i = get_regs(self._relocated[maddr])
        r1, r2 = get_regs_ww(self._relocated[maddr])
        maddr += 1
        # If the first is even, it's a signed byte displacement; if odd it's a
        # word displacement.
        if (r1i & 1) == 0:
          disp = self._relocated[maddr]
          maddr += 1
          if is_neg_b(disp):
            disp = neg_b(disp)
        else:
          disp = int.from_bytes(self._relocated[maddr:maddr+2], 'big')
          maddr += 2
        # If the second is 0 it's single-register; if not it's a second register
        # to add to the displacement.
        if r2i == 0:
          attrs.args += "-{0},{1}".format(r1, disp)
          mstr += ', displaced indexed'
        else:
          attrs.args += "-{0}*{1},{2}".format(r1, r2, disp)
          mstr += ", displaced double-indexed"
      elif m == 2:
        # Indexed.
        if len(regs) == 0:
          regs = get_regs(self._relocated[maddr])
          maddr += 1
        attrs.args += "-{0}".format(regaddress_word[regs[i]])
        mstr += ', indexed'
      else:
        # Literal.
        lit = int.from_bytes(self._relocated[maddr:maddr+1], 'big')
        attrs.args += "=X'{0:02X}'".format(lit)
        mstr += ", literal={0}".format(lit)
        maddr += 1
        # If the first argument is a literal, decode it.
        if i == 0:
          maplvl = lit & 0x07
          cntidx = lit >> 3
          if is_count:
            cntidx = cntidx + 1
          desc = desclit.format(cntidx, maplvl)
      # Separate arguments.
      if i == 0:
        attrs.args += ','
        if attrs.comment != '':
          attrs.comment += ','
    if attrs.comment != '':
      attrs.comment += ' '
    attrs.comment += "[{0}{1}]".format(desc, mstr)
    attrs.num_bytes = maddr - addr
    # Execute. Page table are unlikely to affect disassembly, so just advance
    # the PC.
    self._vm.incr_pc(attrs.num_bytes)

  # Opcode 2F (DMA instructions)
  def _op2F(self, addr: int) -> None:
    # Get the register and selector.
    rs = self._relocated[addr + 1]
    selector = rs & 0x0F
    # Handle each selector.
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/selector.
      attrs = self._new_attr_opcode(addr, 2, 'DMA')
      if selector == 0:
        # SAD.
        r, _ = get_regs_ww(rs)
        attrs.args = "SAD,{0}".format(r)
        attrs.comment = \
          "[Store {0} register to DMA address register]".format(r)
      elif selector == 1:
        # RAD.
        r, _ = get_regs_ww(rs)
        attrs.args = "RAD,{0}".format(r)
        attrs.comment = \
          "[Read DMA address register to {0} register]".format(r)
      elif selector == 2:
        # SCT.
        r, _ = get_regs_ww(rs)
        attrs.args = "SCT,{0}".format(r)
        attrs.comment = \
          "[Store {0} register to DMA count register]".format(r)
      elif selector == 3:
        # RCT.
        r, _ = get_regs_ww(rs)
        attrs.args = "RCT,{0}".format(r)
        attrs.comment = \
          "[Read DMA count register to {0} register]".format(r)
      elif selector == 4:
        # SDV.
        device = rs >> 4
        attrs.args = "SDV,{0}".format(device)
        attrs.comment = '[Set DMA device]'
      elif selector == 5:
        # RDV. The low byte register is used but the word must be specified.
        r, _ = get_regs_ww(rs)
        ractual = regaddress_byte[(rs >> 4) | 1]
        attrs.args = "RDV,{0}".format(r)
        attrs.comment = "[Read DMA mode to {0} register]".format(ractual)
      elif selector == 6:
        # EAB.
        attrs.args = 'EAB'
        attrs.comment = '[Enable DMA]'
      elif selector == 7:
        # DAB.
        attrs.args = 'DAB'
        attrs.comment = '[Disable DMA]'
      elif selector == 8:
        # SMN. The low byte register is used but the word must be specified.
        r, _ = get_regs_ww(rs)
        ractual = regaddress_byte[(rs >> 4) | 1]
        attrs.args = "SMN,{0}".format(r)
        attrs.comment = "[Set DMA map number from {0} register]".format(ractual)
      elif selector == 9:
        # RMN. The low byte register is used but the word must be specified.
        r, _ = get_regs_ww(rs)
        ractual = regaddress_byte[(rs >> 4) | 1]
        attrs.args = "RMN,{0}".format(r)
        attrs.comment = "[Read DMA map number to {0} register]".format(ractual)
      else:
        raise ValueError("Unknown selector.")
    # Execute. DMA are unlikely to affect disassembly, so just advance the PC.
    self._vm.incr_pc(2)

  # Opcode 30 (INR/INC)
  def _op30(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is INC, not INR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'INC/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += " [Increment word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea)
        new = old + amt
        newmod = new & 0xFFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'INC-')
          attrs.comment = \
            "[Increment word at {0}{1:+d} by {2}]".format(sr, disp, amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea)
        new = old + amt
        newmod = new & 0xFFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'INR')
        attrs.args = sr
        attrs.comment = "[Increment {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si)
      new = old + amt
      newmod = new & 0xFFFF
      vm.set_reg_w(si, newmod)
      vm.update_f_w(old, newmod)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)

  # Opcode 31 (DCR/DEC)
  def _op31(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is DEC, not DCR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'DEC/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += " [Decrement word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea)
        new = old - amt
        newmod = new & 0xFFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'DEC-')
          attrs.comment = \
            "[Decrement word at {0}{1:+d} by {2}]".format(sr, disp, amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea)
        new = old - amt
        newmod = new & 0xFFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'DCR')
        attrs.args = sr
        attrs.comment = "[Decrement {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si)
      new = old - amt
      newmod = new & 0xFFFF
      vm.set_reg_w(sr, newmod)
      vm.update_f_w(old, newmod)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)

  # Opcode 32 (CLR/CAD)
  def _op32(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    si, val = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    vm = self._vm
    # If the register specified is a low-byte, this is CAD, not CLR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'CAD/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          if val == 0:
            attrs.comment = '[Clear word at address]'
          else:
            attrs.comment = "[Set word at address to {0}]".format(val)
          if val != 0:
            attrs.args += ",{0}".format(val)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        vm.set_mem_w(ea, val)
        vm.reset_f()
        vm.reset_l()
        vm.reset_m()
        vm.update_v(val)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'CAD-')
          if val == 0:
            attrs.comment = "[Clear word at {0}{1:+d}]".format(sr, disp)
          else:
            attrs.comment = \
              "[Set word at {0}{1:+d} to {0}]".format(sr, disp, val)
          attrs.args = "{0}".format(sr)
          if disp != 0 or val != 0:
            attrs.args += ",{0}".format(disp)
          if val != 0:
            attrs.args += ",{0}".format(val)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        vm.set_mem_w(ea, val)
        vm.reset_f()
        vm.reset_l()
        vm.reset_m()
        vm.update_v(val)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/value. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'CLR')
        attrs.args = sr
        if val == 0:
          attrs.comment = "[Clear {0}]".format(sr)
        else:
          attrs.comment = "[Set {0} to {1}]".format(sr, val)
        if val != 0:
          attrs.args += ",{0}".format(val)
      # Execute.
      vm.set_reg_w(sr, val)
      vm.reset_f()
      vm.reset_l()
      vm.reset_m()
      vm.update_v(val)
      vm.incr_pc(2)

  # Opcode 33 (IVR/IAD)
  def _op33(self, addr: int) -> None:
    # Get the register.
    regs = self._relocated[addr + 1]
    si, val = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    vm = self._vm
    # If the register specified is a low-byte, this is IAD, not IVR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'IAD/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          if val == 0:
            attrs.comment = '[Invert word at address]'
          elif val == 1:
            attrs.comment = '[Negate word at address]'
          else:
            attrs.comment = \
              "[Negate and add {0} word at address]".format(val - 1)
          if val != 0:
            attrs.args += ",{0}".format(val)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea)
        new = ~old & 0xFFFF
        vm.set_mem_w(ea, new)
        vm.update_m_w(new)
        vm.update_v(new)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'IAD-')
          if val == 0:
            attrs.comment = "[Invert word at {0}{1:+d}]".format(sr, disp)
          elif val == 1:
            attrs.comment = "[Negate word at {0}{1:+d}]".format(sr, disp)
          else:
            attrs.comment = \
              "[Negate and add {0} word at {1}{2:+d}]".format(val - 1, sr, disp)
          attrs.args = "{0}".format(sr)
          if disp != 0 or val != 0:
            attrs.args += ",{0}".format(disp)
          if val != 0:
            attrs.args += ",{0}".format(val)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea)
        new = ~old & 0xFFFF
        vm.set_mem_w(ea, new)
        vm.update_m_w(new)
        vm.update_v(new)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/value. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'IVR')
        attrs.args = sr
        if val == 0:
          attrs.comment = "[Invert {0}]".format(sr)
        elif val == 1:
          attrs.args += ',1'
          attrs.comment = "[Negate {0}]".format(sr)
        else:
          attrs.args += ",{0}".format(val)
          attrs.comment = "[Negate {0} and add {1}]".format(sr, val - 1)
      # Execute.
      old = vm.get_reg_w(sr)
      new = ~old & 0xFFFF
      vm.set_reg_w(sr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(2)

  # Opcode 34 (SRR/SHR)
  def _op34(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is SHR, not SRR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'SHR/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += \
            " [Arithmetic right shift word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea)
        old |= (0xFFFF00 if (old & 0x8000) != 0 else 0)
        new = (old >> amt) & 0xFFFF
        vm.set_mem_w(ea, new)
        if ((old >> (amt - 1)) & 0x1) == 0:
          vm.reset_l()
        else:
          vm.set_l()
        vm.update_m_w(new)
        vm.update_v(new)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'SHR-')
          attrs.comment = \
            "[Arithmetic right shift word at {0}{1:+d} by {2}]".format(sr,
                                                                       disp,
                                                                       amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea)
        old |= (0xFFFF00 if (old & 0x8000) != 0 else 0)
        new = (old >> amt) & 0xFFFF
        vm.set_mem_w(ea, new)
        if ((old >> (amt - 1)) & 0x1) == 0:
          vm.reset_l()
        else:
          vm.set_l()
        vm.update_m_w(new)
        vm.update_v(new)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'SRR')
        attrs.args = sr
        attrs.comment = "[Arithmetic right shift {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si)
      old |= (0xFFFF00 if (old & 0x8000) != 0 else 0)
      new = (old >> amt) & 0xFFFF
      vm.set_reg_w(si, new)
      if ((old >> (amt - 1)) & 0x1) == 0:
        vm.reset_l()
      else:
        vm.set_l()
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(2)

  # Opcode 35 (SLR/SHL)
  def _op35(self, addr: int) -> None:
    # Get the register and value.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is SHL, not SLR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'SHL/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += " [Left shift word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea)
        new = old << amt
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'SHL-')
          attrs.comment = \
            "[Left shift word at {0}{1:+d} by {2}]".format(sr, disp, amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea)
        new = old << amt
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'SLR')
        attrs.args = sr
        attrs.comment = "[Left shift {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si)
      new = old << amt
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(si, newmod)
      vm.update_f_w(old, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)

  # Opcode 36 (RRR/RTR)
  def _op36(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is RTR, not RRR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'RTR/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += " [Right rotate word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea) | (vm.get_l() << 16)
        new = (old >> amt) | (old << (17 - amt))
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'RTR-')
          attrs.comment = \
            "[Right rotate word at {0}{1:+d} by {2}]".format(sr, disp, amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea) | (vm.get_l() << 16)
        new = (old >> amt) | (old << (17 - amt))
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'RRR')
        attrs.args = sr
        attrs.comment = "[Right rotate {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si) | (vm.get_l() << 16)
      new = (old >> amt) | (old << (17 - amt))
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(si, newmod)
      vm.update_f_w(old, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)

  # Opcode 37 (RLR/RTL)
  def _op37(self, addr: int) -> None:
    # Get the register and amount.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    sr, _ = get_regs_ww(regs)
    amt += 1
    vm = self._vm
    # If the register specified is a low-byte, this is RTL, not RLR.
    if (si & 0x1) != 0:
      # If the register is A, it's direct address.
      if si == 1:
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 address.
          attrs = self._new_attr_opcode(addr, 4, 'RTL/')
          self._attr_word_arg(addr + 2, 'W', attrs)
          attrs.comment += " [Left rotate word at address by {0}]".format(amt)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_mem_w(vm.get_pc() + 2)
        old = vm.get_mem_w(ea) | (vm.get_l() << 16)
        new = (old << amt) | (old >> (17 - amt))
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
      else:
        # Indexed.
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        if addr not in self._attrs:
          # 4 bytes: 1 opcode, 1 register/amount, 2 displacement.
          attrs = self._new_attr_opcode(addr, 4, 'RTL-')
          attrs.comment = \
            "[Left rotate word at {0}{1:+d} by {2}]".format(sr, disp, amt)
          attrs.args = "{0}".format(sr)
          if disp != 0 or amt != 1:
            attrs.args += ",{0}".format(disp)
          if amt != 1:
            attrs.args += ",{0}".format(amt)
        # Execute.
        ea = vm.get_reg_w(sr) + disp
        old = vm.get_mem_w(ea) | (vm.get_l() << 16)
        new = (old << amt) | (old >> (17 - amt))
        newmod = new & 0xFFFF
        newlink = new & 0x1FFFF
        vm.set_mem_w(ea, newmod)
        vm.update_f_w(old, newmod)
        vm.update_l_w(newlink)
        vm.update_m_w(newmod)
        vm.update_v(newmod)
        vm.incr_pc(4)
    else:
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 register/amount. EE200 only had register.
        attrs = self._new_attr_opcode(addr, 2, 'RLR')
        attrs.args = sr
        attrs.comment = "[Left rotate {0} by {1}]".format(sr, amt)
        if amt != 1:
          attrs.args += ",{0}".format(amt)
      # Execute.
      old = vm.get_reg_w(si) | (vm.get_l() << 16)
      new = (old << amt) | (old >> (17 - amt))
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(si, newmod)
      vm.update_f_w(old, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)

  # Opcode 38 (INA)
  def _op38(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'INA')
      attrs.comment = '[Increment A]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('A')
    new = old + 1
    newmod = new & 0xFFFF
    vm.set_reg_w('A', newmod)
    vm.update_f_w(old, newmod)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 39 (DCA)
  def _op39(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DCA')
      attrs.comment = '[Decrement A]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('A')
    new = old - 1
    newmod = new & 0xFFFF
    vm.set_reg_w('A', newmod)
    vm.update_f_w(old, newmod)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 3A (CLA)
  def _op3A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'CLA')
      attrs.comment = '[Clear A]'
    # Execute.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.set_v()
    self._vm.incr_pc()

  # Opcode 3B (IVA)
  def _op3B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'IVA')
      attrs.comment = '[Invert A]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('A')
    new = ~old
    newmod = new & 0xFFFF
    vm.set_reg_w('A', newmod)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 3C (SRA)
  def _op3C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SRA')
      attrs.comment = '[Arithmetic right shift A]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('A')
    new = old >> 1
    vm.set_reg_w('A', new)
    vm.update_f_w(old, new)
    if (old & 0x1) == 0:
      vm.reset_l()
    else:
      vm.set_l()
    vm.update_m_w(new)
    vm.update_v(new)
    vm.incr_pc()

  # Opcode 3D (SLA)
  def _op3D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SLA')
      attrs.comment = '[Left shift A]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('A')
    new = old << 1
    newmod = new & 0xFFFF
    newlink = new & 0x1FFFF
    vm.set_reg_w('A', newmod)
    vm.update_f_w(old, newmod)
    vm.update_l_w(newlink)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 3E (INX)
  def _op3E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'INX')
      attrs.comment = '[Increment X]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('X')
    new = old + 1
    newmod = new & 0xFFFF
    vm.set_reg_w('X', newmod)
    vm.update_f_w(old, newmod)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 3F (DCX)
  def _op3F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DCX')
      attrs.comment = '[Decrement X]'
    # Execute.
    vm = self._vm
    old = vm.get_reg_w('X')
    new = old - 1
    newmod = new & 0xFFFF
    vm.set_reg_w('X', newmod)
    vm.update_f_w(old, newmod)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 40 (ADDB)
  def _op40(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'ADDB')
      self._attr_regs(sr, dr, "[{0} + {1} -> {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    dv = vm.get_reg_b(dr)
    new = sv + dv
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b(dr, newmod)
    vm.update_f_b(dv, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 41 (SUBB)
  def _op41(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'SUBB')
      self._attr_regs(sr, dr, "[{0} - {1} -> {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    dv = vm.get_reg_b(dr)
    new = sv - dv
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b(dr, newmod)
    vm.update_f_b(dv, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc(2)

  # Opcode 42 (ANDB)
  def _op42(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'ANDB')
      self._attr_regs(sr, dr, "[{0} & {1} -> {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    dv = vm.get_reg_b(dr)
    new = sv & dv
    vm.set_reg_b(dr, new)
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc(2)

  # Opcode 43 (ORIB)
  def _op43(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'ORIB')
      self._attr_regs(sr, dr, "[{0} | {1} -> {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    dv = vm.get_reg_b(dr)
    new = sv | dv
    vm.set_reg_b(dr, new)
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc(2)

  # Opcode 44 (OREB)
  def _op44(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'OREB')
      self._attr_regs(sr, dr, "[{0} ^ {1} -> {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    dv = vm.get_reg_b(dr)
    new = sv ^ dv
    vm.set_reg_b(dr, new)
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc(2)

  # Opcode 45 (XFRB)
  def _op45(self, addr: int) -> None:
    # Get the registers.
    sr, dr = get_regs_bb(self._relocated[addr + 1])
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 registers.
      attrs = self._new_attr_opcode(addr, 2, 'XFRB')
      self._attr_regs(sr, dr, "[Transfer {0} to {1}]", attrs)
    # Execute.
    vm = self._vm
    sv = vm.get_reg_b(sr)
    vm.set_reg_b(dr, sv)
    vm.update_m_b(sv)
    vm.update_v(sv)
    vm.incr_pc(2)

  # Opcode 46 (Bignum instructions)
  def _op46(self, addr: int) -> None:
    # Get the lengths. They are specified as one less than desired, or in the
    # case of a base, 2 less. Add one now.
    maddr = addr + 1
    lls = self._relocated[maddr]
    ll = [ (lls >> 4) + 1, (lls & 0xF) + 1 ]
    maddr += 1
    # Get the selector and extended addressing modes.
    smm = self._relocated[maddr]
    selector = smm >> 4
    mm = [ (smm >> 2) & 0x3, smm & 0x3 ]
    maddr += 1
    # Handle each selector.
    desc = ''
    opcode = ''
    argtypes = [ 'N', 'N' ]
    if selector == 0:
      # A.
      opcode = 'A'
      desc = 'Add bignums'
    elif selector == 1:
      # S.
      opcode = 'S'
      desc = 'Subtract bignums'
    elif selector == 2:
      # C.
      opcode = 'C'
      desc = 'Compare bignums'
    elif selector == 3:
      # ZAD.
      opcode = 'ZAD'
      desc = 'Zero-add bignum'
    elif selector == 4:
      # ZSU.
      opcode = 'ZSU'
      desc = 'Zero-subtract bignum'
    elif selector == 5:
      # M.
      opcode = 'M'
      desc = 'Multiply bignums'
    elif selector == 6:
      # D.
      opcode = 'D'
      desc = 'Divide bignums'
    elif selector == 7:
      # DRM.
      opcode = 'DRM'
      desc = 'Divide bignums with remainder'
    elif selector == 8:
      # CTB. The first length is actually the base-2 so add one more now.
      opcode = 'CTB'
      desc = 'Convert to bignum'
      ll[0] = ll[0] + 1
      argtypes[0] = 'S'
    elif selector == 9:
      # CFB. The first length is actually the base-2 so add one more now.
      opcode = 'CFB'
      desc = 'Convert from bignum'
      ll[0] = ll[0] + 1
      argtypes[0] = 'S'
    else:
      raise ValueError("Unknown selector.")
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(1)
    else:
      # Start with the 1 opcode byte.
      attrs = self._new_attr_opcode(addr, 1, opcode)
    # Create the arguments and comments.
    mstr = ''
    regs = [ ]
    for i in range(2):
      m = mm[i]
      if m == 0:
        # Direct.
        attrs.args += '/'
        self._attr_word_arg(maddr, argtypes[i], attrs)
        attrs.args += "({0})".format(ll[i])
        mstr += ', direct'
        maddr += 2
      elif m == 1:
        # Indexed with displacement. Get the registers.
        r1i, r2i = get_regs(self._relocated[maddr])
        r1, r2 = get_regs_ww(self._relocated[maddr])
        maddr += 1
        # If the first is even, it's a signed byte displacement; if odd it's a
        # word displacement.
        if (r1i & 1) == 0:
          disp = self._relocated[maddr]
          maddr += 1
          if is_neg_b(disp):
            disp = neg_b(disp)
        else:
          disp = int.from_bytes(self._relocated[maddr:maddr+2], 'big')
          maddr += 2
        # If the second is 0 it's single-register; if not it's a second register
        # to add to the displacement.
        if r2i == 0:
          attrs.args += "-{0},{1}({2})".format(r1, disp, ll[i])
          mstr += ', displaced indexed'
        else:
          attrs.args += "-{0}*{1},{2}({3})".format(r1, r2, disp, ll[i])
          mstr += ", displaced double-indexed"
      elif m == 2:
        # Indexed.
        if len(regs) == 0:
          regs = get_regs(self._relocated[maddr])
          maddr += 1
        attrs.args += "-{0}".format(regaddress_word[regs[i]])
        mstr += ', indexed'
        attrs.args += "({0})".format(ll[i])
      else:
        # Literal.
        lit = int.from_bytes(self._relocated[maddr:maddr+ll[i]], 'big')
        if is_neg_v(lit, ll[i]):
          attrs.args += "={0}".format(neg_v(lit, ll[i]))
        else:
          attrs.args += "={0}".format(lit)
        fmt = ", literal=0x{{0:0{0}x}}".format(ll[i] * 2)
        mstr += fmt.format(lit)
        maddr += ll[i]
      # Separate arguments.
      if i == 0:
        attrs.args += ','
        if attrs.comment != '':
          attrs.comment += ','
    if attrs.comment != '':
      attrs.comment += ' '
    attrs.comment += "[{0}{1}]".format(desc, mstr)
    attrs.num_bytes = maddr - addr
    # Execute. Bignum are unlikely to affect disassembly, so just clear all the
    # flags and advance the PC.
    vm = self._vm
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.reset_v()
    vm.incr_pc(attrs.num_bytes)

  # Opcode 47 (Memory block instructions with length/terminator as argument)
  def _op47(self, addr: int) -> None:
    # Get the selector and extended addressing modes.
    maddr = addr + 1
    smm = self._relocated[maddr]
    selector = smm >> 4
    mm = [ (smm >> 2) & 0x3, smm & 0x3 ]
    maddr += 1
    # Handle each selector.
    lenterm = None
    desc = ''
    opcode = ''
    if selector == 0:
      # CVX. Literals are not allowed.
      opcode = 'CVX'
      desc = 'Convert executable'
    elif selector == 1:
      # CPV. The terminator is the next argument. The assembler allows literal
      # first argument but it aborts.
      opcode = 'CPV'
      desc = 'Compare variable-length'
      lenterm = self._relocated[maddr]
      maddr += 1
    elif selector == 2:
      # MVV. The length-1 is the next argument and the terminator is the one
      # after that. The assembler allows literal first argument but it aborts.
      opcode = 'MVV'
      desc = 'Move variable-length'
      lenterm = [ self._relocated[maddr] + 1, self._relocated[maddr + 1] ]
      maddr += 2
    elif selector == 3:
      # SCN. The length-1 is the next argument. The assembler allows literal
      # first argument but it aborts.
      opcode = 'SCN'
      desc = 'Scan string for match'
      lenterm = self._relocated[maddr]
      maddr += 1
    elif selector == 4:
      # MVF. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be the length specified.
      opcode = 'MVF'
      desc = 'Move fixed-length'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = lenterm
    elif selector == 5:
      # ANC. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be the length specified.
      opcode = 'ANC'
      desc = 'AND bytes'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = lenterm
    elif selector == 6:
      # ORC. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be the length specified.
      opcode = 'ORC'
      desc = 'OR bytes'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = lenterm
    elif selector == 7:
      # XRC. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be the length specified.
      opcode = 'XRC'
      desc = 'XOR bytes'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = lenterm
    elif selector == 8:
      # CPF. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be the length specified.
      opcode = 'CPF'
      desc = 'Compare fixed-length'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = lenterm
    elif selector == 9:
      # FIL. The length-1 is the next argument. Only the first argument can be
      # a literal and it must be a single byte.
      opcode = 'FIL'
      desc = 'Fill with byte'
      lenterm = self._relocated[maddr] + 1
      maddr += 1
      litlen = 1
    else:
      raise ValueError("Unknown selector.")
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(1)
    else:
      # Start with the 1 opcode byte.
      attrs = self._new_attr_opcode(addr, 1, opcode)
    # Prepend the lengths/terminator if set.
    if isinstance(lenterm, int):
      attrs.args = "({0})".format(lenterm)
    elif lenterm is not None:
      attrs.args = "({0},{1})".format(lenterm[0], lenterm[1])
    # Create the arguments and comments.
    mstr = ''
    regs = [ ]
    ascfunc = all_ascii if self._printaddr else all_ascii_nolower
    for i in range(2):
      m = mm[i]
      if m == 0:
        # Direct.
        attrs.args += '/'
        self._attr_word_arg(maddr, 'W', attrs)
        mstr += ', direct'
        maddr += 2
      elif m == 1:
        # Indexed with displacement. Get the registers.
        r1i, r2i = get_regs(self._relocated[maddr])
        r1, r2 = get_regs_ww(self._relocated[maddr])
        maddr += 1
        # If the first is even, it's a signed byte displacement; if odd it's a
        # word displacement.
        if (r1i & 1) == 0:
          disp = self._relocated[maddr]
          maddr += 1
          if is_neg_b(disp):
            disp = neg_b(disp)
        else:
          disp = int.from_bytes(self._relocated[maddr:maddr+2], 'big')
          maddr += 2
        # If the second is 0 it's single-register; if not it's a second register
        # to add to the displacement.
        if r2i == 0:
          attrs.args += "-{0},{1}".format(r1, disp)
          mstr += ', displaced indexed'
        else:
          attrs.args += "-{0}*{1},{2}".format(r1, r2, disp)
          mstr += ", displaced double-indexed"
      elif m == 2:
        # Indexed.
        if len(regs) == 0:
          regs = get_regs(self._relocated[maddr])
          maddr += 1
        attrs.args += "-{0}".format(regaddress_word[regs[i]])
        mstr += ', indexed'
      else:
        # Literal.
        litbytes = self._relocated[maddr:maddr+litlen]
        lit = int.from_bytes(litbytes, 'big')
        if ascfunc(litbytes):
          attrs.args += "='{0}'".format(printable(litbytes))
          fmt = ", literal=0x{{0:0{0}x}}({{0}},{{1}})".format(litlen * 2)
          mstr += fmt.format(lit, neg_b(lit))
        else:
          fmt = "=X'{{0:0{0}X}}'".format(litlen * 2)
          attrs.args += fmt.format(lit)
          if is_neg_v(lit, litlen):
            mstr += ", literal={0}({1})".format(lit, neg_v(lit, litlen))
          else:
            mstr += ", literal={0}".format(lit)
        maddr += litlen
      # Separate arguments.
      if i == 0:
        attrs.args += ','
        if attrs.comment != '':
          attrs.comment += ','
    if attrs.comment != '':
      attrs.comment += ' '
    attrs.comment += "[{0}{1}]".format(desc, mstr)
    attrs.num_bytes = maddr - addr
    # Execute. Memblock are unlikely to affect disassembly, so just clear all
    # the flags and advance the PC.
    vm = self._vm
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.reset_v()
    vm.incr_pc(attrs.num_bytes)

  # Opcode 48 (AABB)
  def _op48(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'AABB')
      attrs.comment = '[AL + BL -> BL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    bl = vm.get_reg_b('BL')
    new = al + bl
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b('BL', newmod)
    vm.update_f_b(bl, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 49 (SABB)
  def _op49(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SABB')
      attrs.comment = '[AL - BL -> BL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    bl = vm.get_reg_b('BL')
    new = al - bl
    newmod = new & 0xFF
    newlink = new & 0x1FF
    vm.set_reg_b('BL', newmod)
    vm.update_f_b(bl, newmod)
    vm.update_l_b(newlink)
    vm.update_m_b(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 4A (NABB)
  def _op4A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'NABB')
      attrs.comment = '[AL & BL -> BL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    bl = vm.get_reg_b('BL')
    new = al & bl
    vm.set_reg_b('BL', new)
    vm.update_m_b(new)
    vm.update_v(new)
    vm.incr_pc()

  # Opcode 4B (XAXB)
  def _op4B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAXB')
      attrs.comment = '[Transfer AL to XL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    vm.set_reg_b('XL', al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode 4C (XAYB)
  def _op4C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAYB')
      attrs.comment = '[Transfer AL to YL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    vm.set_reg_b('YL', al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode 4D (XABB)
  def _op4D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XABB')
      attrs.comment = '[Transfer AL to BL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    vm.set_reg_b('BL', al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode 4E (XAZB)
  def _op4E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAZB')
      attrs.comment = '[Transfer AL to ZL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    vm.set_reg_b('ZL', al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode 4F (XASB)
  def _op4F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XASB')
      attrs.comment = '[Transfer AL to SL]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    vm.set_reg_b('SL', al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode 50 (ADD)
  def _op50(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register ADD.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'ADD')
        self._attr_regs(sr, dr, "[{0} + {1} -> {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      new = sv + dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(dv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register ADD.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'ADD=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [{0} + {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      new = iv + sv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(sv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register ADD.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'ADD/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [*Direct + {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      new = sv + dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(sv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register ADD.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'ADD-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[*({0}{1:+d}) + {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      new = sv + dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(dv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)

  # Opcode 51 (SUB)
  def _op51(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register SUB.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'SUB')
        self._attr_regs(sr, dr, "[{0} - {1} -> {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      new = sv - dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(dv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register SUB.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'SUB=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [{0} - {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      new = iv - sv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(sv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register SUB.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'SUB/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [*Direct - {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      new = sv - dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(sv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register SUB.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'SUB-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[*({0}{1:+d}) - {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      new = sv - dv
      newmod = new & 0xFFFF
      newlink = new & 0x1FFFF
      vm.set_reg_w(dr, newmod)
      vm.update_f_w(dv, newmod)
      vm.update_l_w(newlink)
      vm.update_m_w(newmod)
      vm.update_v(newmod)
      vm.incr_pc(4)

  # Opcode 52 (AND)
  def _op52(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register AND.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'AND')
        self._attr_regs(sr, dr, "[{0} & {1} -> {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      new = sv & dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register AND.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'AND=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [{0} & {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      new = sv & iv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register AND.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'AND/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [*Direct & {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      new = sv & dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register AND.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'AND-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[*({0}{1:+d}) & {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      new = sv & dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)

  # Opcode 53 (ORI)
  def _op53(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register ORI.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'ORI')
        self._attr_regs(sr, dr, "[{0} | {1} -> {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      new = sv | dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register ORI.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'ORI=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [{0} | {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      new = iv | sv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register ORI.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'ORI/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [*Direct | {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      new = sv | dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register ORI.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'ORI-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[*({0}{1:+d}) | {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      new = sv | dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)

  # Opcode 54 (ORE)
  def _op54(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register ORE.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'ORE')
        self._attr_regs(sr, dr, "[{0} ^ {1} -> {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      new = sv ^ dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register ORE.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'ORE=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [{0} ^ {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      new = sv ^ iv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register ORE.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'ORE/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        attrs.comment += " [*Direct ^ {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      new = sv ^ dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register ORE.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'ORE-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[*({0}{1:+d}) ^ {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      new = sv ^ dv
      vm.set_reg_w(dr, new)
      vm.update_m_w(new)
      vm.update_v(new)
      vm.incr_pc(4)

  # Opcode 55 (XFR)
  def _op55(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register XFR.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'XFR')
        self._attr_regs(sr, dr, "[Transfer {0} to {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(si)
      vm.set_reg_w(di, sv)
      vm.update_m_w(sv)
      vm.update_v(sv)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register XFR.
      _, dr = get_regs_bw(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'XFR=')
        self._attr_word_arg(addr + 2, 'W', attrs)
        attrs.args += ",{0}".format(dr)
        attrs.comment += " [Transfer immediate to {0}]".format(dr)
      # Execute.
      iv = vm.get_mem_w(vm.get_pc() + 2)
      vm.set_reg_w(dr, iv)
      vm.update_m_w(iv)
      vm.update_v(iv)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register XFR.
      _, dr = get_regs_bw(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'XFR/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        attrs.args += ",{0}".format(dr)
        attrs.comment += " [Transfer direct to {0}]".format(dr)
      # Execute.
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      vm.set_reg_w(dr, dv)
      vm.update_m_w(dv)
      vm.update_v(dv)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register XFR.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'XFR-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        attrs.comment += "[Transfer indexed-displaced to {0}]".format(dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      vm.set_reg_w(dr, dv)
      vm.update_m_w(dv)
      vm.update_v(dv)
      vm.incr_pc(4)

  # Opcode 56 (EAO)
  def _op56(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'EAO')
      attrs.comment = '[Enable abort on overflow]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 57 (DAO)
  def _op57(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DAO')
      attrs.comment = '[Disable abort on overflow]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 58 (AAB)
  def _op58(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'AAB')
      attrs.comment = '[A + B -> B]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    new = a + b
    newmod = new & 0xFFFF
    newlink = new & 0x1FFFF
    vm.set_reg_w('B', newmod)
    vm.update_f_w(b, newmod)
    vm.update_l_w(newlink)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 59 (SAB)
  def _op59(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SAB')
      attrs.comment = '[A - B -> B]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    new = a - b
    newmod = new & 0xFFFF
    newlink = new & 0x1FFFF
    vm.set_reg_w('B', newmod)
    vm.update_f_w(b, newmod)
    vm.update_l_w(newlink)
    vm.update_m_w(newmod)
    vm.update_v(newmod)
    vm.incr_pc()

  # Opcode 5A (NAB)
  def _op5A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'NAB')
      attrs.comment = '[A & B -> B]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    new = a & b
    vm.set_reg_w('B', new)
    vm.update_m_w(new)
    vm.update_v(new)
    vm.incr_pc()

  # Opcode 5B (XAX)
  def _op5B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAX')
      attrs.comment = '[Transfer A to X]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    vm.set_reg_w('X', a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode 5C (XAY)
  def _op5C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAY')
      attrs.comment = '[Transfer A to Y]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    vm.set_reg_w('Y', a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode 5D (XAB)
  def _op5D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAB')
      attrs.comment = '[Transfer A to B]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    vm.set_reg_w('B', a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode 5E (XAZ)
  def _op5E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAZ')
      attrs.comment = '[Transfer A to Z]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    vm.set_reg_w('Z', a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode 5F (XAS)
  def _op5F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'XAS')
      attrs.comment = '[Transfer A to S]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    vm.set_reg_w('S', a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode 60 (LDX immediate)
  def _op60(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'LDX=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load X with immediate]'
    # Execute.
    vm = self._vm
    iv = vm.get_mem_w(vm.get_pc() + 1)
    vm.set_reg_w('X', iv)
    vm.update_m_w(iv)
    vm.update_v(iv)
    vm.incr_pc(3)

  # Opcode 61 (LDX direct)
  def _op61(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'LDX/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load X direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    dv = vm.get_mem_w(ea)
    vm.set_reg_w('X', dv)
    vm.update_m_w(dv)
    vm.update_v(dv)
    vm.incr_pc(3)

  # Opcode 62 (LDX indirect)
  def _op62(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'LDX$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Load X indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('X', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(3)

  # Opcode 63 (LDX relative)
  def _op63(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDX')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load X relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('X', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 64 (LDX relative indirect)
  def _op64(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDX*')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load X relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('X', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 65 (LDX indexed)
  def _op65(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'LDX')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Load X', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('X', val)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(attrs.num_bytes)

  # Opcode 66 (SVC)
  def _op66(self, addr: int) -> None:
    # Get the service call number.
    unseen = addr not in self._attrs
    svc = self._relocated[addr + 1]
    if unseen:
      # 2 bytes: 1 opcode, 1 SVC call number.
      attrs = self._new_attr_opcode(addr, 2, 'SVC')
      attrs.args = "X'{0:02X}'".format(svc)
      if svc == 0xff or svc == 0xfe:
        name = ''
      else:
        name = self._svcnames[svc]
      attrs.comment = "={0} [Service call {1}]".format(svc, name)
    # Handle the arguments which appear after the call. The service handler will
    # return negative size if it would cause execution to halt (e.g., EXIT).
    vm = self._vm
    vm.incr_pc(2)
    if svc == 0xff:
      # Optest fake svc call with word argument.
      argslen = 2
    elif svc == 0xfe:
      # Optest fake svc call with no argument.
      argslen = 0
    else:
      handler = self._svchandlers[svc]
      argslen = handler(self, addr + 2, unseen)
    # Execute.
    if argslen < 0:
      vm.set_pc(0xFFFF)
    else:
      vm.incr_pc(argslen)

  # Opcode 67 (Memory block instructions with length/terminator in AL/AU)
  def _op67(self, addr: int) -> None:
    vm = self._vm
    # Get the selector and extended addressing modes.
    maddr = addr + 1
    smm = self._relocated[maddr]
    selector = smm >> 4
    mm = [ (smm >> 2) & 0x3, smm & 0x3 ]
    maddr += 1
    # Handle each selector.
    desc = ''
    opcode = ''
    if selector == 0:
      # CVXR.
      opcode = 'CVXR'
      desc = 'Convert executable'
    elif selector == 1:
      # CPVR.
      opcode = 'CPVR'
      desc = 'Compare variable-length (terminator in AU)'
    elif selector == 2:
      # MVVR.
      opcode = 'MVVR'
      desc = 'Move variable-length (terminator in AU, len-1 in AL)'
    elif selector == 3:
      # SCNR.
      opcode = 'SCNR'
      desc = 'Scan string for match (len-1 in AL)'
    elif selector == 4:
      # MVFR. Only the first argument can be a literal and it must be the value
      # in AL plus one.
      opcode = 'MVFR'
      desc = 'Move fixed-length (len-1 in AL)'
      litlen = vm.get_reg_b('AL') + 1
    elif selector == 5:
      # ANCR. Only the first argument can be a literal and it must be the value
      # in AL plus one.
      opcode = 'ANC'
      desc = 'AND bytes'
      litlen = vm.get_reg_b('AL') + 1
    elif selector == 6:
      # ORCR. Only the first argument can be a literal and it must be the value
      # in AL plus one.
      opcode = 'ORC'
      desc = 'OR bytes'
      litlen = vm.get_reg_b('AL') + 1
    elif selector == 7:
      # XRCR. Only the first argument can be a literal and it must be the value
      # in AL plus one.
      opcode = 'XRC'
      desc = 'XOR bytes'
      litlen = vm.get_reg_b('AL') + 1
    elif selector == 8:
      # CPFR. Only the first argument can be a literal and it must be the value
      # in AL plus one.
      opcode = 'CPFR'
      desc = 'Compare fixed-length (len-1 in AL)'
      litlen = vm.get_reg_b('AL') + 1
    elif selector == 9:
      # FILR. Only the first argument can be a literal and it must be a single
      # byte.
      opcode = 'FILR'
      desc = 'Fill with byte (len-1 in AL)'
      litlen = 1
    else:
      raise ValueError("Unknown selector.")
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(1)
    else:
      # Start with the 1 opcode byte.
      attrs = self._new_attr_opcode(addr, 1, opcode)
    # Create the arguments and comments.
    mstr = ''
    regs = [ ]
    ascfunc = all_ascii if self._printaddr else all_ascii_nolower
    for i in range(2):
      m = mm[i]
      if m == 0:
        # Direct.
        attrs.args += '/'
        self._attr_word_arg(maddr, 'W', attrs)
        mstr += ', direct'
        maddr += 2
      elif m == 1:
        # Indexed with displacement. Get the registers.
        r1i, r2i = get_regs(self._relocated[maddr])
        r1, r2 = get_regs_ww(self._relocated[maddr])
        maddr += 1
        # If the first is even, it's a signed byte displacement; if odd it's a
        # word displacement.
        if (r1i & 1) == 0:
          disp = self._relocated[maddr]
          maddr += 1
          if is_neg_b(disp):
            disp = neg_b(disp)
        else:
          disp = int.from_bytes(self._relocated[maddr:maddr+2], 'big')
          maddr += 2
        # If the second is 0 it's single-register; if not it's a second register
        # to add to the displacement.
        if r2i == 0:
          attrs.args += "-{0},{1}".format(r1, disp)
          mstr += ', displaced indexed'
        else:
          attrs.args += "-{0}*{1},{2}".format(r1, r2, disp)
          mstr += ", displaced double-indexed"
      elif m == 2:
        # Indexed.
        if len(regs) == 0:
          regs = get_regs(self._relocated[maddr])
          maddr += 1
        attrs.args += "-{0}".format(regaddress_word[regs[i]])
        mstr += ', indexed'
      else:
        # Literal.
        litbytes = self._relocated[maddr:maddr+litlen]
        lit = int.from_bytes(litbytes, 'big')
        if ascfunc(litbytes):
          attrs.args += "='{0}'".format(printable(litbytes))
          fmt = ", literal=0x{{0:0{0}x}}({{0}},{{1}})".format(litlen * 2)
          mstr += fmt.format(lit, neg_b(lit))
        else:
          fmt = "=X'{{0:0{0}X}}'".format(litlen * 2)
          attrs.args += fmt.format(lit)
          if is_neg_v(lit, litlen):
            mstr += ", literal={0}({1})".format(lit, neg_v(lit, litlen))
          else:
            mstr += ", literal={0}".format(lit)
        maddr += litlen
      # Separate arguments.
      if i == 0:
        attrs.args += ','
        if attrs.comment != '':
          attrs.comment += ','
    if attrs.comment != '':
      attrs.comment += ' '
    attrs.comment += "[{0}{1}]".format(desc, mstr)
    attrs.num_bytes = maddr - addr
    # Execute. Memblock are unlikely to affect disassembly, so just clear all
    # the flags and advance the PC.
    vm.reset_f()
    vm.reset_l()
    vm.reset_m()
    vm.reset_v()
    vm.incr_pc(attrs.num_bytes)

  # Opcode 68 (STX immediate)
  def _op68(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'STX=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store X immediate]'
    # Execute.
    vm = self._vm
    x = vm.get_reg_w('X')
    ea = vm.get_pc() + 1
    vm.set_mem_w(ea, x)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(3)

  # Opcode 69 (STX direct)
  def _op69(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STX/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store X direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    x = vm.get_reg_w('X')
    vm.set_mem_w(ea, x)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(3)

  # Opcode 6A (STX indirect)
  def _op6A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STX$')
      self._attr_word_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store X indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    x = vm.get_reg_w('X')
    vm.set_mem_w(ea, x)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(3)

  # Opcode 6B (STX relative)
  def _op6B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STX')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store X relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    x = vm.get_reg_w('X')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    vm.set_mem_w(ea, x)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(2)

  # Opcode 6C (STX relative indirect)
  def _op6C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STX*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store X relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    x = vm.get_reg_w('X')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, x)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(2)

  # Opcode 6D (STX indexed)
  def _op6D(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'STX')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Store X', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    x = vm.get_reg_w('X')
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, x)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(x)
    vm.update_v(x)
    vm.incr_pc(attrs.num_bytes)

  # Opcode 6E (LST)
  def _op6E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 address.
      attrs = self._new_attr_opcode(addr, 3, 'LST')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load status direct]'
    # Execute. FLMV go in the high nibble, sense switches in the low.
    vm = self._vm
    status = (vm.get_f() << 7) | \
             (vm.get_l() << 6) | \
             (vm.get_m() << 5) | \
             (vm.get_v() << 4)
    ea = vm.get_mem_w(vm.get_pc() + 1)
    vm.set_mem_b(ea, status)
    vm.incr_pc(3)

  # Opcode 6F (SST)
  def _op6F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 address.
      attrs = self._new_attr_opcode(addr, 3, 'SST')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store status direct]'
    # Execute. FLMV go in the high nibble, sense switches in the low.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    status = vm.get_mem_b(ea)
    if (status & 0x80) != 0:
      vm.set_f()
    else:
      vm.reset_f()
    if (status & 0x40) != 0:
      vm.set_l()
    else:
      vm.reset_l()
    if (status & 0x20) != 0:
      vm.set_m()
    else:
      vm.reset_m()
    if (status & 0x10) != 0:
      vm.set_v()
    else:
      vm.reset_v()
    vm.incr_pc(3)

  # Opcode 70 (Illegal opcode)
  def _op70(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode 70]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 71 (JMP direct)
  def _op71(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'JMP/')
      self._attr_word_arg(addr + 1, 'J', attrs) - self._baseaddr
      attrs.comment += ' [Jump direct]'
    # Execute.
    vm = self._vm
    if self._bh.hit(addr, True):
      ea = vm.get_mem_w(vm.get_pc() + 1)
      aaddr = ea - self._baseaddr
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.set_pc(ea)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 72 (JMP indirect)
  def _op72(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'JMP$')
      self._attr_word_arg(addr + 1, 'J', attrs) - self._baseaddr
      attrs.comment += ' [Jump indirect]'
    # Execute.
    vm = self._vm
    if self._bh.hit(addr, True):
      ea = vm.get_mem_w(vm.get_pc() + 1)
      ea = vm.get_mem_w(ea)
      aaddr = ea - self._baseaddr
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.set_pc(ea)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 73 (JMP relative)
  def _op73(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'JMP')
      disp = self._attr_displace_arg(addr + 1, 'D', attrs)
      attrs.comment += ' [Jump relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    if self._bh.hit(addr, True):
      ea = (vm.get_pc() + 2 + disp) & 0xFFFF
      aaddr = ea - self._baseaddr
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.set_pc(ea)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 74 (JMP relative indirect)
  def _op74(self, addr: int) -> None:
    unseen = addr not in self._attrs
    if unseen:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'JMP*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Jump relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    if self._bh.hit(addr, True):
      ea = (vm.get_pc() + 2 + disp) & 0xFFFF
      ea = vm.get_mem_w(ea)
      aaddr = ea - self._baseaddr
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.set_pc(ea)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 75 (JMP indexed)
  def _op75(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'JMP')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Jump', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    if self._bh.hit(addr, True):
      aaddr = ea - self._baseaddr
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.set_pc(ea)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 76 (EPE)
  def _op76(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'EPE')
      attrs.comment = '[Enable parity error]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 77 (MUL)
  def _op77(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register MUL.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'MUL')
        self._attr_regs(sr, dr, "[{0} * {1} -> {1}", attrs)
        if (di & 0x3) == 0:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += ",{0}".format(d2)
        attrs.comment += ']'
      # Execute.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      product = sv * dv
      prodhi = product >> 16
      prodlo = product & 0xFFFF
      vm.set_reg_w(di, prodhi)
      vm.set_reg_w(di | 2, prodlo)
      vm.update_f_w(dv, prodhi)
      vm.reset_l()
      vm.update_m_w(prodhi)
      vm.update_v(prodhi | prodlo)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register MUL.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'MUL=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        if (di & 0x3) == 0:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += " [{0} * {1} -> {2},{3}]".format(iv, sr, dr, d2)
        else:
          attrs.comment += " [{0} * {1} -> {2}]".format(iv, sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      product = sv * iv
      prodhi = product >> 16
      prodlo = product & 0xFFFF
      vm.set_reg_w(di, prodhi)
      vm.set_reg_w(di | 2, prodlo)
      vm.update_f_w(sv, prodhi)
      vm.reset_l()
      vm.update_m_w(prodhi)
      vm.update_v(prodhi | prodlo)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register MUL.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'MUL/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        if (di & 0x3) == 1:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += " [*Direct * {0} -> {1},{2}]".format(sr, dr, d2)
        else:
          attrs.comment += " [*Direct * {0} -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      product = sv * dv
      prodhi = product >> 16
      prodlo = product & 0xFFFF
      vm.set_reg_w(di, prodhi)
      vm.set_reg_w(di | 2, prodlo)
      vm.update_f_w(sv, prodhi)
      vm.reset_l()
      vm.update_m_w(prodhi)
      vm.update_v(prodhi | prodlo)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register MUL.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'MUL-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        if (di & 0x3) == 1:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += \
            "[*({0}{1:+d}) * {2} -> {2},{3}]".format(sr, disp, dr, d2)
        else:
          attrs.comment += "[*({0}{1:+d}) * {2} -> {2}]".format(sr, disp, dr)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      product = sv * dv
      prodhi = product >> 16
      prodlo = product & 0xFFFF
      vm.set_reg_w(di, prodhi)
      vm.set_reg_w(di | 2, prodlo)
      vm.update_f_w(sv, prodhi)
      vm.reset_l()
      vm.update_m_w(prodhi)
      vm.update_v(prodhi | prodlo)
      vm.incr_pc(4)

  # Opcode 78 (DIV)
  def _op78(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register DIV.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'DIV')
        if (di & 0x3) == 0:
          self._attr_regs(sr, dr, "[{1} / {0} -> {0}", attrs)
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += ", {1} % {0} -> {1}".format(d2, dr)
        else:
          self._attr_regs(sr, dr, "[{1} / {0} -> {1}", attrs)
        attrs.comment += ']'
      # Execute. Not sure if flags are correct.
      sv = vm.get_reg_w(sr)
      dv = vm.get_reg_w(dr)
      if dv == 0:
        vm.set_f()
      else:
        quotient = sv // dv
        remainder = sv % dv
        vm.set_reg_w(di, remainder)
        vm.set_reg_w(di | 2, quotient)
        vm.update_f_w(sv, quotient)
        vm.reset_l()
        vm.update_m_w(quotient)
        vm.update_v(quotient)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's an immediate-
      # to-register DIV.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'DIV=')
        iv = self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        if (di & 0x3) == 0:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += " [{0} / {1} -> {3}, {0} % {1} -> {2}]".format(
            sr, iv, dr, d2)
        else:
          attrs.comment += " [{0} / {1} -> {2}]".format(sr, iv, dr)
      # Execute. Not sure if flags are correct.
      sv = vm.get_reg_w(sr)
      iv = vm.get_mem_w(vm.get_pc() + 2)
      if iv == 0:
        vm.set_f()
      else:
        quotient = sv // iv
        remainder = sv % iv
        vm.set_reg_w(di, remainder)
        vm.set_reg_w(di | 2, quotient)
        vm.update_f_w(sv, quotient)
        vm.reset_l()
        vm.update_m_w(quotient)
        vm.update_v(quotient)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's direct-
      # addressing-to-register DIV.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'DIV/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        if sr == dr:
          attrs.args += ",{0}".format(sr)
        else:
          attrs.args += ",{0},{1}".format(sr, dr)
        if (di & 0x3) == 1:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += \
            " [{0} / *direct -> {2}, {0} % *direct -> {1}]".format(sr, dr, d2)
        else:
          attrs.comment += " [{0} / *direct -> {1}]".format(sr, dr)
      # Execute.
      sv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(vm.get_pc() + 2)
      dv = vm.get_mem_w(ea)
      quotient = sv // dv
      remainder = sv % dv
      vm.set_reg_w(di, remainder)
      vm.set_reg_w(di | 2, quotient)
      vm.update_f_w(sv, quotient)
      vm.reset_l()
      vm.update_m_w(quotient)
      vm.update_v(quotient)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's indexed-displaced-to-
      # register DIV.
      sr, dr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'DIV-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(sr, disp, dr)
        if (di & 0x3) == 1:
          d2 = regaddress_word[(di + 2) & 0x0F]
          attrs.comment += \
            "[{0} / *({1}{2:+d}) -> {4}, {0} % *({1}{2:+d}) -> {3}]".format(
              dr, sr, disp, dr, d2)
        else:
          attrs.comment += "[{0} / *({1}{2:+d}) -> {0}]".format(dr, sr, disp)
      # Execute.
      ea = vm.get_reg_w(sr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      sv = vm.get_mem_w(ea)
      dv = vm.get_reg_w(dr)
      quotient = sv // dv
      remainder = sv % dv
      vm.set_reg_w(di, remainder)
      vm.set_reg_w(di | 2, quotient)
      vm.update_f_w(sv, quotient)
      vm.reset_l()
      vm.update_m_w(quotient)
      vm.update_v(quotient)
      vm.incr_pc(4)

  # Opcode 79 (JSR direct)
  def _op79(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'JSR/')
      self._attr_word_arg(addr + 1, 'F', attrs) - self._baseaddr
      attrs.comment += ' [Jump to subroutine direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    aaddr = ea - self._baseaddr
    argbytes = self._sub_args(addr, 3, aaddr)
    if argbytes >= 0:
      vm.incr_pc(3 + argbytes)
    elif self._check_recursion():
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.push_w(vm.get_reg_w('X'))
      rsr = vm.get_pc() + 3
      vm.set_reg_w('X', rsr)
      vm.set_pc(ea)
      vm.set_reg_w('P', ea)
      # Push the context.
      self._branches.append(self._bh)
      self._bh = Branches(addr, ea - self._baseaddr, rsr)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 7A (JSR indirect)
  def _op7A(self, addr: int) -> None:
    # In CPU5 mode, check if this is actually a SVC call.
    vm = self._vm
    if self._iscpu5 and vm.get_mem_w(vm.get_pc() + 1) == 0x005A:
      # 4 bytes: 1 opcode, 2 indirect address, 1 service call number.
      # Get the service call number.
      unseen = addr not in self._attrs
      svc = vm.get_mem_b(vm.get_pc() + 3)
      if unseen:
        attrs = self._new_attr_opcode(addr, 3, 'JSR$')
        self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
        attrs.comment += ' [Jump to OPSYS (SVC)]'
        attrs = self._new_attr_byte(addr + 3)
        attrs.comment += ' [Service call {0}]'.format(self._svcnames5[svc])
      # Handle the arguments which appear after the call. The service handler
      # will return negative size if it would cause execution to halt (e.g.,
      # EXIT).
      vm = self._vm
      vm.incr_pc(4)
      argslen = self._svchandlers[svc](self, addr + 4, unseen)
      # Execute.
      if argslen < 0:
        vm.set_pc(0xFFFF)
      else:
        vm.incr_pc(argslen)
      return
    # Handle normal JSR indirect.
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'JSR$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Jump to subroutine indirect]'
    # Execute.
    ia = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ia)
    aaddr = ea - self._baseaddr
    argbytes = self._isub_args(addr, 3, ia)
    if argbytes >= 0:
      vm.incr_pc(3 + argbytes)
    elif self._check_recursion():
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.push_w(vm.get_reg_w('X'))
      rsr = vm.get_pc() + 3
      vm.set_reg_w('X', rsr)
      vm.set_pc(ea)
      vm.set_reg_w('P', ea)
      # Push the context.
      self._branches.append(self._bh)
      self._bh = Branches(addr, ea - self._baseaddr, rsr)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 7B (JSR relative)
  def _op7B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'JSR')
      disp = self._attr_displace_arg(addr + 1, 'F', attrs)
      attrs.comment += ' [Jump to subroutine relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    aaddr = ea - self._baseaddr
    argbytes = self._sub_args(addr, 2, aaddr)
    if argbytes >= 0:
      vm.incr_pc(2 + argbytes)
    elif self._check_recursion():
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.push_w(vm.get_reg_w('X'))
      rsr = vm.get_pc() + 2
      vm.set_reg_w('X', rsr)
      vm.set_pc(ea)
      vm.set_reg_w('P', ea)
      # Push the context.
      self._branches.append(self._bh)
      self._bh = Branches(addr, ea - self._baseaddr, rsr)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 7C (JSR relative indirect)
  def _op7C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'JSR*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Jump to subroutine relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ia = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ia)
    aaddr = ea - self._baseaddr
    argbytes = self._isub_args(addr, 2, ia)
    if argbytes >= 0:
      vm.incr_pc(2 + argbytes)
    elif self._check_recursion():
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.push_w(vm.get_reg_w('X'))
      rsr = vm.get_pc() + 2
      vm.set_reg_w('X', rsr)
      vm.set_pc(ea)
      vm.set_reg_w('P', ea)
      # Push the context.
      self._branches.append(self._bh)
      self._bh = Branches(addr, ea - self._baseaddr, rsr)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 7D (JSR indexed)
  def _op7D(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'JSR')
    r, pre, post, indir, disp = \
      self._attr_indexed(addr + 1, 'Jump to subroutine', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    aaddr = ea - self._baseaddr
    argbytes = self._sub_args(addr, attrs.num_bytes, aaddr)
    if argbytes >= 0:
      vm.incr_pc(attrs.num_bytes + argbytes)
    elif self._check_recursion():
      if aaddr not in self._attrs:
        parent, paddr = self._get_parent(aaddr)
        if parent is not None and paddr != aaddr:
          # If the address is in the middle of something already known, we
          # probably didn't accurately self-modify, so just end disassembly.
          vm.set_pc(0xFFFF)
          return
      vm.push_w(vm.get_reg_w('X'))
      rsr = vm.get_pc() + 2
      vm.set_reg_w('X', rsr)
      vm.set_pc(ea)
      vm.set_reg_w('P', ea)
      # Push the context.
      self._branches.append(self._bh)
      self._bh = Branches(addr, ea - self._baseaddr, rsr)
    else:
      vm.set_pc(0xFFFF)

  # Opcode 7E (STK)
  def _op7E(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    amt += 1
    send = si + amt
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount.
      attrs = self._new_attr_opcode(addr, 2, 'STK')
      attrs.comment = '[Push'
      if (amt & 1) == 0:
        sr, _ = get_regs_wb(regs)
        for s in range(si, send, 2):
          attrs.comment += " {0}".format(regaddress_word[s])
      else:
        sr, _ = get_regs_bb(regs)
        for s in range(si, send):
          attrs.comment += " {0}".format(regaddress_byte[s])
      attrs.comment += ' to the stack]'
      attrs.args = "{0},{1}".format(sr, amt)
    # Execute.
    vm = self._vm
    if (si & 0x1) == 0 and (amt & 1) == 0:
      for s in range(si, send, 2):
        vm.push_w(vm.get_reg_w(s))
    else:
      for s in range(si, send):
        vm.push_b(vm.get_reg_b(s))
    vm.incr_pc(2)

  # Opcode 7F (POP)
  def _op7F(self, addr: int) -> None:
    # Get the registers.
    regs = self._relocated[addr + 1]
    si, amt = get_regs(regs)
    amt += 1
    sstart = si + amt
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 register/amount.
      attrs = self._new_attr_opcode(addr, 2, 'POP')
      attrs.comment = '[Pop'
      if (amt & 1) == 0:
        sr, _ = get_regs_wb(regs)
        for s in range(sstart - 2, si - 2, -2):
          attrs.comment += " {0}".format(regaddress_word[s])
      else:
        sr, _ = get_regs_bb(regs)
        for s in range(sstart - 1, si - 1, -1):
          attrs.comment += " {0}".format(regaddress_byte[s])
      attrs.comment += ' from the stack]'
      attrs.args = "{0},{1}".format(sr, amt)
    # Execute.
    vm = self._vm
    if (si & 0x1) == 0 and (amt & 1) == 0:
      for s in range(sstart - 2, si - 2, -2):
        vm.set_reg_w(s, vm.pop_w())
    else:
      for s in range(sstart - 1, si - 1, -1):
        vm.set_reg_b(s, vm.pop_b())
    vm.incr_pc(2)

  # Opcode 80 (LDAB immediate)
  def _op80(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 immediate.
      attrs = self._new_attr_opcode(addr, 2, 'LDAB=')
      self._attr_byte_arg(addr + 1, attrs)
      attrs.comment += ' [Load AL with immediate]'
    # Execute.
    vm = self._vm
    iv = vm.get_mem_b(vm.get_pc() + 1)
    vm.set_reg_b('AL', iv)
    vm.update_m_b(iv)
    vm.update_v(iv)
    vm.incr_pc(2)

  # Opcode 81 (LDAB direct)
  def _op81(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'LDAB/')
      self._attr_word_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Load AL direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    dv = vm.get_mem_b(ea)
    vm.set_reg_b('AL', dv)
    vm.update_m_b(dv)
    vm.update_v(dv)
    vm.incr_pc(3)

  # Opcode 82 (LDAB indirect)
  def _op82(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'LDAB$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Load AL indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc(3)

  # Opcode 83 (LDAB relative)
  def _op83(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDAB')
      disp = self._attr_displace_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Load AL relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    rv = vm.get_mem_b(ea)
    vm.set_reg_b('AL', rv)
    vm.update_m_b(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 84 (LDAB relative indirect)
  def _op84(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDAB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Load AL relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    rv = vm.get_mem_b(ea)
    vm.set_reg_b('AL', rv)
    vm.update_m_b(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 85 (LDAB indexed)
  def _op85(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'LDAB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Load AL', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    if post:
      rv = (rv + 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc(attrs.num_bytes)

  # Opcode 86 (DPE)
  def _op86(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DPE')
      attrs.comment = '[Disable parity error]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 87 (Illegal opcode)
  def _op87(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode 87]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 88 (LDAB implicit A)
  def _op88(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'A'
      attrs.comment = '[Load AL from address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 89 (LDAB implicit B)
  def _op89(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'B'
      attrs.comment = '[Load AL from address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8A (LDAB implicit X)
  def _op8A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'X'
      attrs.comment = '[Load AL from address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8B (LDAB implicit Y)
  def _op8B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'Y'
      attrs.comment = '[Load AL from address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8C (LDAB implicit Z)
  def _op8C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'Z'
      attrs.comment = '[Load AL from address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8D (LDAB implicit S)
  def _op8D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'S'
      attrs.comment = '[Load AL from address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8E (LDAB implicit C)
  def _op8E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'C'
      attrs.comment = '[Load AL from address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 8F (LDAB implicit P)
  def _op8F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDAB+')
      attrs.args = 'P'
      attrs.comment = '[Load AL from address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('AL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 90 (LDA immediate)
  def _op90(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'LDA=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load A with immediate]'
    # Execute.
    vm = self._vm
    iv = vm.get_mem_w(vm.get_pc() + 1)
    vm.set_reg_w('A', iv)
    vm.update_m_w(iv)
    vm.update_v(iv)
    vm.incr_pc(3)

  # Opcode 91 (LDA direct)
  def _op91(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'LDA/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load A direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    dv = vm.get_mem_w(ea)
    vm.set_reg_w('A', dv)
    vm.update_m_w(dv)
    vm.update_v(dv)
    vm.incr_pc(3)

  # Opcode 92 (LDA indirect)
  def _op92(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'LDA$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Load A indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(3)

  # Opcode 93 (LDA relative)
  def _op93(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDA')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load A relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('A', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 94 (LDA relative indirect)
  def _op94(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDA*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Load A relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('A', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode 95 (LDA indexed)
  def _op95(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'LDA')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Load A', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(attrs.num_bytes)

  # Opcode 96 (SOP)
  def _op96(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SOP')
      attrs.comment = '[Set odd parity]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 97 (Illegal opcode)
  def _op97(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode 97]'
    # Execute.
    self._vm.incr_pc()

  # Opcode 98 (LDA implicit A)
  def _op98(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'A'
      attrs.comment = '[Load A from address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 99 (LDA implicit B)
  def _op99(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'B'
      attrs.comment = '[Load A from address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9A (LDA implicit X)
  def _op9A(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'X'
      attrs.comment = '[Load A from address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9B (LDA implicit Y)
  def _op9B(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'Y'
      attrs.comment = '[Load A from address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9C (LDA implicit Z)
  def _op9C(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'Z'
      attrs.comment = '[Load A from address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9D (LDA implicit S)
  def _op9D(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'S'
      attrs.comment = '[Load A from address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9E (LDA implicit C)
  def _op9E(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'C'
      attrs.comment = '[Load A from address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode 9F (LDA implicit P)
  def _op9F(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDA+')
      attrs.args = 'P'
      attrs.comment = '[Load A from address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('A', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode A0 (STAB immediate)
  def _opA0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 immediate.
      attrs = self._new_attr_opcode(addr, 2, 'STAB=')
      self._attr_byte_arg(addr + 1, attrs)
      attrs.comment += ' [Store AL immediate]'
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    ea = vm.get_pc() + 1
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(2)

  # Opcode A1 (STAB direct)
  def _opA1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STAB/')
      self._attr_word_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Store AL direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(3)

  # Opcode A2 (STAB indirect)
  def _opA2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'STAB$')
      self._attr_word_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store AL indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(3)

  # Opcode A3 (STAB relative)
  def _opA3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STAB')
      disp = self._attr_displace_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Store AL relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(2)

  # Opcode A4 (STAB relative indirect)
  def _opA4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STAB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store AL relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    al = vm.get_reg_b('AL')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(2)

  # Opcode A5 (STAB indexed)
  def _opA5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'STAB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Store AL', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    al = vm.get_reg_b('AL')
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    vm.set_mem_b(ea, al)
    if post:
      rv = (rv + 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc(attrs.num_bytes)

  # Opcode A6 (SEP)
  def _opA6(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'SEP')
      attrs.comment = '[Set even parity]'
    # Execute.
    self._vm.incr_pc()

  # Opcode A7 (Illegal opcode)
  def _opA7(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode A7]'
    # Execute.
    self._vm.incr_pc()

  # Opcode A8 (STAB implicit A)
  def _opA8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'A'
      attrs.comment = '[Store AL to address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode A9 (STAB implicit B)
  def _opA9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'B'
      attrs.comment = '[Store AL to address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AA (STAB implicit X)
  def _opAA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'X'
      attrs.comment = '[Store AL to address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AB (STAB implicit Y)
  def _opAB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'Y'
      attrs.comment = '[Store AL to address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AC (STAB implicit Z)
  def _opAC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'Z'
      attrs.comment = '[Store AL to address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AD (STAB implicit S)
  def _opAD(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'S'
      attrs.comment = '[Store AL to address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AE (STAB implicit C)
  def _opAE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'C'
      attrs.comment = '[Store AL to address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode AF (STAB implicit P)
  def _opAF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STAB+')
      attrs.args = 'P'
      attrs.comment = '[Store AL to address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    al = vm.get_reg_b('AL')
    vm.set_mem_b(ea, al)
    vm.update_m_b(al)
    vm.update_v(al)
    vm.incr_pc()

  # Opcode B0 (STA immediate)
  def _opB0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'STA=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store A immediate]'
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    ea = vm.get_pc() + 1
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(3)

  # Opcode B1 (STA direct)
  def _opB1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STA/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store A direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(3)

  # Opcode B2 (STA indirect)
  def _opB2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STA$')
      self._attr_word_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store A indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(3)

  # Opcode B3 (STA relative)
  def _opB3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STA')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store A relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(2)

  # Opcode B4 (STA relative indirect)
  def _opB4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STA*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store A relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(2)

  # Opcode B5 (STA indexed)
  def _opB5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'STA')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Store A', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    a = vm.get_reg_w('A')
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, a)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc(attrs.num_bytes)

  # Opcode B6 (ECK)
  def _opB6(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'ECK')
      attrs.comment = '[Enable clock]'
    # Execute. Sets AU in level 1 to 0xff.
    vm = self._vm
    vm.set_mem_b(0x0010, 0xFF)
    vm.incr_pc()

  # Opcode B7 (Illegal opcode)
  def _opB7(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode B7]'
    # Execute.
    self._vm.incr_pc()

  # Opcode B8 (STA implicit A)
  def _opB8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'A'
      attrs.comment = '[Store A to address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode B9 (STA implicit B)
  def _opB9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'B'
      attrs.comment = '[Store A to address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BA (STA implicit X)
  def _opBA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'X'
      attrs.comment = '[Store A to address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BB (STA implicit Y)
  def _opBB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'Y'
      attrs.comment = '[Store A to address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BC (STA implicit Z)
  def _opBC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'Z'
      attrs.comment = '[Store A to address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BD (STA implicit S)
  def _opBD(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'S'
      attrs.comment = '[Store A to address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BE (STA implicit C)
  def _opBE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'C'
      attrs.comment = '[Store A to address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode BF (STA implicit P)
  def _opBF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STA+')
      attrs.args = 'P'
      attrs.comment = '[Store A to address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    a = vm.get_reg_w('A')
    vm.set_mem_w(ea, a)
    vm.update_m_w(a)
    vm.update_v(a)
    vm.incr_pc()

  # Opcode C0 (LDBB immediate)
  def _opC0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 immediate.
      attrs = self._new_attr_opcode(addr, 2, 'LDBB=')
      self._attr_byte_arg(addr + 1, attrs)
      attrs.comment += ' [Load BL with immediate]'
    # Execute.
    vm = self._vm
    iv = vm.get_mem_b(vm.get_pc() + 1)
    vm.set_reg_b('BL', iv)
    vm.update_m_b(iv)
    vm.update_v(iv)
    vm.incr_pc(2)

  # Opcode C1 (LDBB direct)
  def _opC1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'LDBB/')
      self._attr_word_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Load BL direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    dv = vm.get_mem_b(ea)
    vm.set_reg_b('BL', dv)
    vm.update_m_b(dv)
    vm.update_v(dv)
    vm.incr_pc(3)

  # Opcode C2 (LDBB indirect)
  def _opC2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'LDBB$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Load BL indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc(3)

  # Opcode C3 (LDBB relative)
  def _opC3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDBB')
      disp = self._attr_displace_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Load BL relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    rv = vm.get_mem_b(ea)
    vm.set_reg_b('BL', rv)
    vm.update_m_b(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode C4 (LDBB relative indirect)
  def _opC4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDBB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Load BL relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    rv = vm.get_mem_b(ea)
    vm.set_reg_b('BL', rv)
    vm.update_m_b(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode C5 (LDBB indexed)
  def _opC5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'LDBB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Load BL', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    if post:
      rv = (rv + 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc(attrs.num_bytes)

  # Opcode C6 (DCK)
  def _opC6(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'DCK')
      attrs.comment = '[Disable clock]'
    # Execute. Sets AU in level 1 to 0.
    vm = self._vm
    vm.set_mem_b(0x0010, 0)
    vm.incr_pc()

  # Opcode C7 (Illegal opcode)
  def _opC7(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode C7]'
    # Execute.
    self._vm.incr_pc()

  # Opcode C8 (LDBB implicit A)
  def _opC8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'A'
      attrs.comment = '[Load BL from address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode C9 (LDBB implicit B)
  def _opC9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'B'
      attrs.comment = '[Load BL from address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CA (LDBB implicit X)
  def _opCA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'X'
      attrs.comment = '[Load BL from address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CB (LDBB implicit Y)
  def _opCB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'Y'
      attrs.comment = '[Load BL from address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CC (LDBB implicit Z)
  def _opCC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'Z'
      attrs.comment = '[Load BL from address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CD (LDBB implicit S)
  def _opCD(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'S'
      attrs.comment = '[Load BL from address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CE (LDBB implicit C)
  def _opCE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'C'
      attrs.comment = '[Load BL from address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode CF (LDBB implicit P)
  def _opCF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDBB+')
      attrs.args = 'P'
      attrs.comment = '[Load BL from address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    val = vm.get_mem_b(ea)
    vm.set_reg_b('BL', val)
    vm.update_m_b(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode D0 (LDB immediate)
  def _opD0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'LDB=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load B with immediate]'
    # Execute.
    vm = self._vm
    iv = vm.get_mem_w(vm.get_pc() + 1)
    vm.set_reg_w('B', iv)
    vm.update_m_w(iv)
    vm.update_v(iv)
    vm.incr_pc(3)

  # Opcode D1 (LDB direct)
  def _opD1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'LDB/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load B direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    dv = vm.get_mem_w(ea)
    vm.set_reg_w('B', dv)
    vm.update_m_w(dv)
    vm.update_v(dv)
    vm.incr_pc(3)

  # Opcode D2 (LDB indirect)
  def _opD2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'LDB$')
      self._attr_word_arg(addr + 1, 'P', attrs) - self._baseaddr
      attrs.comment += ' [Load B indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(3)

  # Opcode D3 (LDB relative)
  def _opD3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDB')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Load B relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('B', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode D4 (LDB relative indirect)
  def _opD4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'LDB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Load B relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    rv = vm.get_mem_w(ea)
    vm.set_reg_w('B', rv)
    vm.update_m_w(rv)
    vm.update_v(rv)
    vm.incr_pc(2)

  # Opcode D5 (LDB indexed)
  def _opD5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'LDB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Load B', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc(attrs.num_bytes)

  # Opcode D6 (STR)
  def _opD6(self, addr: int) -> None:
    # Get the registers. Note they are reversed from the usual order.
    regs = self._relocated[addr + 1]
    di, si = get_regs(regs)
    vm = self._vm
    # If the source and destination are even, this is normal register-to-
    # register STR.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      dr, sr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 2 bytes: 1 opcode, 1 registers.
        attrs = self._new_attr_opcode(addr, 2, 'STR')
        self._attr_regs(sr, dr, "[Store {0} to {1}]", attrs)
      # Execute.
      sv = vm.get_reg_w(si)
      vm.set_reg_w(di, sv)
      vm.update_m_w(sv)
      vm.update_v(sv)
      vm.incr_pc(2)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's a register-to-
      # direct-address STR.
      _, sr = get_regs_bw(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 address.
        attrs = self._new_attr_opcode(addr, 4, 'STR/')
        self._attr_word_arg(addr + 2, 'W', attrs)
        attrs.args += ",{0}".format(sr)
        attrs.comment += " [Store {0} direct]".format(sr)
      # Execute.
      rv = vm.get_reg_w(sr)
      ea = vm.get_mem_w(addr + 2)
      vm.set_mem_w(ea, rv)
      vm.update_m_w(rv)
      vm.update_v(rv)
      vm.incr_pc(4)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's a register-to-
      # immediate STR.
      _, sr = get_regs_bw(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 immediate.
        attrs = self._new_attr_opcode(addr, 4, 'STR=')
        self._attr_word_arg(addr + 2, 'W', attrs)
        attrs.args += ",{0}".format(sr)
        attrs.comment += " [Store {0} to immediate]".format(sr)
      # Execute.
      ea = vm.get_pc() + 2
      rv = vm.get_reg_w(sr)
      vm.update_m_w(rv)
      vm.update_v(rv)
      vm.incr_pc(4)
    else:
      # If the source and destination are odd, it's a register-to-indexed-
      # displacement (word) STR.
      dr, sr = get_regs_ww(regs)
      if addr not in self._attrs:
        # 4 bytes: 1 opcode, 1 registers, 2 displacement.
        attrs = self._new_attr_opcode(addr, 4, 'STR-')
        disp = int.from_bytes(self._relocated[addr+2:addr+4], 'big')
        if is_neg_w(disp):
          disp = neg_w(disp)
        attrs.args += "{0},{1},{2}".format(dr, disp, sr)
        attrs.comment += "[Store {0} indexed-displaced]".format(sr)
      # Execute.
      ea = vm.get_reg_w(dr)
      ea += vm.get_mem_w(vm.get_pc() + 2)
      rv = vm.get_reg_w(sr)
      vm.update_m_w(rv)
      vm.update_v(rv)
      vm.incr_pc(4)

  # Opcode D7 (SAR)
  def _opD7(self, addr: int) -> None:
    # Get the level and register.
    regs = self._relocated[addr + 1]
    lvl, _ = get_regs(regs)
    _, dr = get_regs_ww(regs)
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 level/register.
      attrs = self._new_attr_opcode(addr, 2, 'SAR')
      attrs.args = "{0},{1}".format(lvl, dr)
      attrs.comment = "[Store A to {0} at interrupt level {1}]".format(dr, lvl)
    # Execute. Nothing really to do.
    self._vm.incr_pc(2)

  # Opcode D8 (LDB implicit A)
  def _opD8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'A'
      attrs.comment = '[Load B from address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode D9 (LDB implicit B)
  def _opD9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'B'
      attrs.comment = '[Load B from address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DA (LDB implicit X)
  def _opDA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'X'
      attrs.comment = '[Load B from address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DB (LDB implicit Y)
  def _opDB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'Y'
      attrs.comment = '[Load B from address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DC (LDB implicit Z)
  def _opDC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'Z'
      attrs.comment = '[Load B from address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DD (LDB implicit S)
  def _opDD(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'S'
      attrs.comment = '[Load B from address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DE (LDB implicit C)
  def _opDE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'C'
      attrs.comment = '[Load B from address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode DF (LDB implicit P)
  def _opDF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'LDB+')
      attrs.args = 'P'
      attrs.comment = '[Load B from address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    val = vm.get_mem_w(ea)
    vm.set_reg_w('B', val)
    vm.update_m_w(val)
    vm.update_v(val)
    vm.incr_pc()

  # Opcode E0 (STBB immediate)
  def _opE0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 immediate.
      attrs = self._new_attr_opcode(addr, 2, 'STBB=')
      self._attr_byte_arg(addr + 1, attrs)
      attrs.comment += ' [Store BL immediate]'
    # Execute.
    vm = self._vm
    bl = vm.get_reg_b('BL')
    ea = vm.get_pc() + 1
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(2)

  # Opcode E1 (STBB direct)
  def _opE1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STBB/')
      self._attr_word_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Store BL direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(3)

  # Opcode E2 (STBB indirect)
  def _opE2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 indirect address.
      attrs = self._new_attr_opcode(addr, 3, 'STBB$')
      self._attr_word_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store BL indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(3)

  # Opcode E3 (STBB relative)
  def _opE3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STBB')
      disp = self._attr_displace_arg(addr + 1, 'B', attrs)
      attrs.comment += ' [Store BL relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    bl = vm.get_reg_b('BL')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(2)

  # Opcode E4 (STBB relative indirect)
  def _opE4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STBB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store BL relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    bl = vm.get_reg_b('BL')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(2)

  # Opcode E5 (STBB indexed)
  def _opE5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'STBB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Store BL', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    bl = vm.get_reg_b('BL')
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    vm.set_mem_b(ea, bl)
    if post:
      rv = (rv + 1) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc(attrs.num_bytes)

  # Opcode E6 (LAR)
  def _opE6(self, addr: int) -> None:
    # Get the level and register.
    regs = self._relocated[addr + 1]
    lvl, _ = get_regs(regs)
    _, sr = get_regs_ww(regs)
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 level/register.
      attrs = self._new_attr_opcode(addr, 2, 'LAR')
      attrs.args = "{0},{1}".format(lvl, sr)
      attrs.comment = "[Load A from {0} at interrupt level {1}]".format(sr, lvl)
    # Execute. Nothing really to do.
    self._vm.incr_pc(2)

  # Opcode E7 (Illegal opcode)
  def _opE7(self, addr: int) -> None:
    if addr not in self._attrs:
      # Single byte illegal opcode.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [Illegal opcode E7]'
    # Execute.
    self._vm.incr_pc()

  # Opcode E8 (STBB implicit A)
  def _opE8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'A'
      attrs.comment = '[Store BL to address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode E9 (STBB implicit B)
  def _opE9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'B'
      attrs.comment = '[Store BL to address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode EA (STBB implicit X)
  def _opEA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'X'
      attrs.comment = '[Store BL to address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode EB (STBB implicit Y)
  def _opEB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'Y'
      attrs.comment = '[Store BL to address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode EC (STBB implicit Z)
  def _opEC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'Z'
      attrs.comment = '[Store BL to address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode ED (STBB implicit S)
  def _opED(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'S'
      attrs.comment = '[Store BL to address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode EE (STBB implicit C)
  def _opEE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'C'
      attrs.comment = '[Store BL to address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode EF (STBB implicit P)
  def _opEF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STBB+')
      attrs.args = 'P'
      attrs.comment = '[Store BL to address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    bl = vm.get_reg_b('BL')
    vm.set_mem_b(ea, bl)
    vm.update_m_b(bl)
    vm.update_v(bl)
    vm.incr_pc()

  # Opcode F0 (STB immediate)
  def _opF0(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 immediate.
      attrs = self._new_attr_opcode(addr, 3, 'STB=')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store B immediate]'
    # Execute.
    vm = self._vm
    b = vm.get_reg_w('B')
    ea = vm.get_pc() + 1
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(3)

  # Opcode F1 (STB direct)
  def _opF1(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STB/')
      self._attr_word_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store B direct]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(3)

  # Opcode F2 (STB indirect)
  def _opF2(self, addr: int) -> None:
    if addr not in self._attrs:
      # 3 bytes: 1 opcode, 2 direct address.
      attrs = self._new_attr_opcode(addr, 3, 'STB$')
      self._attr_word_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store B indirect]'
    # Execute.
    vm = self._vm
    ea = vm.get_mem_w(vm.get_pc() + 1)
    ea = vm.get_mem_w(ea)
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(3)

  # Opcode F3 (STB relative)
  def _opF3(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STB')
      disp = self._attr_displace_arg(addr + 1, 'W', attrs)
      attrs.comment += ' [Store B relative]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    b = vm.get_reg_w('B')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(2)

  # Opcode F4 (STB relative indirect)
  def _opF4(self, addr: int) -> None:
    if addr not in self._attrs:
      # 2 bytes: 1 opcode, 1 displacement.
      attrs = self._new_attr_opcode(addr, 2, 'STB*')
      disp = self._attr_displace_arg(addr + 1, 'P', attrs)
      attrs.comment += ' [Store B relative indirect]'
    else:
      # Get the displacement.
      disp = self._relocated[addr + 1]
      if is_neg_b(disp):
        disp = neg_b(disp)
    # Execute.
    vm = self._vm
    b = vm.get_reg_w('B')
    ea = (vm.get_pc() + 2 + disp) & 0xFFFF
    ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(2)

  # Opcode F5 (STB indexed)
  def _opF5(self, addr: int) -> None:
    if addr in self._attrs:
      # Create fake attributes if they already exist.
      attrs = Attrs(2)
    else:
      # At least 2 bytes: 1 opcode, 1 r+M'.
      attrs = self._new_attr_opcode(addr, 2, 'STB')
    r, pre, post, indir, disp = self._attr_indexed(addr + 1, 'Store B', attrs)
    # Execute.
    vm = self._vm
    rv = vm.get_reg_w(r)
    if pre:
      rv = (rv - 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    b = vm.get_reg_w('B')
    ea = (rv + disp) & 0xFFFF
    if indir:
      ea = vm.get_mem_w(ea)
    vm.set_mem_w(ea, b)
    if post:
      rv = (rv + 2) & 0xFFFF
      vm.set_reg_w(r, rv)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc(attrs.num_bytes)

  # Opcode F6 (MMIO instructions)
  def _opF6(self, addr: int) -> None:
    # Get the registers and displacement.
    regs = self._relocated[addr + 1]
    si, di = get_regs(regs)
    sr, dr = get_regs_ww(regs)
    disp = self._relocated[addr + 2]
    if is_neg_b(disp):
      disp = neg_b(disp)
    # If the source and destination are even, this is LIO.
    if (si & 0x1) == 0 and (di & 0x1) == 0:
      if addr not in self._attrs:
        # 3 bytes: 1 opcode, 1 registers, 1 displacement.
        attrs = self._new_attr_opcode(addr, 3, 'LIO')
        if disp == 0:
          attrs.args = "{0},{1}".format(sr, dr)
          attrs.comment = "[Load {0} from MMIO address in {1}]".format(sr, dr)
        else:
          attrs.args = "{0},{1},{2}".format(sr, dr, disp)
          attrs.comment = \
            "[Load {0} from MMIO address {1}{2:+d}]".format(sr, dr, disp)
    elif (si & 0x1) == 1 and (di & 0x1) == 0:
      # If the source register is odd and destination even, it's LIOB.
      if addr not in self._attrs:
        # 3 bytes: 1 opcode, 1 registers, 1 displacement.
        attrs = self._new_attr_opcode(addr, 3, 'LIOB')
        if disp == 0:
          attrs.args = "{0},{1}".format(sr, dr)
          attrs.comment = "[Load {0} from MMIO address in {1}]".format(
            regaddress_byte[si], dr)
        else:
          attrs.args = "{0},{1},{2}".format(sr, dr, disp)
          attrs.comment = "[Load {0} from MMIO address {1}{2:+d}]".format(
            regaddress_byte[si], dr, disp)
    elif (si & 0x1) == 0 and (di & 0x1) == 1:
      # If the source register is even and destination odd, it's SIO.
      if addr not in self._attrs:
        # 3 bytes: 1 opcode, 1 registers, 1 displacement.
        attrs = self._new_attr_opcode(addr, 3, 'SIO')
        if disp == 0:
          attrs.args = "{0},{1}".format(sr, dr)
          attrs.comment = "[Store {0} to MMIO address in {1}]".format(sr, dr)
        else:
          attrs.args = "{0},{1},{2}".format(sr, dr, disp)
          attrs.comment = \
            "[Store {0} to MMIO address {1}{2:+d}]".format(sr, dr, disp)
    else:
      # If the source and destination are odd, it's SIOB.
      if addr not in self._attrs:
        # 3 bytes: 1 opcode, 1 registers, 1 displacement.
        attrs = self._new_attr_opcode(addr, 3, 'SIOB')
        if disp == 0:
          attrs.args = "{0},{1}".format(sr, dr)
          attrs.comment = "[Store {0} to MMIO address in {1}]".format(
            regaddress_byte[si], dr)
        else:
          attrs.args = "{0},{1},{2}".format(sr, dr, disp)
          attrs.comment = "[Store {0} to MMIO address {1}{2:+d}]".format(
            regaddress_byte[si], dr, disp)
    # Execute. Nothing really to do.
    vm = self._vm
    vm.incr_pc(3)

  # Opcode F7 (MVL)
  def _opF7(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'MVL')
      attrs.comment = '[Move long (len-1 in A, src in B, dst in Y)]'
    # Execute. Unlikely to affect disassembly, so don't clobber potentially a
    # huge chunk of memory.
    vm = self._vm
    vm.incr_pc()

  # Opcode F8 (STB implicit A)
  def _opF8(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'A'
      attrs.comment = '[Store B to address in A]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode F9 (STB implicit B)
  def _opF9(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'B'
      attrs.comment = '[Store B to address in B]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('B')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FA (STB implicit X)
  def _opFA(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'X'
      attrs.comment = '[Store B to address in X]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('X')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FB (STB implicit Y)
  def _opFB(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'Y'
      attrs.comment = '[Store B to address in Y]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Y')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FC (STB implicit Z)
  def _opFC(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'Z'
      attrs.comment = '[Store B to address in Z]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('Z')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FD (STB implicit S)
  def _opFD(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'S'
      attrs.comment = '[Store B to address in S]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('S')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FE (STB implicit C)
  def _opFE(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'C'
      attrs.comment = '[Store B to address in C]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('C')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # Opcode FF (STB implicit P)
  def _opFF(self, addr: int) -> None:
    if addr not in self._attrs:
      # 1 byte: 1 opcode.
      attrs = self._new_attr_opcode(addr, 1, 'STB+')
      attrs.args = 'P'
      attrs.comment = '[Store B to address in P]'
    # Execute.
    vm = self._vm
    ea = vm.get_reg_w('P')
    b = vm.get_reg_w('B')
    vm.set_mem_w(ea, b)
    vm.update_m_w(b)
    vm.update_v(b)
    vm.incr_pc()

  # SVC 00 (PIOC - physical i/o control)
  def _svc00(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Unknown.
    return 0

  # SVC 01 (TRTN - transient return)
  def _svc01(self, addr: int, need_attrs: bool) -> int:
    # Return code.
    if need_attrs:
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [return code]'
    # Does not return.
    return -1

  # SVC 02 (LODNM - load file name specified)
  def _svc02(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 03 (LODF - load FCB specified) CPU5: LODD
  def _svc03(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
      # Word.
      attrs = self._new_attr_word(addr + 2)
      attrs.comment += ' [TODO: arg2]'
      # Word.
      attrs = self._new_attr_word(addr + 4)
      attrs.comment += ' [TODO: arg3]'
    # Execute. Unknown.
    return 6

  # SVC 04 (LODJX - load JX module specified)
  def _svc04(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
      # Byte.
      attrs = self._new_attr_byte(addr + 2)
      attrs.comment += ' [TODO: arg2]'
    # Execute. In some cases it does not return; in others is overlays the
    # module and sets B. We'll just do nothing and assume the return happens.
    return 3

  # SVC 05 (TS - load transient module)
  def _svc05(self, addr: int, need_attrs: bool) -> int:
    vm = self._vm
    # Selector byte.
    selector = self._relocated[addr]
    saddr = addr + 1
    if need_attrs:
      s_attrs = self._new_attr_byte(addr)
    # Handle each selector.
    if selector == 4:
      if need_attrs:
        s_attrs.comment += ' [Selector: string date from date in A]'
        # Address of string date.
        self._new_attr_address(saddr, 'S', 'address of string date')
      saddr += 2
      # Execute.
      daddr = vm.get_mem_w(vm.get_pc() + 1)
      dstamp = vm.get_reg_w('A') + self.date_base
      sdate = date.fromordinal(dstamp).strftime('%m/%d/%y')
      vm.set_mem_w(daddr, ascii_w(sdate[0:2]))
      vm.set_mem_b(daddr + 2, ascii_b(sdate[2:3]))
      vm.set_mem_w(daddr + 3, ascii_w(sdate[3:5]))
      vm.set_mem_b(daddr + 5, ascii_b(sdate[5:6]))
      vm.set_mem_w(daddr + 6, ascii_w(sdate[6:8]))
    elif selector == 9:
      if need_attrs:
        s_attrs.comment += ' [Selector: load private library?]'
        # Address.
        self._new_attr_address(saddr, 'L', 'address of TODO')
      saddr += 2
      if need_attrs:
        # Address.
        self._new_attr_address(saddr, 'J', 'jump address TODO')
      saddr += 2
      if need_attrs:
        # Word.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg 3]'
      saddr += 2
      if need_attrs:
        # Count of additional words.
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [word argument count]'
      argcount = self._relocated[saddr]
      saddr += 1
      for i in range(argcount):
        # Execute. These appear to be addresses of either functions or arguments
        # to the functions. The SVC call jumps to one of them unless something
        # goes very wrong.
        vmaddr = saddr + self._baseaddr
        vmtarget = vm.get_mem_w(vmaddr)
        target = vmtarget - self._baseaddr
        if need_attrs:
          if target in self._datas:
            attrs = self._new_attr_address(saddr, 'W', 'Address argument')
          else:
            attrs = self._new_attr_address(saddr, 'F', 'Function argument')
            if target not in self._attrs:
              # Create a snapshot to disassemble this function target. Set X
              # to the next argument so the function can read arguments.
              snap = VM(vm)
              snap.set_pc(vmtarget)
              snap.set_reg_w('X', vmaddr + 2)
              self._snapshots.append(snap)
        saddr += 2
    elif selector == 10:
      if need_attrs:
        s_attrs.comment += ' [Selector: integer date]'
        # Address of integer date.
        self._new_attr_address(saddr, 'I', 'address of integer date')
      saddr += 2
      # Execute.
      daddr = vm.get_mem_w(vm.get_pc() + 1)
      dstamp = vm.get_reg_w('A') + self.date_base
      idate = int(date.fromordinal(dstamp).strftime('%m%d%y'))
      vm.set_mem_w(daddr, idate >> 16)
      vm.set_mem_w(daddr + 2, idate & 0xFFFF)
    elif selector == 12:
      if need_attrs:
        s_attrs.comment += ' [Selector: get file date to A register]'
        # Address.
        self._new_attr_address(saddr, 'L', 'address of RCB')
      saddr += 2
      # Execute. Unknown.
    elif selector == 13:
      if need_attrs:
        s_attrs.comment += ' [Selector: set file date from A register]'
        # Address.
        self._new_attr_address(saddr, 'L', 'address of RCB')
      saddr += 2
      # Execute. Unknown.
    elif selector == 14:
      if need_attrs:
        s_attrs.comment += ' [Selector: open file by name/disk]'
        # Address of filename.
        self._new_attr_address(saddr, 'S', 'address of filename')
      saddr += 2
      if need_attrs:
        # Address of FCB.
        self._new_attr_address(saddr, 'L', 'address of FCB')
      saddr += 2
      if need_attrs:
        # Disk number.
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [disk number]'
      saddr += 1
      if need_attrs:
        # Byte.
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg 5]'
      saddr += 1
      # Execute. Simulate the file opening successfully.
      vm.set_reg_w('A', 0)
    else:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    return saddr - addr

  # SVC 06 (FLWT - wait for flag to go positive)
  def _svc06(self, addr: int, need_attrs: bool) -> int:
    # Byte data.
    if need_attrs:
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [TODO: arg 1]'
    # Execute.
    vm = self._vm
    vm.set_reg_w('A', 0x0300)
    return 1

  # SVC 07 (WT - unconditional wait)
  def _svc07(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Nothing really to do.
    return 0

  # SVC 08 (RBWT - wait for RCB to go ready)
  def _svc08(self, addr: int, need_attrs: bool) -> int:
    # Word data.
    if need_attrs:
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg 1]'
    # Execute.
    vm = self._vm
    vm.set_reg_w('A', 0x8500)
    return 2

  # SVC 09 (ABRT - abort task)
  def _svc09(self, addr: int, need_attrs: bool) -> int:
    # Abort code.
    if need_attrs:
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [abort code]'
    # Does not return.
    return -1

  # SVC 0A (EXIT - exit to OJX00)
  def _svc0A(self, addr: int, need_attrs: bool) -> int:
    # Completion code.
    if need_attrs:
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [completion code]'
    # Does not return.
    return -1

  # SVC 0B (DT - get binary date)
  def _svc0B(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Simulate 1988/02/23, which is 0x7DC4 after the base.
    self._vm.set_reg_w('A', 0x7DC4)
    return 0

  # SVC 0C (PGIOB - protected get I/O block) CPU5: GIOB
  def _svc0C(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. B=0 appears to signal an error.
    vm = self._vm
    vm.set_reg_w('B', 0x38A2)
    return 0

  # SVC 0D (JXM - protected change to JX map) CPU5: DIRPD
  def _svc0D(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      # Word, word.
      if need_attrs:
        attrs = self._new_attr_word(addr)
        attrs.comment += ' [TODO: arg 1]'
        attrs = self._new_attr_word(addr + 2)
        attrs.comment += ' [TODO: arg 2]'
      return 4
    # No data.
    # Execute. Nothing to do as this should just change the map level.
    return 0

  # SVC 0E (DIRNM - search directory for file name specified)
  def _svc0E(self, addr: int, need_attrs: bool) -> int:
    # Word data.
    if need_attrs:
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg 1]'
    # Execute. Sets A and B to 0 on error.
    vm = self._vm
    vm.set_reg_w('A', 1)
    vm.set_reg_w('B', 1)
    return 2

  # SVC 0F (CONIO - console I/O)
  def _svc0F(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Nothing to do as this writes to the console.
    return 0

  # SVC 10 (SYSIO - device-independent logical I/O [all units])
  def _svc10(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute.
    vm = self._vm
    rcb = vm.get_reg_w('B')
    io = vm.get_mem_b(rcb + 3)
    if io == 2:
      # Output.
      vm.set_mem_w(rcb + 8, 0x0FA0)
    elif io == 1:
      # Input. Simulate the user entering '0'.
      vm.set_mem_b(rcb, 0x00)
      straddr = vm.get_mem_w(rcb + 6)
      vm.set_mem_w(straddr, 1)
      vm.set_mem_b(straddr + 2, ascii_b('0'))
    return 0

  # SVC 11 (GMEMR - GMEM with A=addr B=size) CPU5: DIO
  def _svc11(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 12 (FLWTR - FLWT with flag address in AL) CPU5: SHLD
  def _svc12(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 13 (RMEMR - RMEM with address in A) CPU5: SFRE
  def _svc13(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 14 (DRDY - disk ready check)
  def _svc14(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Nothing to do.
    return 0

  # SVC 15 (GBR - get binary time into A and B registers) CPU5: DIOL
  def _svc15(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      if need_attrs:
        # Word.
        attrs = self._new_attr_word(addr)
        attrs.comment += ' [length]'
        # Byte.
        attrs = self._new_attr_byte(addr + 2)
        attrs.comment += ' [TODO: arg2]'
        # Word.
        attrs = self._new_attr_word(addr + 3)
        attrs.comment += ' [TODO: arg3]'
        # Word.
        attrs = self._new_attr_word(addr + 5)
        attrs.comment += ' [TODO: arg4]'
        # Word.
        attrs = self._new_attr_word(addr + 7)
        attrs.comment += ' [TODO: arg5]'
      # Execute. Unknown.
      return 9
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 16 (GMEM - get memory block from transient area)
  def _svc16(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
      # Word.
      attrs = self._new_attr_word(addr + 2)
      attrs.comment += ' [TODO: arg2]'
    # Execute. Nothing really to do.
    return 4

  # SVC 17 (RMEM - release memory block back to transient area)
  def _svc17(self, addr: int, need_attrs: bool) -> int:
    # Word.
    if need_attrs:
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
    # Execute. Nothing really to do.
    return 2

  # SVC 18 (LIOC - logical I/O control)
  def _svc18(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. B is the address of the FCB. Set status (first byte of FCB) to 0
    # to indicate success.
    vm = self._vm
    vm.set_mem_b(vm.get_reg_w('B'), 0)
    return 0

  # SVC 19 (EXP - file expand)
  def _svc19(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Sets A to 0 on success?
    vm = self._vm
    vm.set_reg_w('A', 0)
    return 0

  # SVC 1A (USER - change to user mode)
  def _svc1A(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 1B (GB - get binary time)
  def _svc1B(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    # Address of destination.
    if need_attrs:
      self._new_attr_address(addr, 'B', 'address to put time')
    # Execute. Simulate time 00:00:00. The integer value is tenths of a second.
    vm = self._vm
    taddr = vm.get_mem_w(vm.get_pc())
    vm.set_mem_w(taddr, 0)
    vm.set_mem_w(taddr + 2, 0)
    return 2

  # SVC 1C (GC - get character time)
  def _svc1C(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    # Address of destination.
    if need_attrs:
      self._new_attr_address(addr, 'S', 'address to put time')
    # Execute. Simulate time 00:00:00.
    vm = self._vm
    taddr = vm.get_mem_w(vm.get_pc())
    vm.set_mem_w(taddr, ascii_w('00'))
    vm.set_mem_b(taddr + 2, ascii_b(':'))
    vm.set_mem_w(taddr + 3, ascii_w('00'))
    vm.set_mem_b(taddr + 5, ascii_b(':'))
    vm.set_mem_w(taddr + 6, ascii_w('00'))
    return 2

  # SVC 1D (STIME - set time lock)
  def _svc1D(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 1E (LD - CPL 32-bit load)
  def _svc1E(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    # Address of integer.
    if need_attrs:
      self._new_attr_address(addr, 'B', 'address of integer')
    # Execute. B gets address of integer.
    vm = self._vm
    iaddr = vm.get_mem_w(vm.get_pc())
    vm.set_reg_w('A', 0x0320)
    vm.set_reg_w('B', iaddr)
    return 2

  # SVC 1F (ST - CPL 32-bit store)
  def _svc1F(self, addr: int, need_attrs: bool) -> int:
    # Same arguments as LD. Similar execution too.
    return self._svc1E(addr, need_attrs)

  # SVC 20 (AD - CPL 32-bit add)
  def _svc20(self, addr: int, need_attrs: bool) -> int:
    # Same arguments as LD. Similar execution too.
    return self._svc1E(addr, need_attrs)

  # SVC 21 (TSR - TS with TX# in AU) CPU5: DIOLF
  def _svc21(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 22 (SU - CPL 32-bit subtract)
  def _svc22(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 23 (GDPUB - locate pub for disk specified in AL)
  def _svc23(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 24 (MU - CPL 32-bit multiply)
  def _svc24(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 25 (DV - CPL 32-bit divide)
  def _svc25(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 26 (CN - CPL 32-bit numeric compare)
  def _svc26(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 27 (CS - CPL string compare)
  def _svc27(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 28 (CG - CPL 32-bit computed goto)
  def _svc28(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 29 (MV - CPL 32-bit string move)
  def _svc29(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 2A (CP - CPL cursor position)
  def _svc2A(self, addr: int, need_attrs: bool) -> int:
    # Address of FCB.
    if need_attrs:
      self._new_attr_address(addr, 'L', 'address of FCB')
    saddr = addr + 2
    # Column.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [column address or value]'
    saddr += 2
    # Row.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [row address or value]'
    saddr += 2
    # Execute. B gets the address of the CPL I/O buffers, which we can't really
    # know, so just use 0.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return saddr - addr

  # SVC 2B (MUL16 - 16-bit multiply)
  def _svc2B(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. This just does MUL B,A.
    vm = self._vm
    a = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    product = b * a
    prodhi = product >> 16
    prodlo = product & 0xFFFF
    vm.set_reg_w('A', prodhi)
    vm.set_reg_w('B', prodlo)
    vm.update_f_w(b, prodhi)
    vm.reset_l()
    vm.update_m_w(prodhi)
    vm.update_v(prodhi | prodlo)
    return 0

  # SVC 2C (DIV16 - 16-bit divide)
  def _svc2C(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. This just does DIV B,A.
    vm = self._vm
    a = vm.get_reg_w('A')
    b = vm.get_reg_w('B')
    if b == 0:
      quotient = 0
      remainder = 0
      vm.set_f()
    else:
      quotient = a // b
      remainder = a - (quotient * b)
    vm.set_reg_w('A', remainder)
    vm.set_reg_w('B', quotient)
    vm.update_m_w(quotient)
    vm.update_v(quotient | remainder)
    return 0

  # SVC 2D (CVD16 - 16-bit convert to decimal from memory)
  def _svc2D(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 2E (CVR16 - 16-bit convert to decimal from A register)
  def _svc2E(self, addr: int, need_attrs: bool) -> int:
    # Address of end of string.
    if need_attrs:
      self._new_attr_address(addr, 'S', 'address of end of string')
    # Execute.
    vm = self._vm
    a = vm.get_reg_w('A')
    ea = vm.get_mem_w(vm.get_pc())
    astr = str(a)
    for i in range(len(astr)):
      vm.set_mem_b(ea - i, ascii_b(astr[-i - 1]))
    return 2

  # SVC 2F (CB - CPL cursor blanking)
  def _svc2F(self, addr: int, need_attrs: bool) -> int:
    # Address of FCB.
    if need_attrs:
      self._new_attr_address(addr, 'L', 'address of FCB')
    saddr = addr + 2
    # Count.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [count]'
    saddr += 2
    # Execute. B gets the address of the CPL I/O buffers, which we can't really
    # know, so just use 0.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return saddr - addr

  # SVC 30 (CC - CPL cursor blanking with specified string)
  def _svc30(self, addr: int, need_attrs: bool) -> int:
    # Address of FCB.
    if need_attrs:
      self._new_attr_address(addr, 'L', 'address of FCB')
    saddr = addr + 2
    # Count.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [count]'
    saddr += 2
    # String.
    if need_attrs:
      self._new_attr_address(addr, 'L', 'address of string')
    saddr += 2
    # Execute. B gets the address of the CPL I/O buffers, which we can't really
    # know, so just use 0.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return saddr - addr

  # SVC 31 (WN - CPL formatted write without CR)
  def _svc31(self, addr: int, need_attrs: bool) -> int:
    # Address of FCB.
    if need_attrs:
      self._new_attr_address(addr, 'L', 'address of FCB')
    saddr = addr + 2
    # Address of format.
    if need_attrs:
      self._new_attr_address(saddr, 'L', 'address of format')
    saddr += 2
    # Address of each variable argument. When the word is 0, it's the end of
    # argument list.
    while saddr < len(self._relocated) - 2 and \
          (self._relocated[saddr] != 0 or self._relocated[saddr + 1] != 0):
      if need_attrs:
        self._new_attr_address(saddr, 'L', 'address of argument')
      saddr += 2
    # Null terminator.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [argument list terminator]'
    saddr += 2
    # Execute. B gets the address of the CPL I/O buffers, which we can't really
    # know, so just use 0.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return saddr - addr

  # SVC 32 (DC - CPL decode)
  def _svc32(self, addr: int, need_attrs: bool) -> int:
    # Address of FCB.
    if need_attrs:
      self._new_attr_address(addr, 'S', 'address of string')
    saddr = addr + 2
    # Address of format.
    if need_attrs:
      self._new_attr_address(saddr, 'L', 'address of format')
    saddr += 2
    # Address of each variable argument. When the word is 0, it's the end of
    # argument list.
    while saddr < len(self._relocated) - 2 and \
          (self._relocated[saddr] != 0 or self._relocated[saddr + 1] != 0):
      if need_attrs:
        self._new_attr_address(saddr, 'L', 'address of argument')
      saddr += 2
    # Null terminator.
    if need_attrs:
      attrs = self._new_attr_word(saddr)
      attrs.comment += ' [argument list terminator]'
    saddr += 2
    # Execute. B gets the address of the last argument.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', vm.get_mem_w(vm.get_pc() + saddr - addr - 4))
    return saddr - addr

  # SVC 33 (NC - CPL encode)
  def _svc33(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 34 (RF - CPL formatted read)
  def _svc34(self, addr: int, need_attrs: bool) -> int:
    # Same arguments as WN. The execution is similar too.
    return self._svc31(addr, need_attrs)

  # SVC 35 (WF - CPL formatted write)
  def _svc35(self, addr: int, need_attrs: bool) -> int:
    # Same arguments as WN. The execution is similar too.
    return self._svc31(addr, need_attrs)

  # SVC 36 (RT - CPL rewrite)
  def _svc36(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 37 (RB - CPL binary read)
  def _svc37(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Address of FCB.
      self._new_attr_address(addr, 'L', 'address of FCB')
      # Address of record.
      self._new_attr_address(addr + 2, 'L', 'address of record')
    # Execute. B gets the address of the CPL I/O buffers, which we can't really
    # know, so just use 0.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return 4

  # SVC 38 (WB - CPL binary write)
  def _svc38(self, addr: int, need_attrs: bool) -> int:
    # Same arguments as RB. Similar execution too.
    return self._svc37(addr, need_attrs)

  # SVC 39 (OP - CPL open)
  def _svc39(self, addr: int, need_attrs: bool) -> int:
    # Multiple files can be opened in one call.
    saddr = addr
    while saddr < len(self._relocated) - 1:
      # Open mode or terminator.
      mode = self._relocated[saddr]
      if mode == 0:
        break
      # Open mode byte.
      if need_attrs:
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [Mode: '
        if mode == 1:
          attrs.comment += 'input'
        elif mode == 2:
          attrs.comment += 'output'
        elif mode == 3:
          attrs.comment += 'input/output'
        else:
          attrs.comment += 'unknown'
        attrs.comment += ']'
      saddr += 1
      # Address of FCB.
      if need_attrs:
        self._new_attr_address(saddr, 'L', 'address of FCB')
      saddr += 2
    # Terminator Byte.
    if need_attrs:
      attrs = self._new_attr_byte(saddr)
      attrs.comment += ' [argument list terminator]'
    saddr += 1
    # Execute.
    vm = self._vm
    vm.set_reg_w('A', 0x0400)
    vm.set_reg_w('B', 0)
    return saddr - addr

  # SVC 3A (CT - CPL control function)
  def _svc3A(self, addr: int, need_attrs: bool) -> int:
    vm = self._vm
    # Selector byte.
    selector = self._relocated[addr]
    saddr = addr + 1
    if need_attrs:
      s_attrs = self._new_attr_byte(addr)
    # Handle each selector.
    if selector == 4:
      if need_attrs:
        s_attrs.comment += ' [Selector: rewind]'
        # Address of FCB.
        self._new_attr_address(saddr, 'L', 'address of FCB')
      saddr += 2
      # Execute. B gets the address of the CPL I/O buffers, which we can't
      # really know, so just use 0.
      vm.set_reg_w('A', 0x8100)
      vm.set_reg_w('B', 0)
    elif selector == 10:
      if need_attrs:
        s_attrs.comment += ' [Selector: close]'
        # Address of FCB.
        self._new_attr_address(saddr, 'L', 'address of FCB')
      saddr += 2
      # Execute. B gets the address of the CPL I/O buffers, which we can't
      # really know, so just use 0.
      vm.set_reg_w('A', 0x0200)
      vm.set_reg_w('B', 0)
    elif selector == 11:
      if need_attrs:
        s_attrs.comment += ' [Selector: endfile]'
        # Address of FCB.
        self._new_attr_address(saddr, 'L', 'address of FCB')
      saddr += 2
      # Execute. B gets the address of the CPL I/O buffers, which we can't
      # really know, so just use 0.
      vm.set_reg_w('A', 0x8300)
      vm.set_reg_w('B', 0)
    else:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    return saddr - addr

  # SVC 3B (LD48 - CPL 48-bit load)
  def _svc3B(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 3C (ST48 - CPL 48-bit store)
  def _svc3C(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 3D (AD48 - CPL 48-bit add)
  def _svc3D(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 3E (RS - CPL record skip) CPU5: SL64
  def _svc3E(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 3F (SU48 - CPL 48-bit subtract)
  def _svc3F(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 40 (TIOC - tape I/O) CPU5: NEG64
  def _svc40(self, addr: int, need_attrs: bool) -> int:
    if self._iscpu5:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 41 (MU48 - CPL 48-bit multiply)
  def _svc41(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 42 (DV48 - CPL 48-bit divide)
  def _svc42(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 43 (CN48 - CPL 48-bit numeric compare)
  def _svc43(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 44 (CG48 - CPL 48-bit computed goto)
  def _svc44(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 45 (LD64 - CPL 64-bit load)
  def _svc45(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 46 (ST64 - CPL 64-bit store)
  def _svc46(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 47 (AD64 - CPL 64-bit add)
  def _svc47(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 48 (SU64 - CPL 64-bit subtract)
  def _svc48(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 49 (MU64 - CPL 64-bit multiply)
  def _svc49(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 4A (DV64 - CPL 64-bit divide)
  def _svc4A(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 4B (TTIME - test time lock)
  def _svc4B(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 4C (DIO - disk I/O)
  def _svc4C(self, addr: int, need_attrs: bool) -> int:
    # Selector word.
    selector = int.from_bytes(self._relocated[addr:addr+2], 'big')
    saddr = addr + 2
    if need_attrs:
      s_attrs = self._new_attr_word(addr)
    # Handle each selector.
    if selector == 0x0000:
      if need_attrs:
        s_attrs.comment += ' [Selector: TODO]'
        # Word, 3 bytes, word.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg1]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg2]'
        saddr += 1
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg3]'
        saddr += 1
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg4]'
        saddr += 1
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg5]'
        saddr += 2
    elif selector == 0x0006:
      if need_attrs:
        s_attrs.comment += ' [Selector: TODO]'
        # Word, word, byte, word, word.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg1]'
        saddr += 2
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg2]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg3]'
        saddr += 1
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg4]'
        saddr += 2
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg5]'
        saddr += 2
    elif selector == 0x000A:
      if need_attrs:
        s_attrs.comment += ' [Selector: TODO]'
        # Word, word, byte, word.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg1]'
        saddr += 2
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg2]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg3]'
        saddr += 1
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg4]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg5]'
        saddr += 1
    elif selector == 0x0014:
      if need_attrs:
        s_attrs.comment += ' [Selector: TODO]'
        # Word, 3 bytes, word.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg1]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg2]'
        saddr += 1
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg3]'
        saddr += 1
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg4]'
        saddr += 1
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg5]'
        saddr += 2
    elif selector == 0x0190:
      if need_attrs:
        s_attrs.comment += ' [Selector: TODO]'
        # Word, word, byte, word, byte.
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg1]'
        saddr += 2
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg2]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg3]'
        saddr += 1
        attrs = self._new_attr_word(saddr)
        attrs.comment += ' [TODO: arg4]'
        saddr += 2
        attrs = self._new_attr_byte(saddr)
        attrs.comment += ' [TODO: arg5]'
        saddr += 1
    else:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    # Execute. Unknown.
    return saddr - addr

  # SVC 4D (SHLD - sector hold)
  def _svc4D(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 4E (SFRE - sector free)
  def _svc4E(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 4F (DIRL - search library directory)
  def _svc4F(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 50 (DIRE - locate directory entry specified)
  def _svc50(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg 1]'
    # Execute. Sets A to 0 on error probably.
    vm = self._vm
    vm.set_reg_w('A', 1)
    return 2

  # SVC 51 (DIRD - set date of file or subfile)
  def _svc51(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word, word, word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg 1]'
      attrs = self._new_attr_word(addr + 2)
      attrs.comment += ' [TODO: arg 2]'
      attrs = self._new_attr_word(addr + 4)
      attrs.comment += ' [TODO: arg 3]'
    # Execute. Copies first arg to A.
    vm = self._vm
    vm.set_reg_w('A', vm.get_mem_w(vm.get_pc()))
    return 6

  # SVC 52 (GIOB - unprotected GIOB)
  def _svc52(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Byte, byte, byte.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [TODO: arg1]'
      attrs = self._new_attr_byte(addr + 1)
      attrs.comment += ' [TODO: arg2]'
      attrs = self._new_attr_byte(addr + 2)
      attrs.comment += ' [TODO: arg3]'
      # Address of something.
      self._new_attr_address(addr + 3, 'L', 'TODO: address')
    # Execute.
    vm = self._vm
    vmaddr = vm.get_pc()
    if vm.get_mem_b(vmaddr) == 0x01 and vm.get_mem_b(vmaddr + 1) == 0x02 and \
       vm.get_mem_b(vmaddr + 2) == 0x02:
      # Get max sector. Simulate one sector.
      vm.set_mem_w(vm.get_mem_w(vmaddr + 3), 0x0001)
    elif vm.get_mem_b(vmaddr) == 0x01 and vm.get_mem_b(vmaddr + 1) == 0x15 and \
         vm.get_mem_b(vmaddr + 2) == 0x09:
      # Get filename. Writes the name to the destination address. Simulate the
      # name 'AB'.
      vm.set_mem_w(vm.get_mem_w(vmaddr + 3), ascii_w('AB'))
    else:
      # Don't know what to do.
      pass
    return 5

  # SVC 53 (FMD - hard disk format)
  def _svc53(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 54 (DRNMB - directory search)
  def _svc54(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 55 (DIOSX - execute disk command string)
  def _svc55(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Command string address word.
      self._new_attr_address(addr, 'W', 'address of command string')
    # Execute. Nothing to do.
    return 2

  # SVC 56 (FSVC - fake SVC call)
  def _svc56(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 57 (LODTX - load TX module)
  def _svc57(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 58 (BUG - bug)
  def _svc58(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 59 (ASEG - add next free mem segment to CURTB [wait for comp])
  def _svc59(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute.
    vm = self._vm
    vm.set_reg_w('A', 0)
    vm.set_reg_w('B', 0)
    return 0

  # SVC 5A (RSEG - release memory segment specified in AL)
  def _svc5A(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Nothing to do.
    return 0

  # SVC 5B (LODNMT - load name into transient area)
  def _svc5B(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 5C (GBKV - get OS block value)
  def _svc5C(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Three bytes.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [TODO: arg1]'
      attrs = self._new_attr_byte(addr + 1)
      attrs.comment += ' [TODO: arg2]'
      attrs = self._new_attr_byte(addr + 2)
      attrs.comment += ' [TODO: arg3]'
      # Address of destination.
      self._new_attr_address(addr + 3, 'W', 'address to store block value')
    # Execute.
    vm = self._vm
    vmaddr = vm.get_pc()
    if vm.get_mem_b(vmaddr) == 0x00 and vm.get_mem_b(vmaddr + 1) == 0x01 and \
       vm.get_mem_b(vmaddr + 2) == 0x15:
      # Get UPSI. Writes the UPSI value to the destination address, sets A to 0.
      # Simulate UPSI = 0.
      vm.set_mem_b(vm.get_mem_w(vmaddr + 3), 0)
      vm.set_reg_w('A', 0)
    elif vm.get_mem_b(vmaddr) == 0x01 and vm.get_mem_b(vmaddr + 1) == 0x01 and \
         vm.get_mem_b(vmaddr + 2) == 0x01:
      # Get FCB type. Writes the type to the destination address, sets A to
      # 0. Simulate the type as 2 which is probably device. Another option
      # looks like 4 for a file.
      vm.set_mem_b(vm.get_mem_w(vmaddr + 3), 2)
      vm.set_reg_w('A', 0)
    else:
      # Do the same as UPSI for unknown.
      vm.set_mem_b(vm.get_mem_w(vmaddr + 3), 0)
      vm.set_reg_w('A', 0)
    return 5

  # SVC 5D (PBKV - set OS block value)
  def _svc5D(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
      # Byte.
      attrs = self._new_attr_byte(addr + 2)
      attrs.comment += ' [TODO: arg2]'
      # Address of destination.
      self._new_attr_address(addr + 3, 'W', 'address to read block value')
    # Execute.
    vm = self._vm
    vmaddr = vm.get_pc()
    if vm.get_mem_w(vmaddr) == 0x0101 and vm.get_mem_b(vmaddr + 2) == 0x19:
      # Set MUX control byte. Sets B to the address read from.
      vm.set_reg_w('B', vm.get_mem_w(vmaddr + 3))
    elif vm.get_mem_w(vmaddr) == 0x0002 and vm.get_mem_b(vmaddr + 2) == 0x19:
      # Set CPL formatted I/O info/buffer area. Sets A to 1 and B to the address
      # provided.
      vm.set_reg_w('A', 1)
      vm.set_reg_w('B', vm.get_mem_w(vmaddr + 3))
    else:
      raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))
    return 5

  # SVC 5E (ASEGR - add next free mem seg to CURTB [ret if not avail])
  def _svc5E(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 5F (GPRM - get general parameter)
  def _svc5F(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Byte.
      attrs = self._new_attr_byte(addr)
      attrs.comment += ' [TODO: arg1]'
      # Word.
      attrs = self._new_attr_word(addr + 1)
      attrs.comment += ' [TODO: arg2]'
    # Execute. Unknown.
    return 3

  # SVC 60 (PPRM - set general parameter)
  def _svc60(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 61 (CCC - security code check)
  def _svc61(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 62 (LODFR - load FCB from .RUN)
  def _svc62(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 63 (RSEGX - release other part memory)
  def _svc63(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Nothing to do.
    return 0

  # SVC 64 (DIRLF - create FCB for file in private library)
  def _svc64(self, addr: int, need_attrs: bool) -> int:
    if need_attrs:
      # Word.
      attrs = self._new_attr_word(addr)
      attrs.comment += ' [TODO: arg1]'
      # Word.
      attrs = self._new_attr_word(addr + 2)
      attrs.comment += ' [TODO: arg2]'
    # Execute. Unknown.
    return 4

  # SVC 65 (DIRSZ - access size of file in private library)
  def _svc65(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 66 (EOM - check for EOF/EOM)
  def _svc66(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 67 (GVOL - get volume name)
  def _svc67(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 68 (RLSR - return from LSR)
  def _svc68(self, addr: int, need_attrs: bool) -> int:
    # No data.
    # Execute. Unknown.
    return 0

  # SVC 69 (ISRM - connect/disconnect ISR from PUB)
  def _svc69(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 6A (BASIC - enter BASIC monitor for current partition)
  def _svc6A(self, addr: int, need_attrs: bool) -> int:
    # The rest of the file is data. Does not return.
    return -1

  # SVC 6B (ABRTR - abort with abort code in AL)
  def _svc6B(self, addr: int, need_attrs: bool) -> int:
    # No data. Does not return.
    return -1

  # SVC 6C (EXITR - exit with CC in AL)
  def _svc6C(self, addr: int, need_attrs: bool) -> int:
    # No data. Does not return.
    return -1

  # SVC 6D (LODCOB - COBOL overlay load)
  def _svc6D(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 6E (COBOL - COBOL call)
  def _svc6E(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # SVC 6F (RCOB - COBOL return)
  def _svc6F(self, addr: int, need_attrs: bool) -> int:
    raise ValueError("{0} at 0x{1:04X}".format(
      inspect.currentframe().f_code.co_name, addr + self._baseaddr))

  # Opcode handler dispatch.
  _ophandlers = [
    _op00, _op01, _op02, _op03, _op04, _op05, _op06, _op07,
    _op08, _op09, _op0A, _op0B, _op0C, _op0D, _op0E, _op0F,
    _op10, _op11, _op12, _op13, _op14, _op15, _op16, _op17,
    _op18, _op19, _op1A, _op1B, _op1C, _op1D, _op1E, _op1F,
    _op20, _op21, _op22, _op23, _op24, _op25, _op26, _op27,
    _op28, _op29, _op2A, _op2B, _op2C, _op2D, _op2E, _op2F,
    _op30, _op31, _op32, _op33, _op34, _op35, _op36, _op37,
    _op38, _op39, _op3A, _op3B, _op3C, _op3D, _op3E, _op3F,
    _op40, _op41, _op42, _op43, _op44, _op45, _op46, _op47,
    _op48, _op49, _op4A, _op4B, _op4C, _op4D, _op4E, _op4F,
    _op50, _op51, _op52, _op53, _op54, _op55, _op56, _op57,
    _op58, _op59, _op5A, _op5B, _op5C, _op5D, _op5E, _op5F,
    _op60, _op61, _op62, _op63, _op64, _op65, _op66, _op67,
    _op68, _op69, _op6A, _op6B, _op6C, _op6D, _op6E, _op6F,
    _op70, _op71, _op72, _op73, _op74, _op75, _op76, _op77,
    _op78, _op79, _op7A, _op7B, _op7C, _op7D, _op7E, _op7F,
    _op80, _op81, _op82, _op83, _op84, _op85, _op86, _op87,
    _op88, _op89, _op8A, _op8B, _op8C, _op8D, _op8E, _op8F,
    _op90, _op91, _op92, _op93, _op94, _op95, _op96, _op97,
    _op98, _op99, _op9A, _op9B, _op9C, _op9D, _op9E, _op9F,
    _opA0, _opA1, _opA2, _opA3, _opA4, _opA5, _opA6, _opA7,
    _opA8, _opA9, _opAA, _opAB, _opAC, _opAD, _opAE, _opAF,
    _opB0, _opB1, _opB2, _opB3, _opB4, _opB5, _opB6, _opB7,
    _opB8, _opB9, _opBA, _opBB, _opBC, _opBD, _opBE, _opBF,
    _opC0, _opC1, _opC2, _opC3, _opC4, _opC5, _opC6, _opC7,
    _opC8, _opC9, _opCA, _opCB, _opCC, _opCD, _opCE, _opCF,
    _opD0, _opD1, _opD2, _opD3, _opD4, _opD5, _opD6, _opD7,
    _opD8, _opD9, _opDA, _opDB, _opDC, _opDD, _opDE, _opDF,
    _opE0, _opE1, _opE2, _opE3, _opE4, _opE5, _opE6, _opE7,
    _opE8, _opE9, _opEA, _opEB, _opEC, _opED, _opEE, _opEF,
    _opF0, _opF1, _opF2, _opF3, _opF4, _opF5, _opF6, _opF7,
    _opF8, _opF9, _opFA, _opFB, _opFC, _opFD, _opFE, _opFF
  ]

  # Service dispatch.
  _svchandlers = [
    _svc00, _svc01, _svc02, _svc03, _svc04, _svc05, _svc06, _svc07,
    _svc08, _svc09, _svc0A, _svc0B, _svc0C, _svc0D, _svc0E, _svc0F,
    _svc10, _svc11, _svc12, _svc13, _svc14, _svc15, _svc16, _svc17,
    _svc18, _svc19, _svc1A, _svc1B, _svc1C, _svc1D, _svc1E, _svc1F,
    _svc20, _svc21, _svc22, _svc23, _svc24, _svc25, _svc26, _svc27,
    _svc28, _svc29, _svc2A, _svc2B, _svc2C, _svc2D, _svc2E, _svc2F,
    _svc30, _svc31, _svc32, _svc33, _svc34, _svc35, _svc36, _svc37,
    _svc38, _svc39, _svc3A, _svc3B, _svc3C, _svc3D, _svc3E, _svc3F,
    _svc40, _svc41, _svc42, _svc43, _svc44, _svc45, _svc46, _svc47,
    _svc48, _svc49, _svc4A, _svc4B, _svc4C, _svc4D, _svc4E, _svc4F,
    _svc50, _svc51, _svc52, _svc53, _svc54, _svc55, _svc56, _svc57,
    _svc58, _svc59, _svc5A, _svc5B, _svc5C, _svc5D, _svc5E, _svc5F,
    _svc60, _svc61, _svc62, _svc63, _svc64, _svc65, _svc66, _svc67,
    _svc68, _svc69, _svc6A, _svc6B, _svc6C, _svc6D, _svc6E, _svc6F
  ]

  # Service names.
  _svcnames = [
    'PIOC - physical i/o control',
    'TRTN - transient return',
    'LODNM - load file name specified',
    'LODF - load FCB specified',
    'LODJX - load JX module specified',
    'TS - load transient module',
    'FLWT - wait for flag to go positive',
    'WT - unconditional wait',
    'RBWT - wait for RCB to go ready',
    'ABRT - abort task',
    'EXIT - exit to OJX00',
    'DT - get binary date',
    'PGIOB - protected get I/O block',
    'JXM - protected change to JX map',
    'DIRNM - search directory for file name specified',
    'CONIO - console I/O',
    'SYSIO - device-independent logical I/O [all units]',
    'GMEMR - GMEM with A=addr B=size',
    'FLWTR - FLWT with flag address in AL',
    'RMEMR - RMEM with address in A',
    'DRDY - disk ready check',
    'GBR - get binary time into A and B registers',
    'GMEM - get memory block from transient area',
    'RMEM - release memory block back to transient area',
    'LIOC - logical I/O control',
    'EXP - file expand',
    'USER - change to user mode',
    'GB - get binary time',
    'GC - get character time',
    'STIME - set time lock',
    'LD - CPL 32-bit load',
    'ST - CPL 32-bit store',
    'AD - CPL 32-bit add',
    'TSR - TS with TX# in AU',
    'SU - CPL 32-bit subtract',
    'GDPUB - locate pub for disk specified in AL',
    'MU - CPL 32-bit multiply',
    'DV - CPL 32-bit divide',
    'CN - CPL 32-bit numeric compare',
    'CS - CPL string compare',
    'CG - CPL 32-bit computed goto',
    'MV - CPL 32-bit string move',
    'CP - CPL cursor position',
    'MUL16 - 16-bit multiply',
    'DIV16 - 16-bit divide',
    'CVD16 - 16-bit convert to decimal from memory',
    'CVR16 - 16-bit convert to decimal from A register',
    'CB - CPL cursor blanking',
    'CC - CPL cursor blanking with specified string',
    'WN - CPL formatted write without CR',
    'DC - CPL decode',
    'NC - CPL encode',
    'RF - CPL formatted read',
    'WF - CPL formatted write',
    'RT - CPL rewrite',
    'RB - CPL binary read',
    'WB - CPL binary write',
    'OP - CPL open',
    'CT - CPL control function',
    'LD48 - CPL 48-bit load',
    'ST48 - CPL 48-bit store',
    'AD48 - CPL 48-bit add',
    'RS - CPL record skip',
    'SU48 - CPL 48-bit subtract',
    'TIOC - tape I/O',
    'MU48 - CPL 48-bit multiply',
    'DV48 - CPL 48-bit divide',
    'CN48 - CPL 48-bit numeric compare',
    'CG48 - CPL 48-bit computed goto',
    'LD64 - CPL 64-bit load',
    'ST64 - CPL 64-bit store',
    'AD64 - CPL 64-bit add',
    'SU64 - CPL 64-bit subtract',
    'MU64 - CPL 64-bit multiply',
    'DV64 - CPL 64-bit divide',
    'TTIME - test time lock',
    'DIO - disk I/O',
    'SHLD - sector hold',
    'SFRE - sector free',
    'DIRL - search library directory',
    'DIRE - locate directory entry specified',
    'DIRD - set date of file or subfile',
    'GIOB - unprotected GIOB',
    'FMD - hard disk format',
    'DRNMB - directory search',
    'DIOSX - execute disk command string',
    'FSVC - fake SVC call',
    'LODTX - load TX module',
    'BUG - bug',
    'ASEG - add next free mem segment to CURTB [wait for comp]',
    'RSEG - release memory segment specified in AL',
    'LODNMT - load name into transient area',
    'GBKV - get OS block value',
    'PBKV - set OS block value',
    'ASEGR - add next free mem seg to CURTB [ret if not avail]',
    'GPRM - get general parameter',
    'PPRM - set general parameter',
    'CCC - security code check',
    'LODFR - load FCB from .RUN',
    'RSEGX - release other part memory',
    'DIRLF - create FCB for file in private library',
    'DIRSZ - access size of file in private library',
    'EOM - check for EOF/EOM',
    'GVOL - get volume name',
    'RLSR - return from LSR',
    'ISRM - connect/disconnect ISR from PUB',
    'BASIC - enter BASIC monitor for current partition',
    'ABRTR - abort with abort code in AL',
    'EXITR - exit with CC in AL',
    'LODCOB - COBOL overlay load',
    'COBOL - COBOL call',
    'RCOB - COBOL return'
  ]
  _svcnames5 = [
    'PIOC - physical i/o control',
    'TRTN - transient return',
    'LODNM - load file name specified',
    'LODD - load specifying disk addr',
    'LODJX - load JX module specified',
    'TS - load transient module',
    'FLWT - wait for flag to go positive',
    'WT - unconditional wait',
    'RBWT - wait for RCB to go ready',
    'ABRT - abort task',
    'EXIT - exit to OJX00',
    'DT - get binary date',
    'GIOB - get I/O block',
    'DIRPD - search pri dir',
    'DIRNM - search directory for file name specified',
    'CONIO - console I/O',
    'SYSIO - device-independent logical I/O [all units]',
    'DIO - disk I/O call',
    'SHLD - disk sector hold',
    'SFRE - disk sector free',
    'DRDY - disk ready check',
    'DIOL - disk I/O with length spec.',
    'GMEM - get memory block from transient area',
    'RMEM - release memory block back to transient area',
    'LIOC - logical I/O control',
    'EXP - file expand',
    'undefined',
    'GB - get binary time',
    'GC - get character time',
    'undefined',
    'LD - CPL 32-bit load',
    'ST - CPL 32-bit store',
    'AD - CPL 32-bit add',
    'DIOLF - DIO with return on error',
    'SU - CPL 32-bit subtract',
    'GDPUB - locate pub for disk specified in AL',
    'MU - CPL 32-bit multiply',
    'DV - CPL 32-bit divide',
    'CN - CPL 32-bit numeric compare',
    'CS - CPL string compare',
    'CG - CPL 32-bit computed goto',
    'MV - CPL 32-bit string move',
    'CP - CPL cursor position',
    'MUL16 - 16-bit multiply',
    'DIV16 - 16-bit divide',
    'CVD16 - 16-bit convert to decimal from memory',
    'CVR16 - 16-bit convert to decimal from A register',
    'CB - CPL cursor blanking',
    'CC - CPL cursor blanking with specified string',
    'WN - CPL formatted write without CR',
    'DC - CPL decode',
    'NC - CPL encode',
    'RF - CPL formatted read',
    'WF - CPL formatted write',
    'RT - CPL rewrite',
    'RB - CPL binary read',
    'WB - CPL binary write',
    'OP - CPL open',
    'CT - CPL control function',
    'LD48 - CPL 48-bit load',
    'ST48 - CPL 48-bit store',
    'AD48 - CPL 48-bit add',
    'SL64 - CPL 64-bit left shift',
    'SU48 - CPL 48-bit subtract',
    'NEG64 - CPL 64-bit negate',
    'MU48 - CPL 48-bit multiply',
    'DV48 - CPL 48-bit divide',
    'CN48 - CPL 48-bit numeric compare',
    'CG48 - CPL 48-bit computed goto',
    'LD64 - CPL 64-bit load',
    'ST64 - CPL 64-bit store',
    'AD64 - CPL 64-bit add',
    'SU64 - CPL 64-bit subtract',
    'MU64 - CPL 64-bit multiply',
    'DV64 - CPL 64-bit divide'
  ]

# Main entry.
if __name__ == "__main__":
  sys.exit(main())

