/* ----------------------------------------------------------------------------
Function: CBA_fnc_taskAttack

Description:
	A function for a group to attack a parsed location.
Parameters:
	- Group (Group or Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
	- Search Radius (Scalar)
Example:
	[group player, getpos (player findNearestEnemy player), 100] call CBA_fnc_taskAttack
Returns:
	Nil
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_2(_group,_position);
DEFAULT_PARAM(2,_radius,0);

[_group, _position, _radius, "SAD", "COMBAT", "RED"] call CBA_fnc_addWaypoint;