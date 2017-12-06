import std.algorithm;
import std.math;
import std.range;
import std.stdio;
import std.typecons;

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

    Tuple!(int, int) front()
    {
    	return tuple(x, y);
    }

    void popFront(){
        switch(leg){
        case 0: ++x; if(x  == layer)  ++leg;                break;
        case 1: ++y; if(y  == layer)  ++leg;                break;
        case 2: --x; if(-x == layer)  ++leg;                break;
        case 3: --y; if(-y == layer){ leg = 0; ++layer; }   break;
        default: assert(0);
        }
    }

    bool empty()
    {
    	return false;
    }
}

//Tuple!(int, int) f(int index)
//{
//	int x, y, xMax, yMax;
//	bool movingLeft = true;
//	bool movingUp = true;
//	for(int i = 0; i < index; ++i)
//	{
//		if(abs(x) == xMax)
//		{
//			if(abs(y) == yMax)
//			{
//				movingUp = !movingUp;
//				++xMax
//			}
//		}
//	}

//	return tuple(x, y);
//}