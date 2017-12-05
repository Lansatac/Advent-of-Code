import day2;

import std.range;
import std.stdio;
import std.string;

void main()
{
	auto input = stdin.byLine;

	//writefln("First: %s", input.solveCaptcha(1));
	//writefln("Second: %s", input.solveCaptcha(cast(int)(input.length / 2)));

	//writefln("First: %s", input.processRows!checksumRow());
	writefln("Second: %s", input.processRows!commonRowDivisor());
}