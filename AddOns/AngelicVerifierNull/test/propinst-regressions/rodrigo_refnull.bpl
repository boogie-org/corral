type Ref;

const unique null : Ref;
var r: Ref;

procedure Foo() {
  r := null;
  assume {:nonnull} r != null;
}
