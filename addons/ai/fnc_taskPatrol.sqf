/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskPatrol

Description:
    A function for a group to randomly patrol a parsed radius and location.

Parameters:
    - Group (Group or Object)

Optional:
    - Position (XYZ, Object, Location or Group)
    - Radius (Scalar)
    - Waypoint Count (Scalar)
    - Waypoint Type (String)
    - Behaviour (String)
    - Combat Mode (String)
    - Speed Mode (String)
    - Formation (String)
    - Code To Execute at Each Waypoint (String)
    - TimeOut at each Waypoint (Array [Min, Med, Max])

Example:
    (begin example)
    [this, getmarkerpos "objective1"] call CBA_fnc_taskPatrol
    [this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]] call CBA_fnc_taskPatrol;
    (end)

Returns:
    Nil

Author:
    Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define NULL    "$null$"

params ["_group", ["_position",[]], ["_radius",100], ["_count",3]];

_position = [_position,_group] select (_position isEqualTo []);

_this =+ _this;
if (count _this > 3) then {
    _this set [3, NULL];
    _this = _this - [NULL];
};
for "_x" from 1 to _count do {
    _this call CBA_fnc_addWaypoint;
};
_this2 =+ _this;
_this2 set [3, "CYCLE"];
_this2 call CBA_fnc_addWaypoint;

deleteWaypoint ((waypoints _group) select 0);
