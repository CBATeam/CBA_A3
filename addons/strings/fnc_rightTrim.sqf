/* ----------------------------------------------------------------------------
Function: CBA_fnc_rightTrim

Description:
    Trims specified characters (all whitespace by default) from the right end of a string.

    See <CBA_fnc_leftTrim> and <CBA_fnc_trim>.

Parameters:
    _string - String to trim [String]
    _trim - Characters to trim [String] (default: "")

Returns:
    Trimmed string [String]

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_rightTrim;
        // _result => " frogs are fishy"
    (end)

Author:
    Spooner, joko // Jonas, SilentSpike
---------------------------------------------------------------------------- */

#include "script_component.hpp"
#include "script_strings.hpp"

SCRIPT(rightTrim);

// ----------------------------------------------------------------------------

params ["_string", ["_trim", "", [""]]];

private _chars = toArray _string;
private _numChars = count _chars;

// Trim from the right
reverse _chars;

// Trim all whitespace characters by default
if (_trim == "") then {
    _trim = WHITE_SPACE;
} else {
    _trim = toArray _trim;
};

// We have to process the string in array form because it could differ in length (if there are non-ASCII characters)
private _trimIndex = count _chars;
{
    if !(_x in _trim) exitWith { _trimIndex = _forEachIndex; };
} forEach _chars;

// Convert string back to original order
reverse _chars;

toString (_chars select [0, _numChars - _trimIndex])
