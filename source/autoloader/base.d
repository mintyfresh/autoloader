
module autoloader.base;

abstract class Autoloader
{
private:
    /++
     + Cached ClassInfo objects.
     ++/
    ClassInfo[string] _cache;

public:
    /++
     + Loads and constructs an Object given by name.
     + Optionally casts the Object to a type given by template parameter.
     +
     + Returns:
     +   The newly created Object, or null if not found or the cast failed.
     ++/
    T create(T : Object = Object)(string name)
    {
        auto result = load(name);

        if(result !is null)
        {
            return cast(T) result.create;
        }
        else
        {
            return null;
        }
    }

    /++
     + Tries to load a class given by name, searching through the registered paths.
     + This function calls lookup internally, but caches results once found.
     +
     + Returns:
     +   The ClassInfo object of the class given by name, or null if not found.
     ++/
    const(ClassInfo) load(string name)
    {
        auto cachePtr = name in _cache;

        if(cachePtr !is null)
        {
            return cast(const) *cachePtr;
        }
        else
        {
            const(ClassInfo) result = lookup(name);
            if(result) _cache[name] = cast(ClassInfo) result;

            return result;
        }
    }

    /++
     + Tries to load a class given by name. This function does not cache located
     + classes, hence the lookup is performed for every call.
     +
     + Returns:
     +   The ClassInfo object of the class given by name, or null if not found.
     ++/
    abstract const(ClassInfo) lookup(string name);

    /++
     + Clears any cached results.
     ++/
    void purgeCache()
    {
        _cache = typeof(_cache).init;
    }
}
