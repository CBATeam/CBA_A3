#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_missionTimeDelta

Description:
    Return precise time in seconds between two CBA_missionTimeSTR timestamps.

Parameters:
    _t0 - Smaller time string <STRING>
    _t1 - Larger time string <STRING>

Returns:
    Time difference <NUMBER>

Examples:
    (begin example)
        _elapsedTime = [nil, CBA_missionTimeStr] call CBA_fnc_missionTimeDelta;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_t0", "0000.000000", [""]], ["_t1", "0000.000000", [""]]];

private _len0 = count _t0 - 10;
private _len1 = count _t1 - 10;

(parseNumber (_t1 select [0, _len1]) - parseNumber (_t0 select [0, _len0])) * 1000 +
(parseNumber (_t1 select [_len1]) - parseNumber (_t0 select [_len0]))
