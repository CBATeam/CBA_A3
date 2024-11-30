#include "script_component.hpp"
#include "script_strings.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_leftTrim

Description:
    Trims specified characters (all whitespace by default) from the left end of a string.

    See <CBA_fnc_rightTrim> and <CBA_fnc_trim>.

Parameters:
    _string - String to trim <STRING>
    _trim   - Characters to trim (optional, default: "") <STRING>

Returns:
    Trimmed string <STRING>

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_leftTrim;
        // _result => "frogs are fishy   "
    (end)

Author:
    Spooner, joko // Jonas, SilentSpike
---------------------------------------------------------------------------- */
SCRIPT(leftTrim);

params ["_string", ["_trim", "", [""]]];

// Trim all whitespace characters by default
if (_trim == "") then {
    _trim = toString WHITE_SPACE;
};

_string trim [_trim, 1] // return
