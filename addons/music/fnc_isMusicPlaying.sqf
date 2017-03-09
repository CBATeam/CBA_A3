/* ----------------------------------------------------------------------------
Function: CBA_fnc_isMusicPlaying

Description:
    A function used to return the current time on playing music. Must have been started with CBA_fnc_playMusic
    
Parameters:
    none

Returns:
    BOOL- true if music is playing
    
Example:
    (begin example)
        _isPlaying = [] call CBA_fnc_isMusicPlaying;
    (end example)

Author:
    Fishy
---------------------------------------------------------------------------- */
#include "script_component.hpp"


if (isNil QGVAR(track)) exitWith {false};

true

