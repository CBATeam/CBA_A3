#include "script_component.hpp"
/* ----------------------------------------------------------------------------
    Function: CBA_fnc_stopSoundSOS

    Description:
        Stops sound from object or position with speed of sound delay.

    Parameters:
        _handler - Sound handler reported by CBA_fnc_playSoundSOS <ARRAY>

    Returns:
        Nothing.

    Examples:
    (begin example)
        _handler call CBA_fnc_stopSoundSOS;
    (end)

    Author:
        commy2
---------------------------------------------------------------------------- */

params [["_handler", "empty", [""]]];

["CBA_stopSoundSOS", _handler] call CBA_fnc_globalEvent;

nil
