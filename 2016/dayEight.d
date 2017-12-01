import std.stdio;
import std.range;
import std.string;
import std.algorithm;
import std.typecons;
import std.array;

class Screen
{
	private bool[50][6] pixels;


	size_t height(){return pixels.length;}
	size_t width(){return pixels[0].length;}

	public auto opIndex(size_t y)
	{
		return pixels[y];
	}

	public bool opIndex(size_t x, size_t y)
	in
	{
		assert(y < pixels.length, format("y must be less than %s (was %s)", pixels.length, y));
		assert(x < pixels[y].length, format("x must be less than %s (was %s)", pixels[y].length, x));
	}
	body
	{
		return pixels[y][x];
	}

	public bool opIndexAssign(bool value, size_t x, size_t y)
	{
		pixels[y][x] = value;
		return pixels[y][x];
	}

	int opApply(scope int delegate(ref bool[50]) dg)
    {
        int result = 0;

        for (int i = 0; i < pixels.length; i++)
        {
            result = dg(pixels[i]);
            if (result)
                break;
        }
        return result;
    }

    @property int opDollar(size_t dim : 0)() { return pixels[0].length; }
    @property int opDollar(size_t dim : 1)() { return pixels.length; }
}

void printScreen(Screen screen)
{
	foreach(column; screen)
	{
		foreach(pixel; column)
		{
			write(pixel ? "#" : ".");
		}
		writeln;
	}
}

void drawRect(Screen screen, int width, int hight)
{
	screen.drawRect(0,0, hight, width);
}

void drawRect(Screen screen, int top, int left, int bottom, int right)
{
	for(size_t x = left; x < right; ++x)
	{
		for(size_t y = top; y < bottom; ++y)
		{
			screen[x,y] = true;
		}
	}
}

void rotate(alias string Which)(Screen screen, const int index, const int count)
	if(Which == "row" || Which == "column")
{
	for(int i = 0; i < count; ++i)
	{
		screen.rotate!Which(index);
	}
}

void rotate(alias string Which)(Screen screen, const int index)
	if(Which == "row" || Which == "column")
{
	enum string indexer = Which == "row" ? "%s, index" : "index, %s";
	enum string length = Which == "row" ? "width" : "height";
	mixin(format("auto lastPixel = screen[" ~ indexer ~ "];", "screen."~length~"-1"));
	mixin("for(size_t column  = screen."~length~" - 1; column > 0 ; --column)"~
	"{"~
		format("auto prevPixel = screen["~indexer~"];", "column - 1")~
		format("screen["~indexer~"] = prevPixel;", "column")~
	"}");
	mixin(format("screen["~indexer~"] = lastPixel;", "0"));
}

void main()
{
	//auto instructions = stdin.byLineCopy.array;
	Screen testScreen = new Screen();
	testScreen.drawRect(3,2);
	testScreen.rotate!"row"(1, 51);
	testScreen.rotate!"column"(2, 4);
	//testScreen.drawRect(3,2);

	printScreen(testScreen);
}