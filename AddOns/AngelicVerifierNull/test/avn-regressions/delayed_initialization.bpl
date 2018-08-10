

type Ref;
const unique null : Ref;
var r1 : Ref;

procedure {:ProgramInitialization} init_globals() {
  r1 := null;
}

procedure Foo() {
  assert r1 == null;
}




