using System;
using CPU7Plus.Views;

namespace CPU7Plus.Emulation {
    public class ViewUpdater {

        /*
         * Synchronizes windows with emulator context
         */
        public static void UpdateView(EmulationContext context, MainWindow window) {
            
            
            // Update registers
            window.RegWInput.Text = context.GetRegister8(0).ToString("X2");
            window.RegXInput.Text = context.GetRegister8(1).ToString("X2");
            window.RegYInput.Text = context.GetRegister8(2).ToString("X2");
            window.RegZInput.Text = context.GetRegister8(3).ToString("X2");
            window.RegRInput.Text = context.GetRegister8(4).ToString("X2");
            window.RegTInput.Text = context.GetRegister8(5).ToString("X2");
            window.RegMInput.Text = context.GetRegister8(6).ToString("X2");
            window.RegNInput.Text = context.GetRegister8(7).ToString("X2");
            window.RegKInput.Text = context.GetRegister8(8).ToString("X2");
            window.RegLInput.Text = context.GetRegister8(9).ToString("X2");
            window.RegSInput.Text = context.GetRegister8(10).ToString("X2");
            window.RegPInput.Text = context.GetRegister8(11).ToString("X2");
            window.RegGInput.Text = context.GetRegister8(12).ToString("X2");
            window.RegHInput.Text = context.GetRegister8(13).ToString("X2");
            window.RegKInput.Text = context.GetRegister8(14).ToString("X2");
            window.RegJInput.Text = context.GetRegister8(15).ToString("X2");
            
            // Update combination registers
            window.RegWxInput.Text = context.GetRegister16(0).ToString("X4");
            window.RegYzInput.Text = context.GetRegister16(1).ToString("X4");
            window.RegRtInput.Text = context.GetRegister16(2).ToString("X4");
            window.RegMnInput.Text = context.GetRegister16(3).ToString("X4");
            window.RegKlInput.Text = context.GetRegister16(4).ToString("X4");
            window.RegSpInput.Text = context.GetRegister16(5).ToString("X4");
            window.RegGhInput.Text = context.GetRegister16(6).ToString("X4");
            window.RegIjInput.Text = context.GetRegister16(7).ToString("X4");
            
            // Update Status
            window.LevelInput.Text = context.Level.ToString("X1");
            window.RegPcInput.Text = context.Pc.ToString("X4");

            // Register File
            window.FileRow0.Text = ToByteString(context, 0x00);
            window.FileRow1.Text = ToByteString(context, 0x10);
            window.FileRow2.Text = ToByteString(context, 0x20);
            window.FileRow3.Text = ToByteString(context, 0x30);
            window.FileRow4.Text = ToByteString(context, 0x40);
            window.FileRow5.Text = ToByteString(context, 0x50);
            window.FileRow6.Text = ToByteString(context, 0x60);
            window.FileRow7.Text = ToByteString(context, 0x70);
            window.FileRow8.Text = ToByteString(context, 0x80);
            window.FileRow9.Text = ToByteString(context, 0x90);
            window.FileRow10.Text = ToByteString(context, 0xA0);
            window.FileRow11.Text = ToByteString(context, 0xB0);
            window.FileRow12.Text = ToByteString(context, 0xC0);
            window.FileRow13.Text = ToByteString(context, 0xD0);
            window.FileRow14.Text = ToByteString(context, 0xE0);
            window.FileRow15.Text = ToByteString(context, 0xF0);
        }

