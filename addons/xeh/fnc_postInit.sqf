/* ----------------------------------------------------------------------------
Function: CBA_fnc_postInit

Description:
    Occurs once per mission after objects and functions are initialized.
    Internal use only.

Parameters:
    None

Returns:
    None

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// this runs in sheduled. we don't like sheduled. spawn a game logic with init event handler instead.
"CBA_PostInit_Helper" createVehicleLocal [0,0,0];
