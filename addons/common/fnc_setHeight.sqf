/* ----------------------------------------------------------------------------
Function: CBA_fnc_setHeight

Description:
	A function used to set the height of an object
Parameters:
	_object - Object or Location
	_height - Height in metres
	_type - Optional parameter, 0 is getpos, 1 is getpos ASL, 2 is getposATL (Default: 1)
Example:
	[this, 10] call CBA_fnc_setHeight
Returns:
	Nothing
Author:
	Rommel

---------------------------------------------------------------------------- */

#include "\x\cba\addons\main\script_macros_common.hpp"

PARAMS_2(_object,_height);
DEFAULT_PARAM(2,_type,1);

private "_position";
_position = switch (_type) do {
	case 0 : {getPos _object};
	case 1 : {getPosASL _object};
	case 2 : {getPosATL _object};
};
_position set [2, _height];

switch (_type) do {
	case 0 : {_object setPos _position};
	case 1 : {_object setPosASL _position};
	case 2 : {_object setPosATL _position};
};
_object setDir (getDir _object);