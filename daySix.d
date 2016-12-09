import std.stdio;
import std.file;
import std.range;
import std.string;
import std.algorithm;

void main()
{
	auto letters = readText("daysixInput")
		.splitLines
		.transposed
		.map!(l=>l.array.sort.group)
		.map!(l=>l.minElement!"a[1]")
		.map!(t=>t[0]);

	auto finalWord = letters.array;
	writeln(finalWord);
}