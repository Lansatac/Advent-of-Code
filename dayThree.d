import std.stdio;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;

void main()
{
	auto triangles = stdin.byLineCopy							//input, by line
		.map!(entry=>entry.splitter.map!(to!int).array)			// "1 2 3" => [1,2,3]
		.filter!(tri=>tri
			.permutations										//wasteful as this generates more permutations than we need
			.all!(perm=>perm.take(2).sum > perm.tail(1)[0]));	//take only those where every permutation produces the first two sides greater than the third.

	writeln("triangles: " ~ triangles.count.to!string);
}