module day1;

import std.regex;
import std.traits;
import std.range;

enum numberMatch = ctRegex!(r"[+-][0-9]+");

unittest
{
	assert(day1("+1, +1, +1") == 3);
	assert(day1("+1, +1, -2") == 0);
	assert(day1("-1, -2, -3") == -6);
}

int day1(Input)(Input input)
	if(isInputRange!Input && isSomeChar!(ElementType!Input))
{
	import std.algorithm;
	import std.conv;

	return input.matchAll(numberMatch)
	.map!(match=> match.front.to!int)
	.sum;
}