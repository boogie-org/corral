
type Union;
type Ref = Union;

const unique r1 : Ref;
const unique null : Ref;
var m : [Ref] Ref;

procedure Foo(r : Ref) {
  assert m[r] != r1;
}
