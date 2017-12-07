import std.algorithm;
import std.conv;
import std.range;
import std.traits;

@safe
unittest
{
	assert(5 == movesToEscape!increment([0,3,0,1,-3]));
	assert(10 == movesToEscape!strange([0,3,0,1,-3]));
}

///
int movesToEscape(alias InstructionModifier, Moves)(Moves instructions)
	if(isInputRange!Moves && isSomeString!(ElementType!(Moves)))
{
	return movesToEscape!InstructionModifier(instructions.map!(to!int));
}

///
int movesToEscape(alias InstructionModifier, Moves)(Moves instructions)
	if(isInputRange!Moves && isNumeric!(ElementType!(Moves)))
{
	auto buffer = instructions.array;

	int steps = 0;
	int instructionPointer = 0;
	while(instructionPointer >= 0 && instructionPointer < buffer.length)
	{
		++steps;
		immutable int current = buffer[instructionPointer];
		buffer[instructionPointer] = InstructionModifier(current);
		instructionPointer += current;
	}

	return steps;
}


alias increment = i=>i + 1;
alias strange = i=>i < 3 ? i + 1 : i - 1;