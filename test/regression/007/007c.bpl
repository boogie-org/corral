
var balance:int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_thread_join(x:int);
procedure corral_thread_join_all();

procedure cba_thread_deposit(d: int) returns (ret:int)
modifies balance;
{
   var temp: int;
   call corral_atomic_begin();
   temp := balance;
   temp := temp + d;
   balance := temp; 
   call corral_atomic_end();
}

procedure cba_thread_withdraw(d: int) returns (ret:int)
modifies balance;
{
   var temp: int;
   call corral_atomic_begin();
   temp := balance;
   temp := temp - d;
   balance := temp; 
   call corral_atomic_end();
}


procedure main()
modifies balance;
{
   var original: int;
   var nb:int;
   var d: int;
   var flag: bool;
   var t1: int;
   var t2: int;

   call corral_atomic_begin();
   flag := true;
   balance := original;
   call corral_atomic_end();

   async call t1 := cba_thread_deposit(d);
   async call t2 := cba_thread_withdraw(d);

   call corral_thread_join_all();

   nb := balance;
   assert nb == original;
}

