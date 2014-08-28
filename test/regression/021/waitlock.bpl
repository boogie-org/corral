var x: int;

var $threadStatus: [int]int;
//const unique $uninitialized: int;
//const unique $running: int;
//const unique $stopped: int;
const $uninitialized: int;
axiom $uninitialized == 0;
const $running: int;
axiom $running == 1;
const $stopped: int;
axiom $stopped == 2;

var mylock: int;

procedure corral_atomic_begin();
procedure corral_atomic_end();
procedure corral_getThreadID() returns (x: int);

procedure wait(pthread: int)
{
    assume $threadStatus[pthread] == $stopped;
}

procedure lock()
  modifies mylock;
{
    var tid: int;
    var a: bool;

    call corral_atomic_begin();
    call tid := corral_getThreadID();
    a := tid != mylock;
    assume mylock == 0;
    mylock := tid;
    call corral_atomic_end();
    assert a;
}

procedure unlock()
  modifies mylock;
{
    var tid: int;
    var a: bool;

    call corral_atomic_begin();
    call tid := corral_getThreadID();
    a := tid == mylock;
    mylock := 0;
    call corral_atomic_end();
    assert a;
}

procedure spawn_foo(pthread: int)
  modifies $threadStatus;
{
  var tt: int;
A:
    $threadStatus[pthread] := $running;
    call foo();
    $threadStatus[pthread] := $stopped;
}

procedure foo() 
  modifies x;
{
    var y: int;
    call lock();
    y := x;
    x := y + 5;
    call unlock();
}

procedure {:entrypoint} main()
  modifies x, mylock, $threadStatus;
{
    //assume (forall y:int :: $threadStatus[y] == $uninitialized);
    assume $threadStatus[1] == 0;
    x := 10;
    mylock := 0;
    async call spawn_foo(1);
    call lock();
    x := x + 7;
    call unlock();
    call wait(1);
    
    assert x == 22;
}
