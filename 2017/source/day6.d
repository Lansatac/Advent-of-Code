import std.algorithm;
import std.conv;
import std.range;
import std.traits;
import std.typecons;

@safe
unittest
{
	assert([2,4,1,2] == cycle([0,2,7,0]));
}

@safe
unittest
{
	assert(5 == stepsToCycle("0 2 7 0")[0]);
	assert(5 == stepsToCycle([0,2,7,0])[0]);

	assert(4 == stepsToCycle([0,2,7,0])[1]);

}

///
Tuple!(int, int) stepsToCycle(string banks) @safe
{
	import std.uni : isWhite;
	auto integers = banks
					.splitter!(isWhite)
					.map!(to!int)
					.array;
	return stepsToCycle(integers);
}

///
Tuple!(int, int) stepsToCycle(int[] banks) @safe
{
	int[][] cycles;
	cycles.reserve(100);
	cycles ~= banks;
	int foundIndex = -1;
	int count;
	while(foundIndex == -1)
	{
		++count;
		banks = cycle(banks);
		auto prevCycle = cycles.enumerate.find!(cycle=>cycle[1].equal(banks));
		foundIndex = prevCycle.empty ? -1 : cast(int)prevCycle.front[0];
		cycles ~= banks;
	}
	return tuple(count, count - foundIndex);
}

private int[] cycle(int[] banks) pure @safe
{
	banks = banks.dup;
	auto index = banks.maxIndex;
	int remaining = banks[index];
	banks[index++] = 0;
	while(remaining-- > 0)
	{
		if(index == banks.length)
		{
			index = 0;
		}
		++banks[index++];
	}
	return banks;
}