
var balance:int;
var t1done:bool;
var t2done:bool;

procedure corral_atomic_begin();
procedure corral_atomic_end();

procedure cba_thread_deposit(d: int)
modifies balance, t1done;
{
   var temp: int;
   temp := balance;
   temp := temp + d;
   balance := temp; 
   
   t1done := true;
}

procedure cba_thread_withdraw(d: int)
modifies balance, t2done;
{
   var temp: int;
   temp := balance;
   temp := temp - d;
   balance := temp; 

   t2done := true;
}

procedure cba_thread_check(original:int)
{

   if(t1done && t2done) {
      assert balance == original;
   }
}


procedure main()
modifies balance, t1done, t2done;
{
   var original: int;
   var d: int;

   call corral_atomic_begin();
   t1done := false;
   t2done := false;
   balance := original;
   call corral_atomic_end();

   async call cba_thread_deposit(d);
   async call cba_thread_withdraw(d);
   async call cba_thread_check(original);

}

