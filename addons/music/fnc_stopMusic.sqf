/* ----------------------------------------------------------------------------
Function: CBA_fnc_stopMusic
Description:
    A function used to stop any music playing. Must have been started with CBA_fnc_playMusic, otherwise it is ignored. 
Parameters:
    none
Example:
    (begin example)
    _bool = call CBA_fnc_stopMusic;
    (end example)
Returns:
    BOOL: true if music was stopped, false if already stopped
Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
private ['_ret'];
if (!([true] call CBA_fnc_getMusicPlaying)) exitWith {
	//Nothing is playing, so no need to do anything
	false
};

playMusic ['',0];
GVAR(track) = nil;
true 
