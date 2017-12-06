import std.algorithm;
import std.math;
import std.range;
import std.stdio;
import std.typecons;

@safe
unittest
{
    assert(tuple(1,0) == Spiral().drop(1).front);
    assert(tuple(1,1) == Spiral().drop(2).front);
    assert(tuple(0,1) == Spiral().drop(3).front);
    assert(tuple(-1,1) == Spiral().drop(4).front);
    assert(tuple(-1,0) == Spiral().drop(5).front);
    assert(tuple(-1,-1) == Spiral().drop(6).front);
}

struct Spiral
{
    private uint layer = 1;
    private uint leg;

    private int x;
    private int y;

    @safe @nogc
    Tuple!(int, int) front() pure
    {
    	return tuple(x, y);
    }

    @safe @nogc
    void popFront()
    {
        switch(leg){
        case 0: ++x; if(x  == layer)  ++leg;                break;
        case 1: ++y; if(y  == layer)  ++leg;                break;
        case 2: --x; if(-x == layer)  ++leg;                break;
        case 3: --y; if(-y == layer){ leg = 0; ++layer; }   break;
        default: assert(0);
        }
    }

    @safe @nogc
    bool empty() pure
    {
    	return false;
    }
}

