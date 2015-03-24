
procedure a()
{
    assert(false);
}

procedure {:entrypoint} main() 
{
    async call a();
    assert (false);
}
