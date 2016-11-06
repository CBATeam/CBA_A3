/* ----------------------------------------------------------------------------
Function: CBA_fnc_projectileTracking_addUnit

Description:
    Adds projectile tracking to a given unit or vehicle.
    Will show colored lines following a projectile's path.

Parameters:
    _unit  - the unit or vehicle to track <OBJECT>

Returns:
    nil

Examples:
    (begin example)
        private _eventId = [player] call CBA_fnc_projectileTracking_addUnit;
    (end)

Author:
    bux578
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_unit", objNull]];

if (isNull _unit) exitWith {
    WARNING_1("Unit %1 is objNull.",_unit);
    (-1)
};

private _arrayIndex = GVAR(projectileTrackedUnits) find _unit;
if (_arrayIndex >= 0) exitWith {
    WARNING_1("Unit %1 already tracked.",_unit);
    (-1)
};

private _eventId = _unit addEventHandler ["Fired", FUNC(projectileTracking_handleFired)];

_unit setVariable ["cba_projectile_firedEhId", _eventId];

GVAR(projectileTrackedUnits) pushBack _unit;

if (GVAR(projectileStartedDrawing) isEqualTo false) then {
    GVAR(projectileDrawHandle) = [FUNC(projectileTracking_drawProjectilePaths), 0, []] call CBA_fnc_addPerFrameHandler;
};
