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

if !(call CBA_fnc_isMusicPlaying) exitWith {["", 0, 0]};

GVAR(track) params ["_class", "_startTime", "_playPos", "_duration"];

private _trackTime = getMusicPlayedTime;
private _remainingTime = _duration - _trackTime;
_remainingTime = _remainingTime max 0;

[_class, _trackTime, _remainingTime]
