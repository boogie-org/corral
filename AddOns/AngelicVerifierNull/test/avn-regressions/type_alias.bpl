
type Union;
type Ref = Union;

const unique r1 : Ref;
const unique null : Ref;
var m : [int] Ref;

procedure Foo(r : int) {
  assert m[r] != r1;
}
