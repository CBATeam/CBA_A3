#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isMusicPlaying

Description:
    Function that checks if music is currently playing

Parameters:
    none

Returns:
    BOOL- true if music is playing

Example:
    (begin example)
        _isPlaying = [] call CBA_fnc_isMusicPlaying;
    (end example)

Author:
    Dedmen, Commy2, Fishy
---------------------------------------------------------------------------- */

#define MINIMUM_WAIT 0.1

if (isNil QGVAR(track)) exitWith {false};

GVAR(track) params ["_class", "_startTime", "_playPos", "_duration"];

private _return = true;

// Check if theres a track playing, since `playMusic ""` doesn't trigger an event
private _trackTime = getMusicPlayedTime;
if (CBA_missionTime > (_startTime + MINIMUM_WAIT) && {_trackTime == 0}) then {
    GVAR(track) = nil;
    _return = false;
};

_return
