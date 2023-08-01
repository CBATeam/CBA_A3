#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_capitalize

Description:
    Upper case the first letter of the string, lower case the rest.

Parameters:
    _string - String to capitalize <STRING>

Returns:
    Capitalized string <STRING>

Examples:
    (begin example)
        _result = ["FISH"] call CBA_fnc_capitalize;
        // _result => "Fish"

        _result = ["frog-headed fish"] call CBA_fnc_capitalize;
        // _result => "Frog-headed fish"
    (end)

Author:
    Spooner, joko // Jonas
---------------------------------------------------------------------------- */
SCRIPT(capitalize);

forceUnicode 0;

params [["_string", "", [""]]];

if (_string isNotEqualTo "") then {
    // Take first character and Upper case
    private _string1 = toUpper (_string select [0, 1]);

    // Take rest and lower it
    private _string2 = toLower (_string select [1]);

    // Compile string
    _string = _string1 + _string2;
};

_string // return
