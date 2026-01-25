#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_northingReversed

Description:
    Checks if the maps northing is reversed (like Chernarus & Utes, or any map pre-OA)

Parameters:
    None

Returns:
    _reversed - Bool, true if its reversed, false if it is not.

Examples:
    (begin example)
        _reversed = [] call CBA_fnc_northingReversed
    (end)

Author:
    Nou

---------------------------------------------------------------------------- */

private _reversed = false;
if (isNil QGVAR(mapReversed)) then {
    private _test = getNumber (configFile >> "CfgWorlds" >> worldName >> "Grid" >> "Zoom1" >> "stepY");
    if (_test > 0) then {
        private _check = parseNumber(format["%1", mapGridPosition [0, 0]]);
        private _start = _check;
        private _plus = 0;
        diag_log text "---------------------";
        while {_check == _start} do {
            _check = parseNumber(format["%1", mapGridPosition [0, _plus]]);
            _plus = _plus + 1;
        };
        if (_check < _start) then {
            _reversed = true;
        };
    };
    GVAR(mapReversed) = _reversed;
} else {
    _reversed = GVAR(mapReversed);
};


_reversed
