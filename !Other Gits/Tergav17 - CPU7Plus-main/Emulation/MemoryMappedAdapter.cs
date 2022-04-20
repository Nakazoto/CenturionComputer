using System;
using System.IO;
using System.Linq;
using System.Reflection;
using CPU7Plus.Terminal;

namespace CPU7Plus.Emulation {
    public class MemoryMappedAdapter {
        
        private TerminalHandler _consoleTerminal;
        private byte[] _romContents;
        
        public MemoryMappedAdapter(TerminalHandler consoleTerminal) {
            _consoleTerminal = consoleTerminal;

            _romContents = new byte[512];

            // Grab the ROM resource
            byte[] romResource = ExtractResource("boot.rom");

            // Copy what we get into the romContents
            for (int i = 0; i < 512; i++) {
                if (i < romResource.Length) {
                    _romContents[i] = romResource[i];
                } else {
                    _romContents[i] = 0;
                }
            }
        }
        
        private static byte[] ExtractResource(string filename) {
            Assembly? asm = Assembly.GetEntryAssembly();
            if (asm == null) {
                Console.Write("Could not load assembly!\n");
                return new byte[0];
            }
            
            string resourceName = asm.GetManifestResourceNames().Single(n => n.EndsWith(filename));
            
            using (Stream? resFilestream = asm.GetManifestResourceStream(resourceName)) {
                if (resFilestream == null) {
                    Console.Write("Could not load resource!\n");
                    return new byte[0];
                }

                Console.Write("Loading " + resourceName + "\n");                
                
                byte[] ba = new byte[resFilestream.Length];
                resFilestream.Read(ba, 0, ba.Length);
                return ba;
            }
        }

        /**
         * Write to MMIO region
         */
        public void WriteMapped(int addr, byte b) {

            if (addr == 0xF201) {
                // Console terminal write
                _consoleTerminal.WriteByte(b);
            }

        }

        /**
         * Read from MMIO region
         */
        public byte ReadMapped(int addr) {

            if (addr == 0xF201) {
                // Console terminal read
                return _consoleTerminal.ReadByte();
            } 
            if (addr >= 0xFC00 && addr < 0xFE00) {
                // ROM read
                return _romContents[addr - 0xFC00];
            }

            return 0;
        }

    }
}