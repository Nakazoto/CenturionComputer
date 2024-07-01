namespace UBanner;

class Program
{
    static void Main(string[] args)
    {
        var lines = File.ReadAllLines("layout.txt");
        int lineNum = 0;
        Console.WriteLine("LAYOUT\tEQU\t*");
        foreach (var line in lines)
        {
            char[] chars = line.ToCharArray();
            for (int linePos = 0; linePos < chars.Length; linePos++)
            {
                if (chars[linePos] != ' ')
                {
                    Console.WriteLine($"\tDB\tX'1b'");
                    Console.WriteLine($"\tDB\t'Y'");
                    Console.WriteLine($"\tDB\t{lineNum|32}");
                    Console.WriteLine($"\tDB\t{linePos|32}");
                    Console.WriteLine($"\tDB\t'{chars[linePos]}'");
                    Console.WriteLine($"\tDB\t0");
                    Console.WriteLine($"\tDB\t0");
                    Console.WriteLine($"\tDB\t0");
                    Console.WriteLine("*");
                }
            }
            lineNum++;
        }
        Console.WriteLine("ELAYOUT\tEQU\t*");
        Console.WriteLine("LOLEN\tEQU\t(*-LAYOUT)/8");
    }
}
