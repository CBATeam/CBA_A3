/* ----------------------------------------------------------------------------
Function: CBA_fnc_leftTrim

Description:
    Trims white-space (space, tab, newline) from the left end of a string.

    See <CBA_fnc_rightTrim> and <CBA_fnc_trim>.

Parameters:
    _string - String to trim [String]

Returns:
    Trimmed string [String]

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_leftTrim;
        // _result => "frogs are fishy   "
    (end)

Author:
    Spooner, joko // Jonas
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_strings.hpp"

SCRIPT(leftTrim);

// ----------------------------------------------------------------------------

params ["_string"];

private ["_chars","_charCount"];

// Convert String to Array for Find White Spaces
_chars = ToArray _string;
// count String input
_charCount = count _string;

if (_charCount > 0) then {
    private "_numWhiteSpaces";
    // Set Base number for White Spaces
    _numWhiteSpaces = _charCount;

    // find Last White Space
    for "_i" from 0 to (_charCount - 1) do {
        if !((_chars select _i) in WHITE_SPACE) exitWith { _numWhiteSpaces = _i };
    };
    // if a White space exist than they are deselected
    if (_numWhiteSpaces > 0) then {
        _string = _string select [_numWhiteSpaces];
    };
};

_string; // Return.
