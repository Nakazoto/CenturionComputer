namespace UBanner;

class Program
{
    static void Main(string[] args)
    {
        var lines = File.ReadAllLines("layoutbob.txt");
        int lineNum = 0;
        Console.WriteLine("LAYOUT EQU *");
        foreach (var line in lines)
        {
            char[] chars = line.ToCharArray();
            for (int linePos = 0; linePos < chars.Length; linePos++)
            {
                if (chars[linePos] != ' ')
                {
                    Console.WriteLine($" DB X'1b'");
                    Console.WriteLine($" DB 'Y'");
                    Console.WriteLine($" DB {lineNum + 32}");
                    Console.WriteLine($" DB {linePos + 32}");
                    Console.WriteLine($" DB {(int)chars[linePos]} ; {chars[linePos]}");
                    Console.WriteLine($" DB 0");
                    Console.WriteLine($" DB 0");
                    Console.WriteLine($" DB 0");
                    Console.WriteLine("*");
                }
            }
            lineNum++;
        }
        Console.WriteLine("ELAYOUT EQU *");
        Console.WriteLine("LOLEN EQU (*-LAYOUT)/8");
    }
}
