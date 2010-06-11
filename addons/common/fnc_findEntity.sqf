/* ----------------------------------------------------------------------------
Function: CBA_fnc_findEntity

Description:
	A function used to find out the first entity of parsed type in a nearEntitys call
Parameters:
	- Type (Classname, Object)
	- Position (XYZ, Object, Location or Group)
	Optional:
	- Radius (Scalar)
Example:
	_veh = ["LaserTarget", player] call CBA_fnc_findEntity
Returns:
	First entity; nil return if nothing
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_2(_type,_position);
DEFAULT_PARAM(2,_radius,50);

{
	if (_x iskindof _type) exitwith {
		_x
	};
	nil
} foreach ((_position call CBA_fnc_getpos) nearEntities _radius);