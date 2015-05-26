procedure {:entrypoint} Main() {
  var a: int ;
  if (*) {
	  call a := unknown(1) ;
	  call foo(a);
  }
  else {
  	call bar() ;
  }
}

procedure bar()
{
  call foo(0);
}

procedure foo(a: int)
{
   if(a == 0) {
     call foo(1);
   }
   assert false;
}

const NULL: int;
axiom NULL == 0;
procedure {:AngelicUnknown} unknown(a:int) returns (b:int);