        /**
         * Takes the values in the text boxes, and tries to update the context registers
         *
         * Should only be ran by emulator thread
         */
        public static void UpdateContext(EmulationContext context, MainWindow window) {
            var ParseBy = System.Globalization.NumberStyles.HexNumber;
            
            // Register WX
            try {
                int valueHigh = int.Parse(window.RegWInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegXInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegWxInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(0) != valueHigh || context.GetRegister8(1) != valueLow) {
                    context.SetRegister8(0, Convert.ToByte(valueHigh));
                    context.SetRegister8(1, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(0, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register YZ
            try {
                int valueHigh = int.Parse(window.RegYInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegZInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegYzInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(2) != valueHigh || context.GetRegister8(3) != valueLow) {
                    context.SetRegister8(2, Convert.ToByte(valueHigh));
                    context.SetRegister8(3, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(1, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register RT
            try {
                int valueHigh = int.Parse(window.RegRInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegTInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegRtInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(4) != valueHigh || context.GetRegister8(5) != valueLow) {
                    context.SetRegister8(4, Convert.ToByte(valueHigh));
                    context.SetRegister8(5, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(2, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register MN
            try {
                int valueHigh = int.Parse(window.RegMInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegNInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegMnInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(6) != valueHigh || context.GetRegister8(7) != valueLow) {
                    context.SetRegister8(6, Convert.ToByte(valueHigh));
                    context.SetRegister8(7, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(3, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register MN
            try {
                int valueHigh = int.Parse(window.RegKInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegLInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegKlInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(8) != valueHigh || context.GetRegister8(9) != valueLow) {
                    context.SetRegister8(8, Convert.ToByte(valueHigh));
                    context.SetRegister8(9, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(4, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
                        
            // Register SP
            try {
                int valueHigh = int.Parse(window.RegSInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegPInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegSpInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(10) != valueHigh || context.GetRegister8(11) != valueLow) {
                    context.SetRegister8(10, Convert.ToByte(valueHigh));
                    context.SetRegister8(11, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(5, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register GH
            try {
                int valueHigh = int.Parse(window.RegGInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegHInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegGhInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(12) != valueHigh || context.GetRegister8(13) != valueLow) {
                    context.SetRegister8(12, Convert.ToByte(valueHigh));
                    context.SetRegister8(13, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(6, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register IJ
            try {
                int valueHigh = int.Parse(window.RegIInput.Text, ParseBy);
                int valueLow = int.Parse(window.RegJInput.Text, ParseBy);
                int valueAll = int.Parse(window.RegIjInput.Text, ParseBy);

                // Either write the individual registers or the combined register, but not both
                if (context.GetRegister8(14) != valueHigh || context.GetRegister8(15) != valueLow) {
                    context.SetRegister8(14, Convert.ToByte(valueHigh));
                    context.SetRegister8(15, Convert.ToByte(valueLow));
                } else {
                    context.SetRegister16(7, Convert.ToUInt16(valueAll));
                }
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register Level
            try {
                int value = int.Parse(window.LevelInput.Text, ParseBy);

                context.Level = value & 0x0F;
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
            
            // Register PC
            try {
                int value = int.Parse(window.RegPcInput.Text, ParseBy);

                context.Pc = Convert.ToUInt16(value);
            }
            catch (FormatException) {
                Console.Write("Bad Format Written To Register!\n");
            }
        }

        /**
         * Disables all inputs
         */
        public static void DisableInputs(MainWindow window) {
            window.RegWInput.IsEnabled = false;
            window.RegXInput.IsEnabled = false;
            window.RegYInput.IsEnabled = false;
            window.RegZInput.IsEnabled = false;
            window.RegRInput.IsEnabled = false;
            window.RegTInput.IsEnabled = false;
            window.RegMInput.IsEnabled = false;
            window.RegNInput.IsEnabled = false;
            window.RegKInput.IsEnabled = false;
            window.RegLInput.IsEnabled = false;
            window.RegSInput.IsEnabled = false;
            window.RegPInput.IsEnabled = false;
            window.RegGInput.IsEnabled = false;
            window.RegHInput.IsEnabled = false;
            window.RegIInput.IsEnabled = false;
            window.RegJInput.IsEnabled = false;

            window.RegWxInput.IsEnabled = false;
            window.RegYzInput.IsEnabled = false;
            window.RegRtInput.IsEnabled = false;
            window.RegMnInput.IsEnabled = false;
            window.RegKlInput.IsEnabled = false;
            window.RegSpInput.IsEnabled = false;
            window.RegGhInput.IsEnabled = false;
            window.RegIjInput.IsEnabled = false;

            window.LevelInput.IsEnabled = false;
            window.RegPcInput.IsEnabled = false;

            window.FlagC.IsEnabled = false;
            window.FlagF.IsEnabled = false;
            window.FlagI.IsEnabled = false;
            window.FlagL.IsEnabled = false;
            window.FlagM.IsEnabled = false;
            window.FlagO.IsEnabled = false;
            window.FlagZ.IsEnabled = false;
        }
        
        /**
         * Enables all inputs
         */
        public static void EnableInputs(MainWindow window) {
            window.RegWInput.IsEnabled = true;
            window.RegXInput.IsEnabled = true;
            window.RegYInput.IsEnabled = true;
            window.RegZInput.IsEnabled = true;
            window.RegRInput.IsEnabled = true;
            window.RegTInput.IsEnabled = true;
            window.RegMInput.IsEnabled = true;
            window.RegNInput.IsEnabled = true;
            window.RegKInput.IsEnabled = true;
            window.RegLInput.IsEnabled = true;
            window.RegSInput.IsEnabled = true;
            window.RegPInput.IsEnabled = true;
            window.RegGInput.IsEnabled = true;
            window.RegHInput.IsEnabled = true;
            window.RegIInput.IsEnabled = true;
            window.RegJInput.IsEnabled = true;
            
            window.RegWxInput.IsEnabled = true;
            window.RegYzInput.IsEnabled = true;
            window.RegRtInput.IsEnabled = true;
            window.RegMnInput.IsEnabled = true;
            window.RegKlInput.IsEnabled = true;
            window.RegSpInput.IsEnabled = true;
            window.RegGhInput.IsEnabled = true;
            window.RegIjInput.IsEnabled = true;

            window.LevelInput.IsEnabled = true;
            window.RegPcInput.IsEnabled = true;

            window.FlagC.IsEnabled = true;
            window.FlagF.IsEnabled = true;
            window.FlagI.IsEnabled = true;
            window.FlagL.IsEnabled = true;
            window.FlagM.IsEnabled = true;
            window.FlagO.IsEnabled = true;
            window.FlagZ.IsEnabled = true;
        }

        private static string ToByteString(EmulationContext context, int start) {
            string output = start.ToString("X2") + ": " ;

            for (int i = 0; i < 16; i++) {
                output = output + context.Fetch8(start).ToString("X2");
                start++;
            }

            return output;
        }

    }
}