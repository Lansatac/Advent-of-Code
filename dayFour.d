import std.stdio;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;
import std.math;

alias stdsort = std.algorithm.sort;

void main()
{
	auto rooms = stdin.byLineCopy.array
				.map!(entry=>entry.splitter("-"))
				.map!(room=>room.array
									  .retro.drop(1)
									  .joiner
									  .array.stdsort
									  .group
									  .array.multiSort!("a[1] > b[1]", "a[0] < b[0]")
									  .map!(t=>t[0])
									  .take(5).array,
					  room=>room.array.back
					  			.array.only
							    .map!(id=>id.take(3).array,
							 		  id=>id.drop(4).take(5).array).front)
				.filter!(room=>room[0] == room[1][1]);

	writeln(rooms.map!(room=>room[1][0].to!int).sum);
}