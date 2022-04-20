using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Input;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using CPU7Plus.Emulation;
using JetBrains.Annotations;

namespace CPU7Plus.Views {
    public partial class MemoryViewer : Window {

        private volatile bool _canClose;

        private EmulationContext? _context;
        private EmulationHandler? _handler;

        private int _block;
        private int _page;

        public MemoryViewer() {

            InitializeComponent();

#if DEBUG
            this.AttachDevTools();
#endif


            // Setup some flags and values
            _canClose = false;
            _block = 0;
            _page = 0;

            // Make closing simply hide the window
            this.Closing += (s, e) => {
                if (!_canClose) {
                    e.Cancel = true;
                    this.Hide();
                }
            };

            // Manual init of all controls because Avalonia does not feel like doing it for us
            MemoryInput = this.FindControl<TextBox>("MemoryInput");
            BlockInput = this.FindControl<TextBox>("BlockInput");
            PageInput = this.FindControl<TextBox>("PageInput");
            
        }

        private void InitializeComponent() {
            AvaloniaXamlLoader.Load(this);

        }
        
        /**
         * Permits the window to be closed
         */
        public void AllowClose() {
            _canClose = true;
        }
        
        /**
         * Keys down event, processes a memory edit command
         */
        public void OnKeyDown(object sender, KeyEventArgs e) {

            int line = MemoryInput.CaretIndex / 77;

            int x = MemoryInput.CaretIndex - (line * 77);
            int column = 0;

            // Column calculation
            if (x <= 8) {
                column = 0;
            } else if (x >= 55) {
                column = 32;
            } else {
                int xBytes = x - 7;
                int block = xBytes / 3;

                column = block * 2 + ((xBytes % 3 == 2) ? 1 : 0);

            }

            // Next line logic
            if (column == 32) {
                if (line == 255) {
                    e.Handled = true;
                    return;
                } else {
                    column = 0;
                    line++;
                }
            }

            // If nothing return
            if (e.Key.ToString().Length == 0) {
                e.Handled = true;
                return;
            }

            // Get the char
            int inputChar = e.Key.GetHashCode();
            int nybble = -1;

            if (inputChar >= 34 && inputChar <= 43) {
                nybble = inputChar - 34;
            }

            if (inputChar >= 44 && inputChar <= 49) {
                nybble = (inputChar - 44) + 10;
            }

            // If the nybble couldn't be converted, just exit
            if (nybble == -1) {
                e.Handled = true;
                return;
            }

            // Do all of the address calculations
            
            int address = (_page * 65536) + (_block * 4096) + (line * 16) + (column / 2);

            int old = 0;
            
            if (_context != null) {
                old = _context.Core[address];
            } else {
                e.Handled = true;
                return;
            }

            int write = 0;
            
            // Figure out what to write
            
            if (column % 2 == 1) {
                write = (old & 0xF0) | nybble;
            } else {
                write = (old & 0x0F) | (nybble << 4);
            }

            // Write the value
            _handler?.IssueCommand(new Command(1, address, write));

            // Console.Write(write + ", Line: " + line + ", Column: " + column + "\n");

            // Advance cursor
            // This is lazy logic, but idk
            if (x <= 8 || x >= 55) {
                MemoryInput.CaretIndex = (line * 77) + 8;
            }
            
            if (column % 2 == 0) {
                MemoryInput.CaretIndex++;
            } else {
                MemoryInput.CaretIndex += 2;
            }

            e.Handled = true;
        }

        /**
         * Update the display to match memory context
         */
        public void UpdateDisplay() {
            DisplayBuffer(_page, _block);
        }

        /**
         *  Displays the memory in context
         */
        private void DisplayBuffer(int page, int block) {
            string contents = "";
            string ascii = "";

            if (_context == null) return;
            
            for (int i = (4096 * block) + 65536 * page; i < ((4096 * block) + 65536 * page) + 4096; i++) {
                if (i % 16 == 0) {
                    contents = contents + page.ToString("X1") + "/" + (i % 65536).ToString("X4") + ": ";
                }

                contents = contents + _context.Core[i].ToString("X2") + " ";

                if (_context.Core[i] >= 0x20 && _context.Core[i] < 0x7F) {
                    ascii = ascii + System.Text.Encoding.ASCII.GetString(new[]{_context.Core[i]});
                } else {
                    ascii = ascii + ".";
                }

                if (i % 16 == 15) {
                    contents = contents + " |  " + ascii + "\n";
                    ascii = "";
                }
            }

            MemoryInput.Text = contents;
        }
        
        /**
         * Handle a user request to change the viewed address
         */
        private void OnReAddress(object? sender, RoutedEventArgs e) {

            // Parse block text
            if (Int32.TryParse(BlockInput.Text, out int block) && block >= 0 && block < 16 ) {
                _block = block;
            } else {
                _block = 0;
                BlockInput.Text = "0";
            }
            
            // Parse page text
            if (Int32.TryParse(PageInput.Text, out int page) && page >= 0 && page < 4 ) {
                _page = page;
            } else {
                page = 0;
                PageInput.Text = "0";
            }
            
            // And update
            UpdateDisplay();
        }

        [NotNull]
        public EmulationContext? Context {
            get => _context;
            set => _context = value ?? throw new ArgumentNullException(nameof(value));
        }
        
        [NotNull]
        public EmulationHandler? Handler {
            get => _handler;
            set => _handler = value ?? throw new ArgumentNullException(nameof(value));
        }
    }
    
    
}