procedure {:entrypoint} main() {
  var a: [int] int;
  var i: int;

  i := 0;
  while (i < 9) {
    a[i] := 2;
    i := i + 1;
  }

  i := 0;
  while (i < 10) {
    // When this assertion is omitted, minimum iterations are computed for
    // both loops (10 and 11), and the subsequent violation is found.
    assert a[i] == 2;
    i := i + 1;
  }

  assert false;
}
