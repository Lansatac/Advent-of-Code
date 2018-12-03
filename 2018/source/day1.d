module day1;

import std.regex;
import std.traits;
import std.range;

enum numberMatch = ctRegex!(r"[+-][0-9]+");

void day1(Input)(Input input)
	if(isInputRange!Input && isSomeChar!(ElementType!Input))
{
	import std.stdio;
	import std.algorithm;
	import std.conv;

	auto parsed = input.matchAll(numberMatch)
		.map!(match=> match.front.to!int)
		;

	writefln("Frequency: %s", findFrequency(parsed));
	writefln("First Recurring: %s", firstRecurring(parsed));
}

unittest
{
	assert(findFrequency([+1, +1, +1]) == 3);
	assert(findFrequency([+1, +1, -2]) == 0);
	assert(findFrequency([-1, -2, -3]) == -6);
}

int findFrequency(Input)(Input frequencies)
	if(isInputRange!Input && isNumeric!(ElementType!Input))
{
	import std.range;
	import std.algorithm;
	return cumulativeFold!("a + b")(frequencies)
			.tail(1)
			.front;
}

unittest
{
	assert(firstRecurring([1, -1]) == 0);
	assert(firstRecurring([3, 3, 4, -2, -4]) == 10);
	assert(firstRecurring([-6, 3, 8, 5, -6]) == 5);
	assert(firstRecurring([7, 7, -2, -7, -4]) == 14);
}
int firstRecurring(Input)(Input frequencies)
	if(isInputRange!Input && isNumeric!(ElementType!Input))
{
	import std.algorithm;
	bool[int] previousSet = [0:true];
	foreach(freq; cumulativeFold!("a + b")(frequencies.cycle))
	{
		if(freq in previousSet)
		{
			return freq;
		}

		previousSet[freq] = true;
	}
	assert(0);
}