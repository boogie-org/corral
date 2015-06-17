using System.Diagnostics.Contracts;

public abstract class AbsClass {
    public int x;
}

public class TestClass : AbsClass
{
    public int y;
}

public class SubClass : TestClass
{
    public int z;
}

class Test
{
    public static int foo(AbsClass obj)
    {
        var v = (obj as TestClass);
        Contract.Assert(v != null);
        return v.y + v.x;
    }

    public static int bar(AbsClass obj)
    {
        var v = (obj as SubClass);
        Contract.Assert(v != null);
        return v.y + v.z;
    }

    public static void Main(string[] args)
    {
        TestClass t = new TestClass();
        var s = (t as AbsClass);
        foo(s);
        bar(s);
    }
}
