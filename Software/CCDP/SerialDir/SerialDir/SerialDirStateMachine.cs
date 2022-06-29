using System;
using System.Collections.Generic;
using System.IO;

namespace SerialDir.SerialDir {
    public class SerialDirStateMachine {
        
        // CRC polynomial for CRC-8-Bluetooth implementation
        private const int PolyMask = 0b110100111;
        
        // File path
        private const string FilePath = "Files\\";

        private enum State {
            WaitCommand,
            GetBlockHigh,
            GetBlockLow,
            ReadData,
            ReadCheck
        }

        private State _state;
        private int _command;
        private int _crc;
        private int _block;
        private int _bytesToRead;
        private int _bufferIndex;
        private byte[] _buffer;
        private string _fileName;
        private bool _fileOpen;

        private List<byte> _fileBuffer;

        public SerialDirStateMachine() {
            
            // Set up file open state 
            _fileName = "";
            _fileOpen = false;
            
            // Set up some other stuff too
            _buffer = new byte[0];
            _fileBuffer = new List<byte>();
            
            // Reset
            Reset();
        }

        public List<byte> ReceiveByte(byte b) {

            List<byte> response = new List<byte>();

            if (_state == State.WaitCommand) {
                
                // Start the CRC
                ResetCyclicCheck();
                UpdateCyclicCheck(b);
                
                // Set the command
                _command = b;
                
                if (b == 1) {
                    // [B]ootstrap
                    byte[] bootloader = new byte[256];
                    for (int i = 0; i < 256; i++) bootloader[i] = 0;

                    try {
                        byte[] bytes = File.ReadAllBytes(Path.Combine(FilePath, "BOOT.BIN"));

                        for (int i = 0; i < 256; i++) if (i < bytes.Length) bootloader[i] = bytes[i];
                        
                        Console.Write("B");
                    } catch (Exception) {
                        Console.WriteLine("Cannot load bootstrap!");
                    }

                    foreach (byte by in bootloader) response.Add(by);

                } else if (b >= 2 && b <= 8) {
                    _state = State.GetBlockHigh;
                }
            } 
            
            else if (_state == State.GetBlockHigh) {
                UpdateCyclicCheck(b);
                
                // Shift byte and set it to block
                _block = b << 8;
                _state = State.GetBlockLow;
            }
            
            else if (_state == State.GetBlockLow) {
                UpdateCyclicCheck(b);
                
                // Add byte to block #
                _block |= b;
                
                // Decide where to go next depending on command
                if (_command == 2 || _command == 4 || _command == 5) {
                    _state = State.ReadData;
                    _bytesToRead = 16;
                } else if (_command == 8) {
                    _state = State.ReadData;
                    _bytesToRead = 256;
                } else {
                    _state = State.ReadCheck;
                }

                _bufferIndex = 0;

            } 
            
            else if (_state == State.ReadData) {
                UpdateCyclicCheck(b);

                // Write to buffer
                _buffer[_bufferIndex++] = b;
                _bytesToRead--;

                // If there are no more bytes to read, go on to crc check
                if (_bytesToRead <= 0) _state = State.ReadCheck;
            } 
            
            else if (_state == State.ReadCheck) {
                // Check and see if there is an error
                if (b != _crc) {
                    Console.WriteLine("CRC Failure, Got: " + b + " expected " + _crc);
                    
                    // Error condition
                    ResetCyclicCheck();

                    AddAndCheck(response, 0xFF);
                    AddAndCheck(response, Convert.ToByte(_crc));
                } else {
                    
                    ResetCyclicCheck();
                    
                    if (_command == 2) {
                        // [O]pen
                        string fname = ExtractFilename();
                        bool hasOpened = false;
                        
                        CloseFile();


                        if (OpenFile(fname)) { 
                            hasOpened = true;
                            Console.Write("O");
                        } else {
                            Console.Write("X");
                        }

                        // Return condition
                        AddAndCheck(response, Convert.ToByte(hasOpened ? 0x00 : 0xFE));
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 3) {
                        // [C]lose
                        Console.Write("C");
                        
                        CloseFile();
                        
                        // Return condition
                        AddAndCheck(response, 0x00);
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 4) {
                        // [M]ake
                        string fname = ExtractFilename();
                        bool hasOpened = false;

                        try {
                            File.Create(Path.Combine(FilePath, fname)).Close();
                            hasOpened = true;
                            Console.Write("M");
                        } catch (Exception) {
                            Console.Write("?");
                        }

                        // Return condition
                        AddAndCheck(response, Convert.ToByte(hasOpened ? 0x00 : 0xFE));
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 5) {
                        // [D]elete
                        string fname = ExtractFilename();
                        bool hasDeleted = false;

                        try {
                            File.Delete(Path.Combine(FilePath, fname));
                            hasDeleted = true;
                            Console.Write("D");
                        } catch (Exception) {
                            Console.Write("?");
                        }
                        
                        // Return condition
                        AddAndCheck(response, Convert.ToByte(hasDeleted ? 0x00 : 0xFE));
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 6) {
                        // [L]ist
                        string[] files;
                        try {
                            files= Directory.GetFiles(FilePath);
                        } catch (Exception) {
                            files = new string[0];
                        }

                        String file = "";
                        if (_block < files.Length) {
                            file = Path.GetFileName(files[_block])?.ToUpper();
                        }

                        Console.Write("L");
                        
                        AddAndCheck(response, 1);
                        
                        // Send file name
                        for (int i = 0; i < 13; i++) {
                            char c = '\0';

                            char[] filename = file.ToCharArray();

                            if (i < filename.Length) c = filename[i];
                            
                            AddAndCheck(response, Convert.ToByte(c));
                        }
                        
                        AddAndCheck(response, 0x00);

                        // Get file stats
                        try {
                            FileInfo info = new FileInfo(Path.Combine(FilePath, file));

                            int len;
                            if (info.Length > 16777215) {
                                len = 0;
                            } else {
                                len = Convert.ToInt32((info.Length / 256) + ((info.Length % 256 > 0) ? 1 : 0));
                            }
                            
                            AddAndCheck(response, Convert.ToByte((len >> 8) & 0xFF));
                            AddAndCheck(response,Convert.ToByte(len & 0xFF));
                        } catch (Exception) {
                            AddAndCheck(response,0x00);
                            AddAndCheck(response,0x00);
                        }
                        // Send CRC
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 7) {
                        // [R]ead Command
                        if (_fileOpen && _fileBuffer.Count / 256 > _block) {
                            // Indicate return of 256 bytes
                            AddAndCheck(response, 2);
                            
                            Console.Write(".");
                            
                            // Return those 256 bytes
                            for (int i = 0; i < 256; i++) {
                                AddAndCheck(response, _fileBuffer[i + (256 * _block)]);
                            }

                        } else {
                            // Return error
                            AddAndCheck(response, 0xFE);
                            Console.Write("E");
                        }
                        
                        AddAndCheck(response, Convert.ToByte(_crc));
                    } else if (_command == 8) {
                        // [W]rite

                        if (_fileOpen) {
                            // Indicate return of 0 bytes
                            AddAndCheck(response, 0x00);
                            
                            Console.Write("'");

                            for (int i = 0; i < 256; i++) {
                                int addr = (_block * 256) + i;

                                // Pad zeros if address is too big
                                while (addr >= _fileBuffer.Count) _fileBuffer.Add(0x00);

                                _fileBuffer[addr] = _buffer[i];
                            }
                        } else {
                            // Return error
                            AddAndCheck(response, 0xFE);
                            
                            Console.Write("E");
                        }
                        
                        AddAndCheck(response, Convert.ToByte(_crc));
                    }

                }

                // Go back to waiting for a command
                _state = State.WaitCommand;
            }

            return response;
        }

