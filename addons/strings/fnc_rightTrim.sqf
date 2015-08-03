/* ----------------------------------------------------------------------------
Function: CBA_fnc_rightTrim

Description:
    Trims white-space (space, tab, newline) from the right end of a string.

    See <CBA_fnc_leftTrim> and <CBA_fnc_trim>.

Parameters:
    _string - String to trim [String]

Returns:
    Trimmed string [String]

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_rightTrim;
        // _result => " frogs are fishy"
    (end)

Author:
    Spooner
    joko // Jonas
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_strings.hpp"

SCRIPT(rightTrim);

// ----------------------------------------------------------------------------

PARAMS_1(_string);

private ["_char","_charCount", "_charCount2", "_pos","_numWhiteSpaces"];
// Convert String to Array for Find White Spaces
_char = toArray _string;
// Count String Lenth
_charCount = count _string;
// substract 1 for faster for(L43)
_charCount2 = _charCount - 1;

// find White Spaces and count than
for "_i" from _charCount2 to 0 step -1 do {
    if !((_char select _i) in WHITE_SPACE) exitWith { _numWhiteSpaces = _charCount2 - _i };
};
// select Only None White Space Part
_string select [0,_charCount - _numWhiteSpaces]; // Return.
