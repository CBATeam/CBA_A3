#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_trim

Description:
    Trims specified characters (all whitespace by default) from the both ends of a string.

    See <CBA_fnc_leftTrim> and <CBA_fnc_rightTrim>.

Parameters:
    _string - String to trim <STRING>
    _trim   - Characters to trim (optional, default: "") <STRING>

Returns:
    Trimmed string <STRING>

Example:
    (begin example)
        _result = [" frogs are fishy   "] call CBA_fnc_trim;
        // _result => "frogs are fishy"
    (end)

Author:
    Spooner, SilentSpike
---------------------------------------------------------------------------- */
SCRIPT(trim);

params ["_string", ["_trim", "", [""]]];

// Trim all whitespace characters by default
if (_trim == "") exitWith {
    trim _string // return
};

_string trim [_trim, 0] // return
