import day2;
import std.stdio;
import std.string;

void main()
{
	auto input = stdin.byLine;

	//writefln("First: %s", input.solveCaptcha(1));
	//writefln("Second: %s", input.solveCaptcha(cast(int)(input.length / 2)));

	writefln("First: %s", input.checksumRows());
}