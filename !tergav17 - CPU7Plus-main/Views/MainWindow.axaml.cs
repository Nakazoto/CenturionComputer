using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Interactivity;
using CPU7Plus.Emulation;

namespace CPU7Plus.Views {
    public partial class MainWindow : Window {

        private EmulationHandler _emulationHandler;
        
        public MainWindow() {
            InitializeComponent();

           _emulationHandler = new EmulationHandler(this);

           

        }

        /**
         * On close event
         */
        public void OnClose(object? sender, EventArgs e) {
            _emulationHandler.Terminate();
        }

        /**
         * Button handler for single stepping
         */
        public void OnStepButton(object sender, RoutedEventArgs e) {
            _emulationHandler.IssueCommand("STEP");
        }

        /**
         * Button handler for running the processor
         */
        public void OnRunButton(object sender, RoutedEventArgs e) {
            _emulationHandler.StartExecution();
            
            ViewUpdater.DisableInputs(this);
        }
        
        /**
         * Button handler for stopping the processor
         */
        public void OnStopButton(object sender, RoutedEventArgs e) {
            _emulationHandler.StopExecution();
            
            ViewUpdater.EnableInputs(this);
        }
        
        /**
         * Menu button handler for stopping the processor
         */
        public void OnExitButton(object sender, RoutedEventArgs e) {
            this.Close();
        }
    }
}