
var balance:int;
var stopped: [int]bool;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_thread_join(x:int);

procedure cba_thread_deposit(d: int) 
modifies balance;
{
   var temp: int;
   call corral_atomic_begin();
   temp := balance;
   temp := temp + d;
   balance := temp; 
   call corral_atomic_end();

   stopped[0] := true;
}

procedure cba_thread_withdraw(d: int) 
modifies balance;
{
   var temp: int;
   call corral_atomic_begin();
   temp := balance;
   temp := temp - d;
   balance := temp; 
   call corral_atomic_end();

   stopped[1] := true;
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

   stopped[0] := false;
   stopped[1] := false;

   async call cba_thread_deposit(d);
   async call cba_thread_withdraw(d);

   if(flag) {
      assume stopped[0];
      assume stopped[1];
   }

   nb := balance;
   assert nb == original;
}

