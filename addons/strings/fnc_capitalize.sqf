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

params [["_string", "", [""]]];

if (_string isEqualTo "") exitWith {""};

// Detect if and how unicode support was forced
private _unicode = count "д" == 1;
private _forceUnicode = count "д" == 1;

// Force unicode support
forceUnicode 0;

// Take first character and convert to upper case
private _string1 = toUpper (_string select [0, 1]);

// Take rest and convert to lower case
private _string2 = toLower (_string select [1]);

// Compile string
_string = _string1 + _string2;

// Revert unicode support if necessary
switch (true) do {
    // Force unicode (already has been, so don't do it again)
    case (_forceUnicode): {};
    // Unicode flag is reset right after any of the supported commands executed or the end of script, whichever comes earlier
    case (_unicode): {forceUnicode 1};
    // Reset unicode flag
    default {forceUnicode -1};
};

_string // return
