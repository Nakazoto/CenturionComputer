namespace CPU7Plus.Emulation {
    public class Command {
        public Command(int type) {
            Type = type;

            Address = 0;
            Data = 0;
        }

        public Command(int type, int address, int data) {
            Type = type;

            Address = address;
            Data = data;
        }

        public int Type { get; set; }

        public int Address { get; set; }

        public int Data { get; set; }
    }
}