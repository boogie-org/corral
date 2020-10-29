void foo(int* x)
{
  delete x;
  x = 0;
  delete x;
}
