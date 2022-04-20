using System;
using JetBrains.Annotations;

namespace CPU7Plus.Emulation {
    public class EmulationContext {

        private const int MemoryLength = 262144;
        
        private byte[] _core;
        private MemoryMappedAdapter _adapter;

        public EmulationContext(MemoryMappedAdapter adapter) {
            // Allocate 256k bytes of memory
            _core = new byte[MemoryLength];
            
            // Set the memory to 0
            for (int i = 0; i < MemoryLength; i++) _core[i] = 0;

            Reset();
            
            // Set up the adapter
            _adapter = adapter;
        }

        public void Reset() {
            // Set interrupt level to 0
            Level = 0;
            
            // Set PC to FC00
            Pc = 0xFC00;
            
            // Reset all flags
            FlagI = false;
            FlagF = false;
            FlagL = false;
            FlagM = false;
            FlagO = false;
            FlagC = false;
            FlagZ = false;
        }

        /**
         * returns an 8 bit register
         */
        public byte GetRegister8(int reg) {
            return _core[reg + (Level * 16)];
        }

        /**
         * returns a 16 bit register
         */
        public ushort GetRegister16(int reg) {
            return Convert.ToUInt16((_core[(reg*2) + (Level * 16)] << 8) | _core[(reg*2) + (Level * 16) + 1]);
        }

        /**
         * sets an 8 bit register
         */
        public void SetRegister8(int reg, byte value) {
            _core[reg + (Level * 16)] = value;
        }
        
        /*
         * sets a 16 bit register
         */
        public void SetRegister16(int reg, ushort value) {
            _core[(reg * 2) + (Level * 16)] = Convert.ToByte((value >> 8) & 0xFF);
            _core[(reg * 2) + (Level * 16) + 1] = Convert.ToByte(value & 0xFF);
        }

        /**
         * returns an 8 bit memory location
         */
        public byte Fetch8(int addr) {

            // 16-bit-ify
            addr = addr % 0xFFFF;
            
            return addr >= 0xF000 ? _adapter.ReadMapped(addr) : _core[addr];
        }

        /**
         * returns a 16 bit memory location
         */
        public ushort Fetch16(int addr, bool align) {
            // Resolve alignment issues
            if (align) addr = addr - (addr % 2);
            
            return Convert.ToUInt16((Fetch8(addr) << 8) | Fetch8(addr + 1));
        }

        /*
         * stores an 8 bit value into memory
         */
        public void Store8(int addr, byte value) {
            
            // 16-bit-ify
            addr = addr % 0xFFFF;

            if (addr >= 0xF000) {
                _adapter.WriteMapped(addr, value);
            } else _core[addr] = value;
        }

        /*
         * stores a 16 bit value into memory
         */
        public void Store16(int addr, ushort value, bool align) {
            // Resolve alignment issues
            if (align) addr = addr - (addr % 2);
            
            Store8(addr, Convert.ToByte((value >> 8) & 0xFF));
            Store8(addr + 1, Convert.ToByte(value & 0xFF));
        }

        /* getters and setters */
        
        [NotNull]
        public byte[] Core {
            get => _core;
            set => _core = value ?? throw new ArgumentNullException(nameof(value));
        }

        // CPU Status Information
        
        public ushort Pc { get; set; }

        public int Level { get; set; }
        
        public bool FlagI { get; set; }
        public bool FlagF { get; set; }
        public bool FlagL { get; set; }
        public bool FlagM { get; set; }
        public bool FlagO { get; set; }
        public bool FlagC { get; set; }
        public bool FlagZ { get; set; }
    }
}