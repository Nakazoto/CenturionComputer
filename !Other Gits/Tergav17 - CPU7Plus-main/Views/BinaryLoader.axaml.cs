using System;
using System.IO;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using Avalonia.Markup.Xaml;
using CPU7Plus.Emulation;
using JetBrains.Annotations;

namespace CPU7Plus.Views {
    public partial class BinaryLoader : Window {
        
        
        private volatile bool _canClose;

        private string _file;

        private EmulationHandler? _handler;

        public BinaryLoader() {
            InitializeComponent();
#if DEBUG
            this.AttachDevTools();
#endif
            
            // Setup some flags and values
            _canClose = false;
            _file = "None";

            // Make closing simply hide the window
            this.Closing += (s, e) => {
                if (!_canClose) {
                    e.Cancel = true;
                    this.Hide();
                }
            };
            
            SelectedFile = this.FindControl<TextBlock>("SelectedFile");
            MemoryBase = this.FindControl<TextBox>("MemoryBase");
        }

        /**
         * Permits the window to be closed
         */
        public void AllowClose() {
            _canClose = true;
        }
        
        private void InitializeComponent() {
            AvaloniaXamlLoader.Load(this);
        }

        /**
         * Opens up a file
         */
        private async void OnFileOpen(object? sender, RoutedEventArgs e) {
            OpenFileDialog dialog = new OpenFileDialog();

            string[]? result = await dialog.ShowAsync(this);
            
            if (result != null && result.Length > 0) {
                _file = result[0];
            }

            SelectedFile.Text = "Selected File: " + Path.GetFileName(_file);
        }

        /**
         * Loads a file into memory
         */
        private void OnLoadMemory(object? sender, RoutedEventArgs e) {

            try {

                FileStream binary = File.OpenRead(_file);

                string stringAddr = MemoryBase.Text;

                string[] parts = stringAddr.Split("/");

                int address = 0x100;
                var ParseBy = System.Globalization.NumberStyles.HexNumber;

                // Parse address
                if (parts.Length == 1) {
                    address = int.Parse(parts[0], ParseBy);
                }
                else if (parts.Length == 2) {
                    address = int.Parse(parts[1], ParseBy);
                    address = address + int.Parse(parts[0], ParseBy) * 65536;
                }

                Console.Write("Starting at " + address + " (" + stringAddr + ")" + "\n");
                
                // Read file in
                while (binary.Position < binary.Length && address < (65536 * 4)) {
                    if (_handler != null) {
                        int b = binary.ReadByte();

                        _handler.IssueCommand(new Command(2, address, b));
                    }
                    address++;
                }

                // Update visuals
                _handler?.IssueCommand(new Command(3));

                binary.Close();

            } catch (FileNotFoundException) {
                SelectedFile.Text = "Cannot Open File!";
            } catch (FormatException) {
                SelectedFile.Text = "Address Format Error";
            }
        }

        [NotNull]
        public EmulationHandler? Handler {
            get => _handler;
            set => _handler = value ?? throw new ArgumentNullException(nameof(value));
        }
    }
}