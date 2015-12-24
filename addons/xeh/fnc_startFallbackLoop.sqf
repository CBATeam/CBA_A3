/* ----------------------------------------------------------------------------
Function: CBA_XEH_fnc_startFallbackLoop

Description:
    Starts a loop to iterate through all objects to initialize event handlers on XEH incompatible objects.
    Internal use only.

Parameters:
    None

Returns:
    None

Examples:
    (begin example)
        call CBA_XEH_fnc_startFallbackLoop;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

if (GVAR(fallbackRunning)) exitWith {};

GVAR(entities) = [];

[{
    private _entities = entities "" + allUnits;

    if !(_entities isEqualTo GVAR(entities)) then {
        GVAR(entities) = _entities;

        {
            if !(ISPROCESSED(_x)) then {
                _x call CBA_fnc_initObject;
            };
        } count _entities;
    };
}, 0.1, []] call CBA_fnc_addPerFrameHandler;

GVAR(fallbackRunning) = true;
