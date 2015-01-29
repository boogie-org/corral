const {:allocated} NULL: int;
axiom NULL == 0;

//typestate
var isValid:[int]bool;

//mem
var mem:[int]int;


//Probe function
procedure Probe(a:int, size:int)
{
  var t:int;
  //assert !isValid[a]; 
  if (isValid[a]) {
     t := t + 1; //throw error
  }
  isValid[a] := true; //easier to write than a modifies with quantifiers or map updates  
}

//Access functions
procedure Access(a:int){
   assert isValid[a];
}

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


procedure {:entrypoint} Entry4({:pointer} a: int, b:int)
{
  call Access(a); //OK to flag 
  call Probe(a, b);
  call Access(a);
}


//stub
procedure Kernel1(a:int) returns (b:int);
//stub: can be a source of user land
procedure User1(a:int) returns (b:int);


procedure {:allocator "full"} malloc_full(s:int) returns (a:int);
procedure {:allocator}  malloc(s:int) returns (a:int);

