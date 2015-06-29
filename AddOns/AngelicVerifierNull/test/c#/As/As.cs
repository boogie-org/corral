using System.Diagnostics.Contracts;
class TestType
{
    public int a;
    public TestType()
    {
        a = 0;
    }
}

class SubType
{
    public int x;
    public SubType()
    {
        x = 7;
    }
}

class Test
{
    public static int Foo(object a)
    {
        var v = a as SubType;
        Contract.Assert(v != null);
        int s = v.x;
        return s;
    }

    public static int Bar(object a)
    {
        var v = a as TestType;
        Contract.Assert(v != null);
        int s = v.a;
        return s;
    }

    public static void Main()
    {
        TestType v1 = new TestType();
        Foo(v1);
        Bar(v1);
        return;
    }
}

