#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_playMusic

Description:
    A function used to play music.

Parameters:
    1: CLASS or CONFIG- music to play
    2: INT- Starting position of track in seconds (default: 0)
    3: BOOL- allowed to interrupt already playing music (default: true)

Returns:
    BOOL- true if music started playing

Example:
    (begin example)
        _bool = ["LeadTrack01_F_Bootcamp", 30, true] call CBA_fnc_playMusic;
    (end example)

Author:
    Fishy, Dedmen
---------------------------------------------------------------------------- */

params [["_className", "", ["", configFile]], ["_time", 0, [0]], ["_overWrite", true, [true]]];

if (_className isEqualTo "") exitWith {WARNING("No class given"); false};

if ((!_overWrite) && {call CBA_fnc_isMusicPlaying}) exitWith {false};

if (IS_CONFIG(_className)) then {_className = configname _className;};

private _return = false;

private _duration = [_className, "duration"] call CBA_fnc_getMusicData;

if (!isNil "_duration") then {
    if (_time < _duration) then {
        playMusic [_className, _time];
        GVAR(track) = [_className, CBA_missionTimeTriple, _time, _duration];
        _return = true;
    } else {
        WARNING("Time is greater than song length");
    };
} else {
    WARNING("Music not found");
};

_return
