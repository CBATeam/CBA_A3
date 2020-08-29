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

#define WAIT_SWITCH_FPS 10
#define WAIT_HIGH_FPS 0.6
#define WAIT_LOW_FPS 3

if (isNil QGVAR(track)) exitWith {false};

GVAR(track) params ["_class", "_startTime", "_startPos", "_duration"];

if (getMusicPlayedTime != 0) exitWith {true};

/* Check if there is no track playing, since `playMusic ""` doesn't trigger an event
 * In order to do so, check if `getMusicPlayedTime` is zero. However `getMusicPlayedTime` seems to be an estimation
 * and can result in the same value over multiple milliseconds, leading to false positives if the track just started
 * In order to prevent this, this function always waits a minimum amount of time as to allow `getMusicPlayedTime` to update
 * The ideal wait time is FPS depended, so in order to keep it simple and still responsive there are two wait times
 * A high FPS wait time and a low FPS wait time, for which the values are based of the following data:

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
private _miniumWaitTime = [WAIT_HIGH_FPS, WAIT_LOW_FPS] select (diag_fps < WAIT_SWITCH_FPS);

if (time > (_startTime + _miniumWaitTime)) exitWith {
    GVAR(track) = nil;
    false
};

true
