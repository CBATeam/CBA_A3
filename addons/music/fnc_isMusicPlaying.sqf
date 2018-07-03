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

!isNil QGVAR(track)
