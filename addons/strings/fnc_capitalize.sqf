#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_capitalize

Description:
    Upper case the first letter of the string, lower case the rest.

Parameters:
    _string - String to capitalize [String]

Returns:
    Capitalized string [String].

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

// ----------------------------------------------------------------------------

params ["_string"];

private _charCount = count _string;
if (_charCount > 0) then {
    // Take first Char and Upper case
    private _string1 = (toUpper _string) select [0, 1];
    // Take rest and lower it
    private _string2 = (toLower _string) select [1];
    // Compile String
    _string = _string1 + _string2;
};

_string; // Return.
