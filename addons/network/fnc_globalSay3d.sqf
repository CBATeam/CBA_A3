/*
Function: CBA_fnc_globalSay3d

Description:
	Says sound on all client computer in 3d

Parameters:
	_object - Object that performs Say [Object] can also be _array - [object, targetObject]
	_speechName - Speechname
	_range - (Optional parameter) maximum distance from camera to execute command [Number]

Returns:

Example:
	(begin example)
		[player, "Alarm01",500] call CBA_fnc_globalSay3d;
	(end)

Author:
	Sickboy
*/
#include "script_component.hpp"
TRACE_1("",_this);

[QGVAR(say3d), _this] call CBA_fnc_globalEvent;
