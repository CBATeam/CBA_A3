/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPlaying

Description:
    A function used to return the current time on playing music. Must have been started with CBA_fnc_playMusic
    
Parameters:
    BOOL: if true, return bool (default: false)

Returns:
    array [class, music time, time left] OR bool (true for playing music)
    
Example:
    (begin example)
        _musicTime = [] call CBA_fnc_getMusicPlaying;
    (end example)

Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (!params [["_bool",false,[false]]]) exitWith {WARNING('Incorrect param');};

if (isNil QGVAR(track)) exitWith {
    if (_bool) then {false} else {['', 0, 0, 0]}
};

if (_bool) exitWith {true};

GVAR(track) params ["_class","_startTime","_playPos","_duration"];
private "_trackTime";
_trackTime = (CBA_missionTime - _startTime) + _playPos;
private "_remainingTime";
_remainingTime = _duration - _trackTime;
if (_remainingTime <=0) then {
    _remainingTime = 0;
    _trackTime = 0;
    _class = "";
    GVAR(track) = nil;
};

[_class, _trackTime, _remainingTime]

