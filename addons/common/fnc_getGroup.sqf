/* ----------------------------------------------------------------------------
Function: CBA_fnc_getGroup

Description:
	A function used to find out the group of an object.
Parameters:
	Group or Unit
Example:
	_group = player call CBA_fnc_getGroup
Returns:
	Group
Author:
	Rommel

---------------------------------------------------------------------------- */

if (typeName _this == "GROUP") exitwith {_this};
group _this