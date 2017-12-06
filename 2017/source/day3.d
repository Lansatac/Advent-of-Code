import std.algorithm;
import std.math;
import std.range;
import std.stdio;
import std.typecons;

@safe
unittest
{
    assert(tuple(0,0) == findPosition(1));
    assert(tuple(1,0) == findPosition(2));
    assert(tuple(1,1) == findPosition(3));
    assert(tuple(0,1) == findPosition(4));
    assert(tuple(-1,1) == findPosition(5));
    assert(tuple(-1,0) == findPosition(6));
    assert(tuple(-1,-1) == findPosition(7));
}

@safe
unittest
{
    assert(1 == cell(0,0));
    assert(2 == cell(1,0));
    assert(3 == cell(1,1));
    assert(4 == cell(0,1));
    assert(5 == cell(-1,1));
    assert(6 == cell(-1,0));
    assert(7 == cell(-1,-1));
    assert(8 == cell(0,-1));
}

/// Returns the value of a cell at a given coordinate of the spiral
int cell(int x, int y, in int start=1) pure nothrow @safe @nogc {
    y = -1 * y;
    immutable l = 2 * max(x.abs, y.abs);
    immutable d = (y > x) ? (l * 3 + x + y) : (l - x - y);
    return (l - 1) ^^ 2 + d + start - 1;
}

/// Range representing the coordinates of an Ulam spiral
struct Spiral
{
    private uint layer = 1;
    private uint leg;

    private int x;
    private int y;

    ///Return the current index
    @safe @nogc
    Tuple!(int, "x", int, "y") front() pure
    {
    	return tuple!("x", "y")(x, y);
    }

    ///Move to the next square
    @safe @nogc
    void popFront() pure
    {
        switch(leg){
        case 0: ++x; if(x  == layer)  ++leg;                break;
        case 1: ++y; if(y  == layer)  ++leg;                break;
        case 2: --x; if(-x == layer)  ++leg;                break;
        case 3: --y; if(-y == layer){ leg = 0; ++layer; }   break;
        default: assert(0);
        }
    }

    ///This is an infinite range.
    enum bool empty = false;
}

@safe @nogc
private Tuple!(int, "x", int, "y") findPosition(int number) pure
{
    return Spiral().drop(number - 1).front;
}

@safe @nogc
int manhattanDistance(int number) pure
{
    auto position = findPosition(number);
    return abs(position.x) + abs(position.y);
}