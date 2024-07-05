#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_clearWaypoints

Description:
    A function used to correctly clear all waypoints from a group.

Parameters:
    - Group (Group or Object)

Example:
    (begin example)
    [group player] call CBA_fnc_clearWaypoints
    (end)

Returns:
    None

Author:
    SilentSpike

---------------------------------------------------------------------------- */
params [["_group", grpNull, [grpNull, objNull]]];
_group = _group call CBA_fnc_getGroup;

private _waypoints = waypoints _group;
{
    // Waypoint index changes with each deletion, so don't delete _x
    deleteWaypoint [_group, 0];
} forEach _waypoints;

if (units _group isNotEqualTo []) then {
    // Create a self-deleting waypoint at the leader position to halt all planned movement (based on old waypoints)
    private _wp = _group addWaypoint [getPosASL leader _group, -1];
    _wp setWaypointStatements ["true", "deleteWaypoint [group this, currentWaypoint (group this)]"];
};
