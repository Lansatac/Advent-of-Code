import day3;

import std.conv;
import std.range;
import std.stdio;
import std.string;

void main()
{
	auto input = stdin.byLine;

	//writefln("First: %s", input.solveCaptcha(1));
	//writefln("Second: %s", input.solveCaptcha(cast(int)(input.length / 2)));

	//writefln("First: %s", input.processRows!checksumRow());
	//writefln("Second: %s", input.processRows!commonRowDivisor());

	writefln("First: %s", input.takeOne.front.to!int.manhattanDistance);
	//writefln("Second: %s", input.processRows!commonRowDivisor());
}