/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMusicPlaying
Description:
    A function used to return the current time on playing music. Must have been started with CBA_fnc_playMusic
Parameters:
    BOOL: if true, return bool (default: False)
Example:
    (begin example)
    _musicTime = [] call CBA_fnc_getMusicPlaying;
    (end example)
Returns:
    array [class, music time, time left] OR bool (true for playing music)
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

private ["_bool","_return","_trackTime","_remainingTime"];
_bool = [_this,0,false,[false]] call BIS_fnc_param;
_return = ['', 0, 0, 0];
if (isNil QGVAR(track)) exitWith {
    if (_bool) then {_return = false;};
    _return
};
if (_bool) exitWith {true};

GVAR(track) params ["_class","_startTime","_playPos","_duration"];
_trackTime = (CBA_missionTime - _startTime) + _playPos;
_remainingTime = _duration - _trackTime;
if (_remainingTime <=0) then {
    _remainingTime = 0;
    _trackTime = 0;
    _class = "";
    GVAR(track) = nil;
};
_return = [_class, _trackTime, _remainingTime];
_return 
