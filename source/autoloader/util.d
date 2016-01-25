
module autoloader.util;

import std.regex;
import std.string;

/++
 + Converts a CamelCase string to lower_snake_case.
 ++/
@property
string toSnakeCase(string camelCase)
{
    static auto r1 = ctRegex!"(.)([A-Z][a-z]+)";
    static auto r2 = ctRegex!"(.)([0-9]+)";
    static auto r3 = ctRegex!"([a-z0-9])([A-Z])";

    return camelCase
        .replaceAll(r1, "$1_$2")
        .replaceAll(r2, "$1_$2")
        .replaceAll(r3, "$1_$2")
        .toLower;
}
