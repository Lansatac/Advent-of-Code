import std.stdio;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;

void main()
{
	auto input = stdin.byLineCopy										//input, by line
					  .map!(entry=>entry.splitter.map!(to!int).array)	// "1 2 3" => [1,2,3]
					  .array;

	auto rowTriangles = input
						.filter!validTriangle;

	writeln("row triangles: " ~ rowTriangles.count.to!string);

		auto columnTriangles = input.array
			.transposed.joiner.array.chunks(3)
			.filter!validTriangle;
	
	writeln("column triangles: " ~ columnTriangles.count.to!string);
	
}

bool validTriangle(Range)(Range r)
{
	return r.permutations									//wasteful as this generates more permutations than we need
			.all!(perm=>perm.take(2).sum > perm.tail(1)[0]);//valid only if every permutation's first two sides are greater than the third
}