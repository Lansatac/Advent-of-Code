import std.stdio;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;
import std.math;
import std.digest.md;

alias stdsort = std.algorithm.sort;

void main()
{
    auto numbers = iota(0, int.max);
    auto doorName = stdin.byLineCopy.front;

    auto code = numbers
                    .map!(index=>doorName ~ index.to!string)
                    .map!(code=>md5Of(code).toHexString!(LetterCase.lower).idup)
                    .filter!(hash=>hash.startsWith("00000"))
                    .take(8)
                    .map!(hash=>hash.drop(5).front);

    writeln(code);
}