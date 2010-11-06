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
	[this, this, 300, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_searchNearby", [3,6,9]]
Returns:
	Waypoint
Author:
	Rommel

---------------------------------------------------------------------------- */

private ["_group","_position","_radius"];
_group = (_this select 0) call CBA_fnc_getgroup;
_position = (_this select 1) call CBA_fnc_getpos;
_radius = if (count _this > 2) then {_this select 2} else {0};

private ["_count", "_waypoint"];
_count = count _this;
_waypoint = _group addWaypoint [_position, _radius];

if (_count < 4) exitWith {_waypoint};
_waypoint setWaypointType (_this select 3);
if (_count < 5) exitWith {_waypoint};
_waypoint setWaypointBehaviour (_this select 4);
if (_count < 6) exitWith {_waypoint};
_waypoint setWaypointCombatMode (_this select 5);
if (_count < 7) exitWith {_waypoint};
_waypoint setWaypointSpeed (_this select 6);
if (_count < 8) exitWith {_waypoint};
_waypoint setWaypointFormation (_this select 7);
if (_count < 9) exitWith {_waypoint};
_waypoint setWaypointStatements ["TRUE", (_this select 8)];
if (_count < 10) exitWith {_waypoint};
_waypoint setWaypointTimeout (_this select 9);
if (_count < 11) exitWith {_waypoint};
_waypoint setWaypointHousePosition (_this select 10);
if (_count < 12) exitWith {_waypoint};
_waypoint setWaypointCompletionRadius (_this select 11);

_waypoint;