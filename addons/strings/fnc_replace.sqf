/* ----------------------------------------------------------------------------
Function: CBA_fnc_replace

Description:
    Replaces substrings within a string. Case-dependent.

Parameters:
    _string - String to make replacement in [String]
    _pattern - Substring to replace [String]
    _replacement - String to replace the _pattern with [String]

Returns:
    String with replacements made [String]

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", "fro", "pi"] call CBA_fnc_replace;
        // => "Fish pig cheese pimage"
    (end)

Author:
    jaynus
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(replace);

// ----------------------------------------------------------------------------

PARAMS_3(_string,_pattern,_replacement);
private["_i", "_cp", "_findIndex", "_stringArray", "_replaceArray", "_returnArray"];

_returnArray  = [];
_cp           = count _pattern;
_stringArray  = toArray _string;
_replaceArray = toArray _replacement;

_findIndex    = _string find _pattern;
while { _findIndex != -1 } do {
    _i = 0;
    while { _i < _findIndex } do {
        _returnArray pushBack (_stringArray select _i);
        _i = _i + 1;
    };
    _returnArray append _replaceArray;
    _stringArray deleteRange [0, _i + _cp];

    _string = toString _stringArray;
    _findIndex = _string find _pattern;
};
_returnArray append _stringArray;
toString _returnArray
