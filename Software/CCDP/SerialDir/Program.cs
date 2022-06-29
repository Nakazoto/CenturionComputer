using System;
using System.Collections.Generic;
using System.IO;
using System.IO.Ports;
using SerialDir.SerialDir;

namespace SerialDir {
    class Program {
        static void Main(string[] args) {
            Console.WriteLine("SerialDir V0.2.0");

            if (args.Length <= 1) {
                Console.WriteLine("Usage: SerialDir [Port] [Baudrate]");
                return;
            }


            int baudRate = 0;

            try {
                baudRate = Int32.Parse(args[1]);
            } catch (FormatException) {
                Console.WriteLine("Bad Baudrate Format!");
                return;
            }

            SerialDirStateMachine stateMachine = new SerialDirStateMachine();

            SerialPort serialPort = new SerialPort(args[0], baudRate, Parity.None, 8, StopBits.One);
            serialPort.Handshake = Handshake.None;
            serialPort.Encoding = System.Text.Encoding.GetEncoding("iso-8859-1");

            serialPort.WriteTimeout = 1000;

            try {
                serialPort.Open();
            } catch (Exception) {
                Console.WriteLine("Cannot Open Serial Port!");
                return;
            }

            Console.WriteLine("Opened " + args[0] + " At " + baudRate + " Baud");

            while (true) {
                int readChar = serialPort.ReadChar();
                
                byte b = Convert.ToByte(readChar);

                List<byte> response = stateMachine.ReceiveByte(b);
                
                if (response.Count > 0) {

                    serialPort.Write(response.ToArray(), 0, response.Count);
                }
            }
        }
    }
}
