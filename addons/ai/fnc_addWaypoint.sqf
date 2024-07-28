#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addWaypoint

Description:
    A function used to add a waypoint to a group.

Parameters:
    - Group (Group or Object)
    - Position (XYZ, Object, Location or Group)

Optional:
    - Radius (Scalar)
    - Waypoint Type (String)
    - Behaviour (String)
    - Combat Mode (String)
    - Speed Mode (String)
    - Formation (String)
    - Code To Execute at Each Waypoint (String)
    - TimeOut at each Waypoint (Array [Min, Med, Max])
    - Waypoint Completion Radius (Scalar)

Example:
    (begin example)
    [this, this, 300, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3, 6, 9]] call CBA_fnc_addWaypoint
    (end)

Returns:
    [Group,Waypoint]

Author:
    Rommel
---------------------------------------------------------------------------- */

params [
    "_group",
    "_position",
    ["_radius", -1, [0]],
    ["_type", "MOVE", [""]],
    ["_behaviour", "UNCHANGED", [""]],
    ["_combat", "NO CHANGE", [""]],
    ["_speed", "UNCHANGED", [""]],
    ["_formation", "NO CHANGE", [""]],
    ["_onComplete", "", [""]],
    ["_timeout", [0,0,0], [[]], 3],
    ["_compRadius", 0, [0]]
];

_group = _group call CBA_fnc_getGroup;
_position = _position call CBA_fnc_getPos;

// addWaypoint expects ASL when a negative radius is provided for exact placement
// otherwise waypoints will be placed under the ground
if (_radius < 0) then {
    _position = AGLtoASL _position;
};

private _waypoint = _group addWaypoint [_position, _radius];

_waypoint setWaypointType _type;
_waypoint setWaypointBehaviour _behaviour;
_waypoint setWaypointCombatMode _combat;
_waypoint setWaypointSpeed _speed;
_waypoint setWaypointFormation _formation;
_waypoint setWaypointStatements ["TRUE", _onComplete];
_waypoint setWaypointTimeout _timeout;
_waypoint setWaypointCompletionRadius _compRadius;

_waypoint
