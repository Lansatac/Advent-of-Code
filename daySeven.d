import std.stdio;
import std.range;
import std.string;
import std.algorithm;
import std.typecons;
import std.array;

void main()
{
	auto addresses = stdin.byLineCopy.array;

	auto supportedAddresses = addresses
								.map!elideBrackets
								//.map!(ad=>ad.split)
								;//.filter!(chunks=>chunks.any!containsABBA);

int counter;
	foreach(add; supportedAddresses)
	{
		if(add.any!containsABBA)
		{
			writeln(add);
			writeln(++counter);
		}
	}
	//writeln(supportedAddresses.take(5));
}

//bool supportsTLS(string address)
//{
//	return address.elideBrackets.containsABBA;
//}

string[] elideBrackets(string address)
{
	char[] result;
	result.reserve(address.length);

	int bracketCount = 0;
	foreach(c;address)
	{
		switch(c)
		{
			case '[':
				++bracketCount;
				break;
			case ']':
				--bracketCount;
				//check negatives?
				break;
			default:
				if(bracketCount == 0)
				{
					result ~= c;
				}
				else
				{
					result ~= ' ';
				}
				break;
		}
	}

	return result.idup.split;
}

bool containsABBA(string chunk)
{
	bool match = false;
	if(chunk.length >= 4)
	{
		for(int i = 0; i < chunk.length - 3; ++i)
		{
			match = chunk[i] != chunk[i + 1]
			 && chunk[i] == chunk[i + 3]
			 && chunk[i + 1] == chunk[i + 2];
			 if(match)
			 {
			 	writeln(chunk[i .. i + 4]);
			 	break;
			 }
		}
	}
	return match;
}