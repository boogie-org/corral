// ..\angelicverifierNull\bin\debug\angelicVerifierNull.exe paper_probe.bpl /noAA /deadCodeDetection /noAllocation /EE:noFilters+ 

const {:allocated} NULL: int;
axiom NULL == 0;
procedure {:allocator "full"} malloc_full(s:int) returns (a:int);
procedure {:allocator}  malloc(s:int) returns (a:int);


//typestate
var isUser:[int]bool;
//mem
var mem:[int]int;


//Probe function
procedure Probe(a:int, size:int)
{
  var t:int; //tmp
  //assert !isUser[a]; 
  if (!isUser[a]) {
     t := t + 1;//deadcode in else
  }
  isUser[a] := false; 
}

//Access functions
procedure Access(a:int){
   assert !isUser[a];
}
 
procedure {:entrypoint} Entry4({:pointer} a: int, b:int)
{
  call Access(a); //OK to flag after relax
  call Probe(a, b);
  call Access(a);
}

/*

//stub
procedure Kernel1(a:int) returns (b:int);
//stub: can be a source of user land
procedure User1(a:int) returns (b:int);


//an entry point
procedure {:entrypoint} Entry1({:pointer} a: int, b:int)
{
  var x,y: int;

  if (b > 0) {
      call Probe(a, b);	
  } 	
  call Access(a); //OK to flag if spec vocab does not contain disjunction
}

//an entry point
procedure {:entrypoint} Entry2({:pointer} a: int, b:int)
{
  var x:int;
  call x := Kernel1(a);
  call Access(x); //don't flag as a spec should suppress it
}

procedure {:entrypoint} Entry3({:pointer} a: int, b:int)
{
  var x,y: int;
  call y := User1(a); 
  if (mem[b] == NULL) {
     call Probe(y, 0);	
  } 
  call Access(y); //OK to flag if spec vocab does not contain disjunction
}

*/


