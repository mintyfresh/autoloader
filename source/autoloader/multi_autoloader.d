
module autoloader.multi_autoloader;

import autoloader.base;

class MultiAutoloader : Autoloader
{
private:
    Autoloader[] _autoloaders;

public:
    /++
     + Constructs an autoloader that defers lookup to the given autoloaders.
     ++/
    this(Autoloader[] autoloaders)
    {
        _autoloaders = autoloaders;
    }

    /++
     + The list of autoloaders that are wrapped by this multiloader.
     ++/
    @property
    Autoloader[] autoloaders()
    {
        return _autoloaders;
    }

    /++
     + Tries to load a class given by name, deferring to the wrapped autoloaders
     + in the order that they were given in during construction.
     +
     + Returns:
     +   The ClassInfo object of the class given by name, or null if not found.
     ++/
    override const(ClassInfo) lookup(string name)
    {
        foreach(autoloader; autoloaders)
        {
            auto result = autoloader.lookup(name);
            if(result !is null) return result;
        }

        return null;
    }
}
