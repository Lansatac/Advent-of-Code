import std.range;
import std.traits;

unittest
{
	assert(8 == checksumRow([5, 1, 9, 5]));
	assert(4 == checksumRow([7, 5, 3]));
	assert(6 == checksumRow([2, 4, 6, 8]));
	assert(1230 == checksumRow([1136, 1129, 184, 452, 788, 1215, 355, 1109, 224, 1358, 1278, 176, 1302, 186, 128, 1148]));
}

uint checksumRow(Row)(Row row)
	if(isInputRange!Row && isNumeric!(ElementType!(Row)))
{
	import std.algorithm : reduce, min, max;
	import std.typecons : tuple, Tuple;

	auto minmax = reduce!(min, max)(tuple(row.front, row.front), row);

	return minmax[1] - minmax[0];
}

unittest
{
	assert(18 == checksumRows(
		["5 1 9 5",
		 "7 5 3",
		 "2 4 6 8"]
		 ));
		assert(18 == checksumRows(
		["5	1	9	5",
		 "7	5	3",
		 "2	4	6	8"]
		 ));
}

uint checksumRows(RowStrings)(RowStrings rows)
	if(isInputRange!RowStrings && isSomeString!(ElementType!(RowStrings)))
{
	import std.ascii : isWhite;
	import std.algorithm : map, splitter;
	import std.conv;
	return checksumRows(rows
		.map!(s=>s
				.splitter!(isWhite)
				.map!(to!int)));
}

uint checksumRows(Rows)(Rows rows)
	if(isInputRange!Rows && isInputRange!(ElementType!(Rows)) && isNumeric!(ElementType!(ElementType!(Rows))))
{
	import std.algorithm;
	return rows
		.map!(checksumRow)
		.sum;
}