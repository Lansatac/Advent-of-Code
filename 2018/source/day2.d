module day2;

import std.traits;
import std.range;
/*
abcdef contains no letters that appear exactly two or three times.
bababc contains two a and three b, so it counts for both.
abbcde contains two b, but no letter appears exactly three times.
abcccd contains three c, but no letter appears exactly two times.
aabcdd contains two a and two d, but it only counts once.
abcdee contains two e.
ababab contains three a and three b, but it only counts once.
*/

void day2()
{
	import std.stdio;
	import std.file;


	auto checksum = checksum(File("input/day2").byLineCopy);

	writefln("checksum: %s", checksum);
}

unittest
{
	assert(containsExactly("abcdef", 2) == false);
	assert(containsExactly("bababc", 2) == true);
	assert(containsExactly("abbcde", 2) == true);
	assert(containsExactly("abcccd", 2) == false);
	assert(containsExactly("aabcdd", 2) == true);
	assert(containsExactly("abcdee", 2) == true);
	assert(containsExactly("ababab", 2) == false);

	assert(containsExactly("abcdef", 3) == false);
	assert(containsExactly("bababc", 3) == true);
	assert(containsExactly("abbcde", 3) == false);
	assert(containsExactly("abcccd", 3) == true);
	assert(containsExactly("aabcdd", 3) == false);
	assert(containsExactly("abcdee", 3) == false);
	assert(containsExactly("ababab", 3) == true);
}

bool containsExactly(Input)(Input input, uint count)
	if(isInputRange!Input && isSomeChar!(ElementType!Input))
{
	import std.algorithm;
	import std.uni;
	return input.array
			.sort
			.group
			.any!(x=>x[1] == count);
}

unittest
{
	assert(checksum(["abcdef","bababc","abbcde","abcccd","aabcdd","abcdee","ababab"]) == 12);
}

int checksum(Input)(Input ids)
	if(isInputRange!Input && isSomeString!(ElementType!Input))
{
	import std.algorithm;
	import std.typecons;

	auto checksums = ids
					.map!(id => containsExactly(id, 2) ? 1 : 0, id => containsExactly(id, 3) ? 1 : 0)
					.fold!(delegate Tuple!(int, int) (Tuple!(int, int) a, Tuple!(int, int) id)	{
						return tuple(a[0] + id[0], a[1] + id[1]);
					})
					(tuple(0,0));

	return checksums[0] * checksums[1];
}