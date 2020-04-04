#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPlaying

Description:
    A function used to return the current time on playing music. Must have been started with CBA_fnc_playMusic

Parameters:
    none

Returns:
    array [class, music time, time left]

Example:
    (begin example)
        _musicTime = [] call CBA_fnc_getMusicPlaying;
    (end example)

Author:
    Fishy, Dedmen
---------------------------------------------------------------------------- */

if (isNil QGVAR(track)) exitWith {["", 0, 0]};

GVAR(track) params ["_class", "_startTime", "_playPos", "_duration"];

_startTime = [
    floor(_startTime/1e6),
    floor(_startTime/1e3) - floor(_startTime/1e6) * 1e6,
    _startTime - floor(_startTime/1e3) * 1e3 - floor(_startTime/1e6) * 1e6
];
private _timeDiff = CBA_missionTime vectorDiff _startTime;
private _trackTime = _timeDiff#0 * 1e6 + _timeDiff#1 * 1e3 + _timeDiff#2 + _playPos;
private _remainingTime = _duration - _trackTime;

if (_remainingTime <= 0) then {
    _remainingTime = 0;
    _trackTime = 0;
    _class = "";
    GVAR(track) = nil;
};

[_class, _trackTime, _remainingTime]
