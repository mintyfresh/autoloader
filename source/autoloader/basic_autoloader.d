
module autoloader.basic_autoloader;

import autoloader.base;

import std.algorithm;
import std.conv;
import std.range;

class BasicAutoloader : Autoloader
{
private:
    string _basePath;
    string[] _searchPaths;

public:
    /++
     + Constructs an autoloader with a list of paths to search for classes.
     ++/
    this(string[] searchPaths)
    {
        _searchPaths = searchPaths;
    }

    /++
     + Constructs an autoloader with a base path to start searches from
     + and a list of child paths to include in the search.
     ++/
    this(string basePath, string[] searchPaths = [])
    {
        _basePath = basePath;
        _searchPaths = searchPaths;
    }

    /++
     + The base path to start searching from.
     ++/
    @property
    string basePath()
    {
        return _basePath;
    }

    /++
     + Takes a number of path segments and constructs a path string.
     ++/
    string join(string[] paths...)
    {
        return paths.filter!(p => p.length > 0).joiner(".").text;
    }

    /++
     + Tries to load a class given by name, searching through the registered paths.
     + This function does not cache located classes, hence the lookup is performed
     + for every call.
     +
     + Returns:
     +   The ClassInfo object of the class given by name, or null if not found.
     ++/
    override const(ClassInfo) lookup(string name)
    {
        foreach(path; [""].chain(searchPaths))
        {
            auto result = ClassInfo.find(join(basePath, path, name));
            if(result !is null) return result;
        }

        return null;
    }

    /++
     + The list of paths in which classes a searched for. If a base path is
     + present, this represents a list of child paths.
     ++/
    @property
    string[] searchPaths()
    {
        return _searchPaths;
    }
}
