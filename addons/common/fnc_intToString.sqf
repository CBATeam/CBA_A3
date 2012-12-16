/* ----------------------------------------------------------------------------
Function: CBA_fnc_intToString

Description:
	Faster int to string, uses an integer lookup table if possible

Parameters:
	_int - Integer number

Example:
    (begin example)
	5 call CBA_fnc_intToString
    (end)

Returns:
	String

Author:
	Xeno

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(intToString);

PARAMS_1(_int);

if (typeName _int != "SCALAR") exitWith {
	WARNING("Expected number as paramater, type was " + (typeName _int));
	""
};

if (_int < count CBA_INT_STRING_TABLE && _int >= 0) then {
	(CBA_INT_STRING_TABLE select _int)
} else {
	str _int
};
