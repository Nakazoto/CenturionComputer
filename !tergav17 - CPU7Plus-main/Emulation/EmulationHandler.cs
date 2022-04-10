using System;
using System.Collections.Concurrent;
using System.Threading;
using Avalonia.Threading;
using CPU7Plus.Views;

namespace CPU7Plus.Emulation {
    public class EmulationHandler {

        private volatile bool _run;
        private volatile bool _execute;
        private volatile bool _doUpdate;


        private EmulationCore _emulator;
        private EmulationContext _context;

        private MainWindow _window;

        private ConcurrentQueue<string> _commandQueue;

        public EmulationHandler(MainWindow window) {
            // Prepare to create emulation thread
            _run = true;
            _execute = false;
            _doUpdate = true;
            _commandQueue = new ConcurrentQueue<string>();
            
            // Save passed objects
            _window = window;

            // Create emulator
            _context = new EmulationContext();
            _emulator = new EmulationCore(_context);

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
                    });
                }

                // Check to see if any commands have been received
                
                if (!_commandQueue.IsEmpty) {
                    
                    _commandQueue.TryDequeue(out string? command);

                    if (command != null && command.Equals("STEP")) {
                        
                        ViewUpdater.UpdateContext(_context, _window);

                        _emulator.Step();
                        
                        Dispatcher.UIThread.Post(() => {
                            ViewUpdater.UpdateView(_context, _window);
                        });
                    }
                }
            }
            
            Console.Write("Stopping emulation thread...\n");

        }
        
        
    }
}