        /**
         * Closes a file, and writes the buffer back into the file
         */
        private void CloseFile() {
            if (_fileOpen) {
                _fileOpen = false;
                try {
                    BinaryWriter writer = new BinaryWriter(File.OpenWrite(Path.Combine(FilePath, _fileName)));
                    writer.Write(_fileBuffer.ToArray());
                    writer.Close();
                } catch (Exception) {
                    Console.WriteLine("Failed to write back file!");
                }
            }
            _fileName = "";


        }

        /**
         * Opens and buffers a file for use
         */
        private bool OpenFile(string fname) {
            CloseFile();

            try {
                byte[] bytes = File.ReadAllBytes(Path.Combine(FilePath, fname));

                // Buffer the file
                _fileBuffer = new List<byte>();
                foreach (byte b in bytes) {
                    _fileBuffer.Add(b);
                }
                
                // Pad with zeros
                while (_fileBuffer.Count % 256 != 0) _fileBuffer.Add(0x00);
            } catch (Exception) {
                return false;
            }
            
            _fileName = fname;
            _fileOpen = true;

            return true;
        }

        /**
         * Reset the state machine to the command state
         */
        public void Reset() {
            _state = State.WaitCommand;
            
            _command = 0;
            _block = 0;
            _bytesToRead = 0;
            _bufferIndex = 0;
            _buffer = new byte[256];

            _fileBuffer = new List<byte>();
            
            CloseFile();
            ResetCyclicCheck();
        }

        /**
         * Reset the CRC calculator
         */
        private void ResetCyclicCheck() {
            _crc = 251;
        }


        /**
         * Extracts a filename from the buffer
         */
        public string ExtractFilename() {
            String name = "";

            for (int i = 0; i < 13 && _buffer[i] != 0; i++) {
                name = name + System.Text.Encoding.ASCII.GetString(new[]{_buffer[i]});
            }

            return name.ToUpper();
        }

        /**
         * Adds to a list, and updates the CRC
         */
        public void AddAndCheck(List<byte> l, byte b) {
            l.Add(b);
            UpdateCyclicCheck(b);
        }

        /**
         * Generates a CRC value based on an incoming message
         * Lowest index is assumed to be the first byte received
         */
        public void UpdateCyclicCheck(byte b) {

            // Create a copy of this byte for usage
            int by = b;

            for (int i = 0; i < 8; i++) {
                // Get the highest bit the the byte
                int last = by & 0x80;
                if (last != 0) last = 1;
                
                // Shift the current byte up
                by = by << 1;

                // Shift it onto the CRC
                _crc = (_crc << 1) | last;

                // Check bit 9 to see if it is on, if so invert CRC bits
                if ((_crc & 0x100) != 0) {
                    // XOR polynomial mask onto CRC
                    
                    _crc ^= PolyMask;
                }
            }

            // Just in case, slice up the CRC
            _crc = _crc & 0xFF;
        }


    }
}