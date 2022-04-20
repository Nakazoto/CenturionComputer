using System;
using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.ReactiveUI;
using CPU7Plus.Terminal;

namespace CPU7Plus {
    class Program {
        // Initialization code. Don't use any Avalonia, third-party APIs or any
        // SynchronizationContext-reliant code before AppMain is called: things aren't initialized
        // yet and stuff might break.
        [STAThread]
        public static void Main(string[] args) {
            
            // Init all terminals
            // This exists to avoid AvaloniaUI related bullshit
            TerminalBlock.InitializeTerminals();
            
            // Jump into Avalonia stuff
            BuildAvaloniaApp()
                .StartWithClassicDesktopLifetime(args);

        } 

        // Avalonia configuration, don't remove; also used by visual designer.
        public static AppBuilder BuildAvaloniaApp()
            => AppBuilder.Configure<App>()
                .UsePlatformDetect()
                .LogToTrace()
                .UseReactiveUI();
    }
}