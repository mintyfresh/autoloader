
import autoloader;

void main()
{
    auto loader = new BasicAutoloader(["foo", "bar"]);

    // Some simple autoloader tests.
    assert(loader.create("FooProvider") !is null);
    assert(loader.create("BARProvider") !is null);
    assert(loader.create("BarProvider")  is null);
}
