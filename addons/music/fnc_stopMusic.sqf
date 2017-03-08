/* ----------------------------------------------------------------------------
Function: CBA_fnc_stopMusic

Description:
    A function used to stop any music playing. Must have been started with CBA_fnc_playMusic, otherwise it is ignored. 
    
Parameters:
    none

Returns:
    BOOL: true if music was stopped, false if already stopped
    
Example:
    (begin example)
        _bool = call CBA_fnc_stopMusic;
    (end example)

Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (!([true] call CBA_fnc_getMusicPlaying)) exitWith {false};

playMusic ["",0];
GVAR(track) = nil;
true 
