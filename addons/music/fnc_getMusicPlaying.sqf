#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPlaying

Description:
    A function used to return the current time on playing music

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

GVAR(track) params ["_class", "_startTime", "_startPos", "_duration"];

private _currentPos = getMusicPlayedTime min _duration;
private _remainingTime = _duration - _currentPos;

[_class, _currentPos, _remainingTime]
