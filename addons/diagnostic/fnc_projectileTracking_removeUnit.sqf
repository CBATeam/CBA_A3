/* ----------------------------------------------------------------------------
Function: CBA_fnc_projectileTracking_removeUnit

Description:
    Removes projectile tracking from a given unit or vehicle.

Parameters:
    _unit    - the unit or vehicle to track <OBJECT>

Returns:
    nil

Examples:
    (begin example)
        [vehicle player, 1] call CBA_fnc_projectileTracking_removeUnit;
    (end)

Author:
    bux578
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_unit", objNull]];

if (isNull _unit) exitWith {
    WARNING_1("Unit %1 is objNull.",_unit);
};

private _eventId = _unit getVariable ["cba_projectile_firedEhId", -1];

// reset
_unit setVariable ["cba_projectile_firedEhId", -1];

if (_eventId == -1) exitWith {
    WARNING_1("Unit has no or a wrong eventId (%1).",_eventId);
};

_unit removeEventHandler ["Fired", _eventId];

private _arrayIndex = GVAR(projectileTrackedUnits) find _unit;
if (_arrayIndex >= 0) then {
    GVAR(projectileTrackedUnits) deleteAt _arrayIndex;

    // if no more units are tracked, stop draw pfh and reset GVARs
    if (count GVAR(projectileTrackedUnits) == 0) then {
        [GVAR(projectileDrawHandle)] call CBA_fnc_removePerFrameHandler;

        GVAR(projectileData) = [] call CBA_fnc_hashCreate;
        GVAR(projectileIndex) = 0;
        GVAR(projectileStartedDrawing) = false;
    };

};
