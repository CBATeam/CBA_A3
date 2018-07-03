#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_stopMusic

Description:
    A function used to stop any music playing.

Parameters:
    none

Returns:
    nil

Example:
    (begin example)
        _nothing = call CBA_fnc_stopMusic;
    (end example)

Author:
    Fishy
---------------------------------------------------------------------------- */

playMusic ["", 0];
GVAR(track) = nil;

nil
