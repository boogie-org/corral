using System;
using System.Threading;
using System.Diagnostics.Contracts;
using System.Collections.Generic;

interface Random
{
    int RandomInt();
}

class PoirotMain
{
    static Random r;

    public static void Main()
    {
        int i;
        HashSet<int> intSet = new HashSet<int>();
        intSet.Add(0);
        intSet.Add(1);
        i = r.RandomInt();
        Contract.Assume(intSet.Contains(i));
        Contract.Assert(i == 0 || i == 1);
        intSet.Remove(0);
        i = r.RandomInt();
        Contract.Assume(intSet.Contains(i));
        Contract.Assert(i == 1);
        int sum = 0;
        foreach (int x in intSet)
        {
            sum += x;
        }
        Contract.Assert(sum == 1);
        Contract.Assert(intSet.Contains(0));
    }

}
