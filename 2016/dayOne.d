import std.stdio;
import std.file;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;
import std.math;

void main()
{
	auto headings = [tuple(1,0), tuple(0,1), tuple(-1, 0), tuple(0,-1)].cycle();
	int headingIndex = 0;
	auto pos = tuple(0,0);

	auto directions = readText("dayOneInput")
	.splitter(", ")
	.map!(dir=>tuple(dir.takeOne[0], dir.dropOne.to!int));

	foreach(dir; directions)
	{
		switch(dir[0])
		{
			case 'R':
			++headingIndex;
			break;
			default:
			--headingIndex;
			break;
		}
		auto currentHeading = headings[headingIndex];
		pos = tuple(pos[0] + (currentHeading[0] * dir[1]), pos[1] + (currentHeading[1] * dir[1]));
		
		writeln(dir.to!string ~ "" ~ pos.to!string);
	}

	writeln(pos.to!string ~ " = " ~ (abs(pos[0]) + abs(pos[1])).to!string);
}