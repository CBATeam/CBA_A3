/* ----------------------------------------------------------------------------
Function: CBA_fnc_projectileTracking_addUnit

Description:
    Adds projectile tracking to a given unit or vehicle.
    Will show colored lines following a projectile's path.

Parameters:
    _unit  - the unit or vehicle to track <OBJECT>
    (_count - the amount of lines that are displayed simultaneously (maximum is 20 due to performance), optional <NUMBER>)

Returns:
    _eventHandlerId - the fired event handler id <NUMBER>

Examples:
    (begin example)
        private _eventId = [player] call CBA_fnc_projectileTracking_addUnit;
        (private _eventId = [vehicle player, 10] call CBA_fnc_projectileTracking_addUnit;)
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

private _eventId = _unit addEventHandler ["Fired", FUNC(projectileTracking_handleFired)];

GVAR(projectileTrackedUnits) pushBack _unit;

if (GVAR(projectileStartedDrawing) isEqualTo false) then {
    GVAR(projectileDrawHandle) = [FUNC(projectileTracking_drawProjectilePaths), 0, []] call CBA_fnc_addPerFrameHandler;
};

_eventId
