import std.algorithm;
import std.range;
import std.traits;

@system
unittest
{
	assert(8 == checksumRow([5, 1, 9, 5]));
	assert(4 == checksumRow([7, 5, 3]));
	assert(6 == checksumRow([2, 4, 6, 8]));
}

@system
unittest
{
	assert(18 == processRows!checksumRow(
		["5 1 9 5",
		 "7 5 3",
		 "2 4 6 8"]
		 ));
	assert(18 == processRows!checksumRow(
		["5	1	9	5",
		 "7	5	3",
		 "2	4	6	8"]
		 ));
	assert(18 == processRows!checksumRow(
		["5	1	9	5",
		 "7	5	3",
		 "2	4	6	8"]
		 ));
}

///
uint checksumRow(Row)(Row row)
	if(isInputRange!Row && isNumeric!(ElementType!(Row)))
{
	import std.typecons : tuple, Tuple;

	auto minmax = row.dropOne().fold!(min, max)(tuple(row.front, row.front));

	return minmax[1] - minmax[0];
}

///
uint processRows(alias ChecksumAlgorithm, RowStrings)(RowStrings rows)
	if(isInputRange!RowStrings && isSomeString!(ElementType!(RowStrings)))
{
	import std.ascii : isWhite;
	import std.conv : to;
	return processRows!ChecksumAlgorithm(rows
						.map!(s=>s
							.splitter!(isWhite)
							.map!(to!int)));
}

///
uint processRows(alias ChecksumAlgorithm, Rows)(Rows rows)
	if(isInputRange!Rows && isInputRange!(ElementType!(Rows)) && isNumeric!(ElementType!(ElementType!(Rows))))
{
	return rows
		.map!(ChecksumAlgorithm	)
		.sum;
}

@safe
unittest
{
	assert(true == isEvenlyDivisible(4,2));
	assert(false == isEvenlyDivisible(2,4));
	assert(false == isEvenlyDivisible(4,3));


	assert(true == isEitherEvenlyDivisible(4,2));
	assert(true == isEitherEvenlyDivisible(2,4));
	assert(false == isEitherEvenlyDivisible(3,4));
}

///
uint commonRowDivisor(Row)(Row row)
	if(isInputRange!Row && isNumeric!(ElementType!(Row)))
{
	import std.typecons : tuple, Tuple;

	auto minmax = row.dropOne().fold!(min, max)(tuple(row.front, row.front));

	return minmax[1] - minmax[0];
}

///
@safe @nogc
bool isEvenlyDivisible(int lhs, int rhs) pure
{
	return lhs % rhs == 0;
}

///
@safe @nogc
bool isEitherEvenlyDivisible(int a, int b) pure
{
	return isEvenlyDivisible(a, b) || isEvenlyDivisible(b, a);
}