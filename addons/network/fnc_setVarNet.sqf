/*
Function: CBA_fnc_setVarNet

Description:
	Same as setVariable ["name",var, true] but only broadcasts when the value of var is different to the one which is already saved in the variable space.
	Checks also for different types. Nil as value gets always broadcasted.
	
	Should reduce network traffic.

Parameters:
	_object - Name of a marker [Object, Group]
	_variable - Name of the variable in variable space [String]
	_value - Value to check and broadcast if it is not the same as the previous one, code will always be broadcasted [Any]

Returns:
	True if broadcasted, otherwise false [Boolean]

Example:
	(begin example)
		// This will only broadcast "somefish" if it either doesn't exist yet in the variable space or the value is not 50
		_broadcasted = [player, "somefish", 50] call CBA_fnc_setVarNet;
	(end)

Author:
	Xeno
*/
//#define DEBUG_MODE_FULL
#include "script_component.hpp"

PARAMS_3(_object,_variable,_value);

// does setVariable public also work for other types ??
if (typeName _object != "OBJECT" && typeName _object != "GROUP") exitWith {
	WARNING("The first parameter is not of type object or group!");
	false
};

private ["_var","_s"];

_var = _object getVariable _variable;

if (isNil "_var") exitWith {
	TRACE_3("Broadcasting",_object,_variable,_value);
	_object setVariable [_variable, _value, true];
	true
};

_s = if (typeName _value != typeName _var) then {
	TRACE_2("Different typenames",_var,_value);
	false
} else {
	switch (typename _value) do {
		case "BOOL": {
			((_var && _value) || (!_var && !_value))
		};
		case "ARRAY": {
			([_var, _value] call (uiNamespace getVariable "BIS_fnc_areEqual"))
		};
		case "CODE": {
			false
		};
		case "SCRIPT": {
			false
		};
		default {
			(_var == _value)
		};
	}
};
if (_s) exitwith {
	TRACE_2("Not broadcasting, _var and _value are equal",_var,_value);
	false
};

TRACE_3("Broadcasting",_object,_variable,_value);
_object setVariable [_variable, _value, true];

true