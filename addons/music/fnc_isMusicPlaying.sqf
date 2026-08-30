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

#define MINIMUM_WAIT 3

if (isNil QGVAR(track)) exitWith {false};

GVAR(track) params ["_class", "_startTime", "_startPos", "_duration"];

if (getMusicPlayedTime != 0) exitWith {true};

/* Check if there is no track playing, since `playMusic ""` doesn't trigger an event
 * In order to do so, check if `getMusicPlayedTime` is zero. However `getMusicPlayedTime` seems to be an estimation
 * and can result in the same value over multiple milliseconds, leading to false positives if the track just started
 * In order to prevent this, this function always waits a minimum amount of time as to allow `getMusicPlayedTime` to update
 * The ideal wait time is FPS depended, so we count for the worst case scenario
 * This is only to account for `playMusic ""`, `CBA_fnc_stopMusic` works perfectly fine.

 * | FPS | Max Time to Update | Average Time to Update |
 * | --- | ------------------ | ---------------------- |
 * | 2   | 2.333010           | 1.155892               |
 * | 10  | 0.385986           | 0.300724               |
 * | 20  | 0.240967           | 0.191904               |
 * | 36  | 0.170898           | 0.157701               |
 * | 59  | 0.150009           | 0.126583               |
 * | 120 | 0.120972           | 0.106157               |
 * | --- | ------------------ | ---------------------- |
 * This data was collected from 2 machines on a locally hosted server with only one player */
if (time > (_startTime + MINIMUM_WAIT)) exitWith {
    playMusic ""; // In case of false positive stop music to stay in sync.
    GVAR(track) = nil;
    false
};

true
