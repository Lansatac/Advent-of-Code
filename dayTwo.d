import std.stdio;
import std.range;
import std.typecons;
import std.conv;
import std.algorithm;

struct Coord
{
	int x=1;
	int y=1;
}

void main()
{
	auto keypad = iota(1,10).chunks(3).array;
	auto input = stdin.byLine;
	int code[];

	foreach(set; input)
	{
		auto pos = Coord();
		foreach(instruction; set)
		{
			switch(instruction)
			{
				case 'U':
					pos = pos.moveUp;
					break;
				case 'D':
					pos = pos.moveDown;
					break;
				case 'L':
					pos = pos.moveLeft;
					break;
				default:
					pos = pos.moveRight;
					break;
			}
		}
		code ~= (keypad[pos.y][pos.x]);
	}
	writeln(code);
}

Coord moveUp(Coord pos)
{
	if(pos.y >= 1)
		pos.y -= 1;
	return Coord(pos.x, pos.y);
}

Coord moveDown(Coord pos)
{
	if(pos.y <= 1)
		pos.y += 1;
	return Coord(pos.x, pos.y);
}

Coord moveLeft(Coord pos)
{
	if(pos.x >= 1)
		pos.x -= 1;
	return Coord(pos.x, pos.y);
}

Coord moveRight(Coord pos)
{
	if(pos.x <= 1)
		pos.x += 1;
	return Coord(pos.x, pos.y);
}
