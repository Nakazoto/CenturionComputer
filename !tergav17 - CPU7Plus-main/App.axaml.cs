using System;
using Avalonia;
using Avalonia.Controls;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Markup.Xaml;
using CPU7Plus.ViewModels;
using CPU7Plus.Views;

namespace CPU7Plus {
    public partial class App : Application {
        public override void Initialize() {
            AvaloniaXamlLoader.Load(this);
            
        }


        
        public override void OnFrameworkInitializationCompleted() {
            if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop) {
                desktop.MainWindow = new MainWindow {
                    DataContext = new MainWindowViewModel(),
                };

                desktop.MainWindow.Closing += (s, e) => {
                    if (s == null) throw new ArgumentNullException(nameof(s));

                    ((MainWindow) desktop.MainWindow).OnClose(s, e);
                };
            }

            base.OnFrameworkInitializationCompleted();
        }
    }
}