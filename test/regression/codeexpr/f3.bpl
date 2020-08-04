procedure {:entrypoint} main() {
  assert $expr();
}

function {:inline} $expr() returns (bool) {
|{
  var r: bool;
entry:
  r := true;
  return r;
}|
}
