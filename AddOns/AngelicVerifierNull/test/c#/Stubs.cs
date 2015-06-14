using System.Diagnostics.Contracts;
using System.Collections;
using System.Collections.Generic;

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

  abstract class Type : Reflection.MemberInfo {
    public static bool operator ==(Type left, Type right) {
      return ((object)left == (object)right);
    }
    public static bool operator !=(Type left, Type right) {
      return ((object)left != (object)right);
    }
  }

  namespace Threading {
    public class WaitHandle : MarshalByRefObject, IDisposable {
      public virtual bool WaitOne() {// This method *is* a stub for System.Threading.WaitHandle.WaitOne
        var t = this.GetType();
        if (t == typeof(ManualResetEvent))
          return ManualResetEvent.WaitOne((ManualResetEvent)this);
        else if (t == typeof(AutoResetEvent))
          return AutoResetEvent.WaitOne((AutoResetEvent)this);
        else if (t == typeof(Mutex))
          return Mutex.WaitOne((Mutex)this);
        else
          Contract.Assume(false);
        return true;
      }

      public void Dispose() {}
    }

    public class EventWaitHandle : WaitHandle {
      protected bool Signaled;

      public bool Set() {
        Signaled = true;
	return true;
      }
    }

    public class ManualResetEvent : EventWaitHandle {
      public ManualResetEvent(bool b) {
        Signaled = b;
      }

      // NOTE: This method is *not* a stub because there is no method
      // System.Threading.ManualResetEvent.WaitOne.
      // If you want to call it from within stub code, then it must be called directly.
      // It must take an argument of type Stub.ManualResetEvent because otherwise
      // the field Signaled doesn't exist.
      //
      public static bool WaitOne(ManualResetEvent @this) {
        Contract.Assume(@this.Signaled);
        return true;
      }
    }

    public class AutoResetEvent : EventWaitHandle {
      public AutoResetEvent(bool b) {
        Signaled = b;
      }

      // NOTE: This method is *not* a stub because there is no method
      // System.Threading.AutoResetEvent.WaitOne.
      // If you want to call it from within stub code, then it must be called directly.
      // It must take an argument of type Stub.AutoResetEvent because otherwise
      // the field Signaled doesn't exist.
      //
      public static bool WaitOne(AutoResetEvent @this) {
        Poirot.Poirot.BeginAtomic();
        Contract.Assume(@this.Signaled);
	@this.Signaled = false;
	Poirot.Poirot.EndAtomic();
        return true;
      }
    }

    public class Mutex : WaitHandle {
      protected int ReentrancyCount;
      protected int Owner;
      
      public Mutex() {
        ReentrancyCount = 0;
	Owner = 0;
      }

      // NOTE: This *is* a stub method because there *is* a method System.Threading.Mutex.ReleaseMutex
      public void ReleaseMutex() {
        int tid = Poirot.Poirot.CurrentThreadId();
        // Contract.Assert(0 < ReentrancyCount && tid == Owner);
	Poirot.Poirot.BeginAtomic();
        ReentrancyCount = ReentrancyCount - 1;
	if (ReentrancyCount == 0)
	  Owner = 0;
        Poirot.Poirot.EndAtomic();
      }

      // NOTE: This method is *not* a stub because there is no method System.Threading.Mutex.WaitOne
      // If you want to call it from within stub code, then it must be called directly
      public static bool WaitOne(Mutex @this) {
        int tid = Poirot.Poirot.CurrentThreadId();
        Poirot.Poirot.BeginAtomic();
	Contract.Assume(@this.Owner == 0 || @this.Owner == tid);
	@this.Owner = tid;
	@this.ReentrancyCount = @this.ReentrancyCount + 1;
        Poirot.Poirot.EndAtomic();
        return true;
      }
    }
  }
}

namespace System.Linq {
     public static class Enumerable {
        public static int Sum(this IEnumerable<int> source) {
	    int sum = 0;
	    var e = source.GetEnumerator();
	    while (e.MoveNext()) {
	        sum += e.Current;
	    }
	    return sum;
	}

        public static int Sum<TSource>(this IEnumerable<TSource> source, Func<TSource, int> selector) {
	    int sum = 0;
	    var e = source.GetEnumerator();
	    while (e.MoveNext()) {
	        sum += selector(e.Current);
	    }
	    return sum;
	}

	class SelectEnumerable<T,U> : IEnumerable<U> {
	      private IEnumerable<T> origEnum;
	      private Func<T,U> func;
	      public SelectEnumerable(IEnumerable<T> origEnum, Func<T,U> func) { this.origEnum = origEnum; this.func = func; }
	      public IEnumerator<U> GetEnumerator() { return new SelectEnumerator<T,U>(this.origEnum.GetEnumerator(), this.func); }
              System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() { return this.GetEnumerator(); }
	}

