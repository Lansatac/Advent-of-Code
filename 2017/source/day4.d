import std.algorithm;
import std.range;
import std.traits;

@safe
unittest
{
	assert(true == isPassphraseValid("aa bb cc dd ee"));
	assert(false == isPassphraseValid("aa bb cc dd aa"));
	assert(true == isPassphraseValid("aa bb cc dd aaa"));
}

///
@safe
bool isPassphraseValid(PassPhrase)(PassPhrase passphrase) pure
	if(isSomeString!(PassPhrase))
{
	import std.uni : isWhite;

	return passphrase
			.splitter!(isWhite)
			.array.sort
			.group
			.all!(g=>g[1] == 1);
}

///
ulong howManyPassphrasesValid(PassPhrases)(PassPhrases passphrases)
	if(isInputRange!PassPhrases && isSomeString!(ElementType!(PassPhrases)))
{
	return passphrases.count!isPassphraseValid;
}