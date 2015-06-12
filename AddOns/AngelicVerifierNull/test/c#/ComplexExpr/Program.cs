using System;
using System.Diagnostics.Contracts;

class PoirotMain
{
    static string a1, b1, c1, a2, b2, c2;
    public static void Main()
    {
        a2 = "Hello";
        b2 = "World";
        a1 = a2;
        b1 = b2;
        c1 = c2;
	bool x = ( (a1 == a2) &&
                           (b1 == b2) &&
                           (c1 == c2)
                       );
        bool y = ( (a1 == b2) || 
            (!(c1 == c2)) );
    Contract.Assert(x);
    Contract.Assert(y);
    } 

}
