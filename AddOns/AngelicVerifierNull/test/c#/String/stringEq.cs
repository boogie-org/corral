using System.Diagnostics.Contracts;


class Test
{
    public static void Main()
    {
        int s = 0, t = 0;
        string str = "Hello";
        if (str == "Hello")
        {
            s++;
        }
        else
        {
            t++;
        }
        Contract.Assert(s == 0);
        Contract.Assert(t == 0);
        Contract.Assert(s == 0 || t == 0);
    }
}
