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
								.map!parseIPv7
								.filter!(address=>!address.filter!(chunk=>chunk.bracketed).map!(chunk=>chunk.chunk).any!containsABBA && address.filter!(chunk=>!chunk.bracketed).map!(chunk=>chunk.chunk).any!containsABBA)
								;


	writeln(supportedAddresses.count);
}


struct IPv7Chunk
{
	immutable string chunk;
	immutable bool bracketed;
}

IPv7Chunk[] parseIPv7(string address)
{
	IPv7Chunk[] chunks;
	chunks.reserve(3);
	char[] result;
	result.reserve(address.length);

	int bracketCount = 0;
	foreach(c;address)
	{
		switch(c)
		{
			case '[':
				++bracketCount;
				if(bracketCount == 1)
				{
					chunks ~= IPv7Chunk(result.idup, false);
					result.length = 0;
				}
				break;
			case ']':
				--bracketCount;
				if(bracketCount == 0)
				{
					chunks ~= IPv7Chunk(result.idup, true);
					result.length = 0;
				}
				//check negatives?
				break;
			default:
					result ~= c;
				break;
		}
	}
	if(result.length > 0)
	{
		chunks ~= IPv7Chunk(result.idup, bracketCount > 0);
	}

	return chunks;
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
			  	break;
			 }
		}
	}
	return match;
}