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
#include "script_component.hpp"

if (isNil QGVAR(track)) exitWith {["", 0, 0]};

GVAR(track) params ["_class","_startTime","_playPos","_duration"];

private _trackTime = (CBA_missionTime - _startTime) + _playPos;
private _remainingTime = _duration - _trackTime;

if (_remainingTime <=0) then {
    _remainingTime = 0;
    _trackTime = 0;
    _class = "";
    GVAR(track) = nil;
};

[_class, _trackTime, _remainingTime]