	class SelectEnumerator<T,U> : IEnumerator<U> {
              private IEnumerator<T> currentEnumerator;
	      private Func<T,U> func;
	      public SelectEnumerator(IEnumerator<T> origEnum, Func<T,U> func) { this.currentEnumerator = origEnum; this.func = func; }
	      public bool MoveNext() { return this.currentEnumerator.MoveNext(); }
	      public U Current { get { return this.func(this.currentEnumerator.Current); } }
	      public void Dispose() {}
	      public void Reset() { this.currentEnumerator.Reset(); }
              object System.Collections.IEnumerator.Current { get { return this.Current; } }
	}

        public static IEnumerable<TResult> Select<TSource, TResult>(this IEnumerable<TSource> source, Func<TSource, TResult> selector) {
	       return new SelectEnumerable<TSource, TResult>(source, selector);
        }

	class WhereEnumerable<T> : IEnumerable<T> {
	      private IEnumerable<T> origEnum;
	      private Func<T,bool> func;
	      public WhereEnumerable(IEnumerable<T> origEnum, Func<T,bool> func) { this.origEnum = origEnum; this.func = func; }
	      public IEnumerator<T> GetEnumerator() { return new WhereEnumerator<T>(this.origEnum.GetEnumerator(), this.func); }
              System.Collections.IEnumerator System.Collections.IEnumerable.GetEnumerator() { return this.GetEnumerator(); }
	}

	class WhereEnumerator<T> : IEnumerator<T> {
              private IEnumerator<T> currentEnumerator;
	      private Func<T,bool> func;
	      public WhereEnumerator(IEnumerator<T> origEnum, Func<T,bool> func) { this.currentEnumerator = origEnum; this.func = func; }
	      public bool MoveNext() { 
	      	  while (true) { 
		      bool b = this.currentEnumerator.MoveNext(); 
		      if (!b || this.func(this.currentEnumerator.Current)) {
		          return b;
  		      }
		  }
	      }
	      public T Current { get { return this.currentEnumerator.Current; } }
	      public void Dispose() {}
	      public void Reset() { this.currentEnumerator.Reset(); }
              object System.Collections.IEnumerator.Current { get { return this.Current; } }
	}

	public static IEnumerable<TSource> Where<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate) {
	       return new WhereEnumerable<TSource>(source, predicate);
	}

        public static TSource First<TSource>(this IEnumerable<TSource> source) {
	       IEnumerator<TSource> enumerator = source.GetEnumerator();
	       if (enumerator.MoveNext()) {
	           return enumerator.Current;
	       }
	       throw new System.InvalidOperationException();
	}

        public static TSource FirstOrDefault<TSource>(this IEnumerable<TSource> source) {
	       IEnumerator<TSource> enumerator = source.GetEnumerator();
	       if (enumerator.MoveNext()) {
	           return enumerator.Current;
	       }
	       return default(TSource);
	}

        public static TSource FirstOrDefault<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate) {
	       IEnumerator<TSource> enumerator = source.GetEnumerator();
	       while (enumerator.MoveNext()) {
	           if (predicate(enumerator.Current))
	               return enumerator.Current;
	       }
	       return default(TSource);
	}

        public static TSource SingleOrDefault<TSource>(this IEnumerable<TSource> source) {
	       IEnumerator<TSource> enumerator = source.GetEnumerator();
	       TSource elem = default(TSource);
	       if (!enumerator.MoveNext()) {
	           return elem;
	       }
	       elem = enumerator.Current;
	       if (!enumerator.MoveNext()) {
	           return elem;
	       }
	       throw new System.InvalidOperationException();
	}

        public static TSource SingleOrDefault<TSource>(this IEnumerable<TSource> source, Func<TSource, bool> predicate) {
	       IEnumerator<TSource> enumerator = source.GetEnumerator();
	       TSource elem = default(TSource);
	       bool found = false;
	       while (enumerator.MoveNext()) {
	           if (!predicate(enumerator.Current)) continue;
		   if (found) throw new System.InvalidOperationException();
	           elem = enumerator.Current;
		   found = true;
	       }
               return elem;
	}

     }
}

namespace System.Collections.Generic
{
    public abstract class List<T> : IEnumerable<T>
    {
	struct ListEnumerator : IEnumerator<T> {
	      List<T> parent;
	      int iter;
	      public ListEnumerator(List<T> l) { 
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
        public IEnumerator<T> GetEnumerator() { return new ListEnumerator(this); }
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