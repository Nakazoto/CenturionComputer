using System;
using JetBrains.Annotations;

namespace CPU7Plus.Emulation {
    public class EmulationCore {

        private EmulationContext _context;
        
        public EmulationCore(EmulationContext context) {
            _context = context;
        }

        /**
         * Singles steps the processor
         */
        public void Step() {
            int pc = Context.Pc;

            byte isr = Context.Fetch8(pc);

            if ((isr & 0xF0) == 0x70) {
                // Jump/Call Class Instruction
                int destination = 0;

                // Get addressing mode
                int mode = isr & 0x07;

                switch (mode) {
                    case 0:
                        // Invalid mode, just skip it
                        destination = pc + 1;
                        break;
                    
                    case 1:
                        // Absolute addressing
                        destination = Context.Fetch16(pc + 1, false);
                        break;
                        
                    case 2:
                        // Indirect addressing
                        destination = Context.Fetch16(Context.Fetch16(pc + 1, false), true);
                        break;
                    
                    case 3:
                        // PC absolute addressing
                        destination = pc + ToSignedOffset(Context.Fetch8(pc + 1)) + 2;
                        break;
                    
                    case 4:
                        // PC indirect addressing
                        destination = Context.Fetch16(Context.Fetch16(Convert.ToUInt16(pc + ToSignedOffset(Context.Fetch8(pc + 1)) + 2), false), true);
                        break;
                    
                    case 5:
                        // Index addressing
                        destination = Context.Fetch16(GetIndexedAddr(pc), true);
                        break;
                    
                    default:
                        destination = Context.Pc + 1;
                        break;
                }



                Context.Pc = ToUShort(destination);
            }  else {
                // NOP / Unsupported
                Context.Pc = ToUShort(Context.Pc + 1); 
            }
        }

        /**
         * Does calculations for indexed operations
         */
        private ushort GetIndexedAddr(int pc) {

            // Index mode
            byte imode = Context.Fetch8(pc + 1);
            // Get register
            int reg = (imode % 0xF0) >> 1;

            int offset = 0;
            if ((imode & 0x07) == 0x01) {
                // Increment mode
                offset = Context.GetRegister16(reg);
                Context.SetRegister16(reg, ToUShort(offset + 2));
            } else if ((imode % 0x07) == 0x02) {
                // Decrement mode
                offset = Context.GetRegister16(reg) - 2;
                Context.SetRegister16(reg, ToUShort(offset));
            } else {
                // Neutral Mode
                offset = Context.GetRegister16(reg);
            }

            // Check for offset
            if ((imode % 0x08) == 0x08) {
                offset += ToSignedOffset(Context.Fetch8(pc + 2));
            }

            return Context.Fetch16(ToUShort(offset), true);
        }

        private ushort ToUShort(int i) {
            return Convert.ToUInt16(i & 0xFFFF);
        }

        /**
         * Converts an unsigned byte into a signed offset
         */
        private int ToSignedOffset(byte b) {
            if (b >= 128) return b - 256;
            return b;
        }

        [NotNull]
        public EmulationContext Context {
            get => _context;
            set => _context = value ?? throw new ArgumentNullException(nameof(value));
        }
    }
}