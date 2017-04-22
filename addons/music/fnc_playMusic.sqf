/* ----------------------------------------------------------------------------
Function: CBA_fnc_playMusic
Description:
    A function used to play music. 
Parameters:
    1: CLASS Class to play
    2: INT Position to play from (default: 0)
    3: BOOL allowed to interupt already playing music (default: true)
Example:
    (begin example)
    _bool = ["LeadTrack01_F_Bootcamp", 30, true] call CBA_fnc_playMusic;
    (end example)
Returns:
    BOOL
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
private ["_cfg","_data","_canPlay","_duration","_ret"];
params [["_className",""],["_time",'name'],["_overWrite", true]];
if (_className == "") exitWith {
    WARNING("No class given"); 
    false
};

_ret = false;
_canPlay = false;

if (_overWrite) then {
    _canPlay = true;
} else {
    if (!([true] call CBA_fnc_getMusicPlaying)) then {
    _canPlay = true;
    }; 
};

if (_canPlay) then {
    _duration = [_className,'duration'] call CBA_fnc_getMusicData;
    if (!isNil "_duration") then {
        if (_time < _duration) then {
            playMusic [_className, _time];
            GVAR(track) = [_className,CBA_missionTime,_time,_duration];
            _ret = true;
        } else {WARNING("Time is greater than song length");};
    } else {WARNING("Music not found");};
};

_ret 
