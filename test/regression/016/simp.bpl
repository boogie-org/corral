procedure OuterStructContainer.#ctor()

{

}

procedure PoirotMain1.Pass4()

{

assert false;

}

procedure PoirotMain1.Pass5()

{

call OuterStructContainer.#ctor();

assert false;

}

procedure {:entrypoint} PoirotMain.Main()

{

call PoirotMain1.Pass4();

call PoirotMain1.Pass5();

}


