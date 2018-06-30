#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_trim

Description:
    Trims specified characters (all whitespace by default) from the both ends of a string.

    See <CBA_fnc_leftTrim> and <CBA_fnc_rightTrim>.

Parameters:
    _string - String to trim [String]
    _trim - Characters to trim [String] (default: "")

Returns:
    Trimmed string [String]

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

_string = [_string, _trim] call CBA_fnc_rightTrim;

[_string, _trim] call CBA_fnc_leftTrim
