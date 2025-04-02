#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_fnc_init

Description:
    Runs Init and InitPost event handlers on this object.
    Internal use only.

Parameters:
    0: Any CfgVehicles object <OBJECT>

Returns:
    None

Examples:
    (begin example)
        [_unit] call CBA_fnc_init;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_object"];

if (_object call CBA_fnc_isTerrainObject) exitWith {
    INFO_2("Abort init event for terrain object %1. Class: %2.",_object,typeOf _object);
};

if !(ISINITIALIZED(_object)) then {
    SETINITIALIZED(_object);

    // run Init
    {
        [_object] call _x;
    } forEach (_object getVariable QGVAR(init));

    // run InitPost or put on stack
    if (SLX_XEH_MACHINE select 8) then {
        [{
            {
                [_this] call _x;
            } forEach (_this getVariable QGVAR(initPost));
        }, _object] call CBA_fnc_execNextFrame;
    } else {
        GVAR(initPostStack) pushBack _object;
    };

    // fix for respawnVehicle clearing the object namespace
    _object addEventHandler ["Respawn", {
        params ["_vehicle", "_wreck"];

        if (ISINITIALIZED(_vehicle)) exitWith {}; // Exit if unit respawned normaly with copied variables (e.g. humans)
        SETINITIALIZED(_vehicle);

        {
            private ["_vehicle", "_wreck"]; // prevent these variables from being overwritten
            call _x;
        } forEach (_wreck getVariable QGVAR(respawn));

        {
            private _varName = format [QGVAR(%1), _x];
            private _events = _vehicle getVariable _varName;

            if (!isNil "_events") then {
                _vehicle setVariable [_varName, _events, true];
            };
        } forEach [XEH_EVENTS];
    }];

    #ifdef DEBUG_MODE_FULL
        diag_log ["Init", _unit, local _unit, typeOf _unit];
    #endif
};
