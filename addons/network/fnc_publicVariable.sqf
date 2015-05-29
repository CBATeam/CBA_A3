/*
Function: CBA_fnc_publicVariable

Description:
	CBA_fnc_publicVariable does only broadcast the new value if it doesn't exist in missionNamespace or the new value is different to the one in missionNamespace.
	Checks also for different types. Nil as value gets always broadcasted.

	Should reduce network traffic.

Parameters:
	_pv - Name of the publicVariable [String]
	_value - Value to check and broadcast if it is not the same as the previous one, code will always be broadcasted [Any]

Returns:
	True if if broadcasted, otherwise false [Boolean]

Example:
	(begin example)
		// This will only broadcast "somefish" if it either doesn't exist yet in the missionNamespace or the value is not 50
		_broadcasted = ["somefish", 50] call CBA_fnc_publicVariable;
	(end)

Author:
	Xeno
*/
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

PARAMS_2(_pv,_value);

if (typeName _pv != typeName "") exitWith {
	WARNING("The first parameter is not of type string!");
	false
};

private ["_var","_s"];
_var = missionNamespace getVariable _pv;

if (isNil "_var") exitWith {
	TRACE_2("Broadcasting",_pv,_value);
	missionNamespace setVariable [_pv, _value];
	publicVariable _pv;
	true
};

_s = if (typeName _value != typeName _var) then {
	TRACE_2("Different typenames",_var,_value);
	false
} else {
	switch (typename _value) do {
		case "BOOL": {
			((_var && {_value}) || {(!_var && {!_value})})
		};
		case "ARRAY": {
			(_var isEqualTo _value)
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

TRACE_2("Broadcasting",_pv,_value);
missionNamespace setVariable [_pv, _value];
publicVariable _pv;

true