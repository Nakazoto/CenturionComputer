namespace CPU7Plus.Terminal {
    public class TerminalBlock {

        public static TerminalHandler? ConsoleTerminal;

        public static void InitializeTerminals() {
            ConsoleTerminal = new TerminalHandler(50500);
        }


    }
}