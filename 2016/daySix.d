import std.stdio;
import std.range;
import std.string;
import std.algorithm;
import std.typecons;

void main()
{
	auto letters = stdin.byLineCopy.array
		.transposed
		.map!(l=>l.array.sort.group)
		.array
		.map!(l=>l.maxElement!"a[1]", l=>l.minElement!"a[1]")
		.map!(t=>t[0][0], t=>t[1][0]);

	auto maximalLetters = letters.map!(t=>t[0]);
	auto minimalLetters = letters.map!(t=>t[1]);
	writefln("max: %s", maximalLetters);
	writefln("min: %s", minimalLetters);
}