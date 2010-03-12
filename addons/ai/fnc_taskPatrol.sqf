/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskPatrol

Description:
	A function for a group to randomly patrol a parsed radius and location.
Parameters:
	- Group (Group or Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
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
	[this, this, 300, 7, "MOVE", "AWARE", "YELLOW", "FULL", "STAG COLUMN", "this spawn CBA_fnc_taskSearchHouse", [3,6,9]] call CBA_fnc_taskPatrol;
	
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

#define NULL	"$null$"

PARAMS_2(_group,_position);
DEFAULT_PARAM(2,_radius,100);
DEFAULT_PARAM(3,_count,3);

_this =+ _this;	// needed
if (count _this > 3) then {
	_this set [3, NULL];
	_this = _this - [NULL];
};
_this2 =+ _this; // needed
for "_x" from 0 to _count do {
	_this call CBA_fnc_addWaypoint;
};
_this2 set [3, "CYCLE"];
_this2 call CBA_fnc_addWaypoint;

deleteWaypoint ((waypoints _group) select 0);