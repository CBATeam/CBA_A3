#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_leftTrim

Description:
    Trims specified characters (all whitespace by default) from the left end of a string.

    See <CBA_fnc_rightTrim> and <CBA_fnc_trim>.

Parameters:
    _string - String to trim [String]
    _trim - Characters to trim [String] (default: "")

Returns:
    Trimmed string [String]

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_leftTrim;
        // _result => "frogs are fishy   "
    (end)

Author:
    Spooner, joko // Jonas, SilentSpike
---------------------------------------------------------------------------- */
#include "script_strings.hpp"

SCRIPT(leftTrim);

// ----------------------------------------------------------------------------

params ["_string", ["_trim", "", [""]]];

private _chars = toArray _string;
private _numChars = count _chars;

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

toString (_chars select [_trimIndex, _numChars - _trimIndex])
