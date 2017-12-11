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

//@safe
unittest
{
    assert(10 == summedCell(5));
    assert(147 == summedCell(142));
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

///
@safe @nogc
int manhattanDistance(int number) pure
{
    auto position = findPosition(number);
    return abs(position.x) + abs(position.y);
}

///
int summedCell(int target)// pure @safe
{
    int cellValue;
    int[100][100] cells;
    cells[50][50] = 1;
    foreach(coord; Spiral().dropOne.take(100 * 100 - 1))
    {
        coord = tuple(coord.x + 50, coord.y + 50);
        with(coord)
        {
            cells[x][y] = cells[x + 1][y]
                        + cells[x + 1][y + 1]
                        + cells[x + 1][y - 1]
                        + cells[x - 1][y]
                        + cells[x - 1][y + 1]
                        + cells[x - 1][y - 1]
                        + cells[x][y + 1]
                        + cells[x][y - 1]
                        ;
            cellValue = cells[x][y];

            if(cellValue > target)
                break;
        }
    }
    return cellValue;
}