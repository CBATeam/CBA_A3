#include "script_component.hpp"
/* ----------------------------------------------------------------------------
    Function: CBA_fnc_playSoundSOS

    Description:
        Plays sound from object or position with speed of sound delay. Global effects.

    Parameters:
        _origin - Object that emitted sound <OBJECT, PosASL>
        _sound  - CfgSounds class to play, rhs argument of say3D <STRING, ARRAY>

    Returns:
        Sound handler, used to stop the sound. <STRING>

    Examples:
    (begin example)
        _handler = [cursorTarget, "Alarm"] call CBA_fnc_playSoundSOS;

        private _dummy = "#particlesource" createVehicleLocal [0,0,0];
        _dummy attachTo [tank1, [0,0,0], "memory_point"];
        [_dummy, "Alarm"] call CBA_fnc_playSoundSOS;
    (end)

    Author:
        commy2
---------------------------------------------------------------------------- */
