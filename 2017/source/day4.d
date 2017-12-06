import std.algorithm;
import std.range;
import std.stdio;
import std.traits;

@safe
unittest
{
	assert(true == isPassphraseValid("aa bb cc dd ee"));
	assert(false == isPassphraseValid("aa bb cc dd aa"));
	assert(true == isPassphraseValid("aa bb cc dd aaa"));

	assert(true == isPassphraseValid2("abcde fghij"));
	assert(false == isPassphraseValid2("abcde xyz ecdab"));
	assert(true == isPassphraseValid2("a ab abc abd abf abj"));
	assert(true == isPassphraseValid2("iiii oiii ooii oooi oooo"));
	assert(false == isPassphraseValid2("oiii ioii iioi iiio"));
}

///
@safe
bool isPassphraseValid(PassPhrase)(PassPhrase passphrase)
	if(isSomeString!(PassPhrase))
{
	import std.uni : isWhite;

	return passphrase
			.splitter!(isWhite)
			.array.sort
			.arePassphraseWordsUnique;
}

///
@safe
bool isPassphraseValid2(PassPhrase)(PassPhrase passphrase)
	if(isSomeString!(PassPhrase))
{
	import std.uni : isWhite;

	return passphrase.array
			.splitter!(isWhite)
			.map!(s=> s.array.sort.array)
			.array.sort
			.arePassphraseWordsUnique;
}

///
//@safe @nogc
bool arePassphraseWordsUnique(Words)(Words words)
	if(isInputRange!Words && isSomeString!(ElementType!(Words)))
{
	import std.uni : isWhite;

	return words
			.group
			.all!(g=>g[1] == 1);
}

///
ulong howManyPassphrasesValid(PassPhrases)(PassPhrases passphrases)
	if(isInputRange!PassPhrases && isSomeString!(ElementType!(PassPhrases)))
{
	return passphrases.count!isPassphraseValid;
}

///
ulong howManyPassphrasesValid2(PassPhrases)(PassPhrases passphrases)
	if(isInputRange!PassPhrases && isSomeString!(ElementType!(PassPhrases)))
{
	return passphrases.count!isPassphraseValid2;
}