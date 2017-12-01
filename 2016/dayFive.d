import std.stdio;
import std.algorithm;
import std.range;
import std.conv;
import std.array;
import std.string;
import std.digest.md;

void main()
{
    auto numbers = iota(0, int.max);
    auto doorName = stdin.byLineCopy.front;

    auto hashes = numbers
                    .map!(index=>doorName ~ index.to!string)
                    .map!(code=>md5Of(code).toHexString!(LetterCase.lower).idup)
                    .filter!(hash=>hash.startsWith("00000"));
                    
    char[8] codeOne;
    int codeOneIndex;
    char[8] codeTwo;
    int codeTwoCount;
    while(codeTwoCount < 8)
    {
        auto hash = hashes.front;
        char sixth = hash[5];
        if(codeOneIndex < codeOne.length)
        {
            codeOne[codeOneIndex++] = sixth;
            drawResults(codeOne, codeTwo);
        }

        auto sixthString = sixth.to!string;
        if(sixthString.isNumeric)
        {
            int index = sixthString.to!int;
            if(index < codeTwo.length && codeTwo[index] == char.init)
            {
                codeTwo[index] = hash[6];
                ++codeTwoCount;
                drawResults(codeOne, codeTwo);
            }
        }
        hashes.popFront();
    }
}

void drawResults(char[] one, char[] two)
{
    writefln("1: %s", one.replace(char.init.to!string, "_"));
    writefln("2: %s", two.replace(char.init.to!string, "_"));
}