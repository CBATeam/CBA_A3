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
    BaerMitUmlaut
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(replace);

params [["_string", "", [""]], ["_find", "", [""]], ["_replace", "", [""]]];
if (_find == "") exitWith {_string}; // "1" find "" -> 0
private _result = "";
private _offset = count (_find splitString "");

while {_string find _find != -1} do {
    private _index = _string find _find;
    _result = _result + (_string select [0, _index]) + _replace;
    _string = _string select [_index + _offset];
};

_result + _string
