import day1;
import std.stdio;
import std.string;

void main()
{
	auto input = readln.strip;

	writefln("First: %s", input.solveCaptcha(1));
	writefln("Second: %s", input.solveCaptcha(cast(int)(input.length / 2)));
}