using System;
using System.Collections.Concurrent;
using System.Threading;
using Avalonia.Threading;
using CPU7Plus.Views;
using JetBrains.Annotations;

namespace CPU7Plus.Emulation {
    public class EmulationHandler {

        private volatile bool _run;
        private volatile bool _execute;
        private volatile bool _doUpdate;


        private EmulationCore _emulator;
        private EmulationContext _context;

        private MainWindow _window;
        private MemoryViewer _viewer;

        private ConcurrentQueue<string> _commandQueue;

        public EmulationHandler(MainWindow window, MemoryViewer viewer) {
            // Prepare to create emulation thread
            _run = true;
            _execute = false;
            _doUpdate = true;
            _commandQueue = new ConcurrentQueue<string>();
            
            // Save passed objects
            _window = window;
            _viewer = viewer;

            // Create emulator
            _context = new EmulationContext();
            _emulator = new EmulationCore(_context);
            
            // Set context
            _viewer.Context = _context;
            _viewer.Handler = this;
            _viewer.UpdateDisplay();
            
            // Create the thread
            Thread emulationThread = new Thread(new ThreadStart(this.HandleEmulation));
            
            // Start the thread up
            emulationThread.Start();
        }

        /**
         * Tells the handler thread to end its loop and quit
         */
        public void Terminate() {
            _run = false;
        }

        /**
         * Start processor execution
         */
        public void StartExecution() {
            _doUpdate = true;
            _execute = true;
        }

        /**
         * Stop processor execution
         */
        public void StopExecution() {
            _execute = false;
        }

        /**
         * Issues a command to the emulator thread
         */
        public void IssueCommand(String command) {
            _commandQueue.Enqueue(command);
        }

        [NotNull]
        public EmulationContext Context {
            get => _context;
            set => _context = value ?? throw new ArgumentNullException(nameof(value));
        }

        /**
         * Emulation handler thread
         */
        private void HandleEmulation() {

            Console.Write("Starting emulation thread...\n");
            
            while (_run) {
                // Do emulation stuff
                
                Thread.Sleep(10);
                if (_doUpdate) {
                    _doUpdate = false;
                    ViewUpdater.UpdateContext(_context, _window);
                }

                if (_execute) {
                    _emulator.Step();
                    
                    Dispatcher.UIThread.Post(() => {
                        ViewUpdater.UpdateView(_context, _window);
                        _viewer.UpdateDisplay();
                    });
                }

                // Check to see if any commands have been received
                
                if (!_commandQueue.IsEmpty) {
                    
                    _commandQueue.TryDequeue(out string? command);

                    if (command != null && command.StartsWith("S")) {
                        // Single step command
                        ViewUpdater.UpdateContext(_context, _window);

                        // Step processor
                        _emulator.Step();
                        
                        // Update all visuals
                        Dispatcher.UIThread.Post(() => {
                            ViewUpdater.UpdateView(_context, _window);
                            _viewer.UpdateDisplay();
                        });
                    } else if (command != null && command.StartsWith("W")) {
                        // Write memory command
                        string[] split = command.Split(',');

                        // Read the command and write the byte
                        try {
                            _context.Core[Int32.Parse(split[1])] = Convert.ToByte(Int32.Parse(split[2]));
                        } catch (FormatException) {
                            // Do nothing lmao
                        } catch (NullReferenceException) {
                            // Still nothing, fool!
                            // (I am good at programming)
                        }
                        
                        // Update all visuals
                        Dispatcher.UIThread.Post(() => {
                            ViewUpdater.UpdateView(_context, _window);
                            _viewer.UpdateDisplay();
                        });
                    }
                }
            }
            
            Console.Write("Stopping emulation thread...\n");

        }
        
        
    }
}