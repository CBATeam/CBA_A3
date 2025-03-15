#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_generateQTESequence

Description:
    Generate a Quick-Time sequence of a given length.

Parameters:
    _length - Length of QTE sequence <NUMBER>

Example:
    [5] call CBA_fnc_generateQTESequence;

Returns:
    Quick-Time sequence of requested length made up of ["↑", "↓", "→", "←"] <ARRAY>

Author:
    john681611
---------------------------------------------------------------------------- */

params [["_length", 0, [0]]];

if (_length <= 0) exitWith {[]};

private _code = [];

for "_i" from 1 to _length do {
    _code pushBack (selectRandom ["↑", "↓", "→", "←"]);
};

_code
