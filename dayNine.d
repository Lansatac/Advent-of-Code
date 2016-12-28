import std.stdio;
import std.file;
import std.algorithm;
import std.typecons;
import std.range;
import std.conv;
import std.concurrency;
import std.string;

void main()
{
	auto file = stdin.byLineCopy.front;

	auto parser = new Generator!(immutable char)(
	{
		for(size_t index = 0; index < file.length; ++index)
		{
			if(file[index] == '(')
			{
				size_t parenIndex = file.indexOf(')', index);
				size_t nextIndex = parenIndex + 1;
				auto compression = file[index + 1 .. parenIndex].split('x').map!(to!int);
				auto toRepeat = file[nextIndex .. nextIndex + compression[0]];
				for(int i = 0; i < compression[1]; ++i)
				{
					toRepeat.each!yield;
				}
				index = parenIndex + compression[0];
			}
			else
			{
				yield(file[index]);
			}
		}
	});

	writeln("file size: " ~ parser.array.length);
}