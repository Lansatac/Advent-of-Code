import std.algorithm;
import std.range;
import std.traits;

@safe
unittest
{
	assert(3 == solveCaptcha("1122", 1));
	assert(4 == solveCaptcha("1111", 1));
	assert(0 == solveCaptcha("1234", 1));
	assert(9 == solveCaptcha("91212129", 1));


	assert(6 == solveCaptcha("1212", 2));
	assert(0 == solveCaptcha("1221", 2));
	assert(4 == solveCaptcha("123425", 3));
	assert(12 == solveCaptcha("123123", 3));
	assert(4 == solveCaptcha("12131415", 4));
}

///Solve the captcha as a string
@safe
int solveCaptcha(string captcha, int offset) pure
{
	import std.conv : to;
	return solveCaptcha(captcha.map!(c=>c.to!(int) - '0'), offset);
}

///Solve the captcha as a numeric range
@safe
int solveCaptcha(Numbers)(Numbers captcha, int offset) pure
	if(isInputRange!Numbers && isNumeric!(ElementType!(Numbers)))
{

	auto looping = captcha
					.cycle()
					.drop(offset);

	auto series = captcha.zip(looping);

	return series.fold!((a, n)=>a + (n[0] == n[1] ? n[0] : 0))(0);
}