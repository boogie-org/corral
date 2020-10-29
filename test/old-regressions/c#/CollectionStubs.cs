//Only parts of Poirot.cs Stubs.cs that influence a collection

using System.Diagnostics.Contracts;
using System.Collections;
using System.Collections.Generic;

namespace Poirot {
  using System;

  public class Poirot {
    public static int NondetInt() { return 0; }
    public static string NondetString() { return null; }
    public static Object NondetObject() { return null; }
  }

}


namespace System {
  public class Random {
    public int Next() {
      int x = Poirot.Poirot.NondetInt();
      Contract.Assume(0 <= x);
      return x;
    }
    public int Next(int a) {
      int x = Poirot.Poirot.NondetInt();
      Contract.Assume(a <= x);
      return x;
    }
    public int Next(int a, int b) {
      int x = Poirot.Poirot.NondetInt();
      Contract.Assume(a <= x && x < b);
      return x;
    }
  }

}

namespace System.Collections.Generic
{
    public abstract class List<T> : IEnumerable<T>
    {
	struct Enumerator : IEnumerator<T> {
	      List<T> parent;
	      int iter;
	      public Enumerator(List<T> l) { 
	          parent = l; 
		  iter = -1; 
	      }
	      public bool MoveNext() { 
	          iter = iter + 1; 
		  return (iter < parent.Count);
	      }
	      public T Current { get { return parent[iter]; } }
	      public void Dispose() {}
	      public void Reset() { iter = -1; }
              object System.Collections.IEnumerator.Current { get { return this.Current; } }
	}

        private List(bool dontCallMe) { }
        public IEnumerator<T> GetEnumerator() { return new Enumerator(this); }
        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() { return this.GetEnumerator(); }
	public abstract T this[int index] { get; set; }
	public abstract int Count { get; }
    }

    public abstract class HashSet<T> : IEnumerable<T>
    {
	struct Enumerator : IEnumerator<T> {
	      HashSet<T> parent;
	      int iter;
	      T currentElem;
	      HashSet<T> currentSet;
	      public Enumerator(HashSet<T> h) { 
	          parent = h; 
		  iter = -1; 
		  currentSet = parent.New();
		  currentElem = default(T);
	      }
	      public bool MoveNext() { 
	          iter = iter + 1; 
		  if (iter >= parent.Count) 
		      return false;
		  currentElem = parent.Random();
		  Contract.Assume(parent.Contains(currentElem) && !currentSet.Contains(currentElem));
		  currentSet.Add(currentElem);
		  return true;
	      }
	      public T Current { get { return currentElem; } }
	      public void Dispose() {}
	      public void Reset() {
	          iter = -1;
   		      currentSet = parent.New();
          }
          object System.Collections.IEnumerator.Current { get { return this.Current; } }
	}

        private HashSet(bool dontCallMe) { }
        public IEnumerator<T> GetEnumerator() { return new Enumerator(this); }
        System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() { return this.GetEnumerator(); }
	public abstract int Count { get; }
	public abstract bool Add(T t);	
	public abstract bool Contains(T t);
	public abstract T Random();
	public abstract HashSet<T> New();
    }
}
