/* ----------------------------------------------------------------------------
Function: CBA_fnc_AI_addWaypoint

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
Example:
	[this, this, 300, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,6,9]]
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "\x\cba\addons\main\script_macros_common.hpp"

#define ARG(X)	(_this select (X))

PARAMS_2(_group,_position);
_group = _group call CBA_fnc_getGroup;
_position = _position call CBA_fnc_getPosition;
DEFAULT_PARAM(2,_radius,0);

private ["_count", "_waypoint"];

_count = count _this;
_waypoint = _group addWaypoint [_position, _radius];

if (_count > 3) then {
	_waypoint setWaypointType ARG(3);
	if (_count > 4) then {
		_waypoint setWaypointBehaviour ARG(4);
		if (_count > 5) then {
			_waypoint setWaypointCombatMode ARG(5);
			if (_count > 6) then {
				_waypoint setWaypointSpeed ARG(6);
				if (_count > 7) then {
					_waypoint setWaypointFormation ARG(7);
					if (_count > 8) then {
						_waypoint setWaypointStatements ["TRUE", ARG(8)];
						if (_count > 9) then {
							_waypoint setWaypointTimeout ARG(9);
						};
					};
				};
			};
		};
	};
};