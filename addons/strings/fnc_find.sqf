/* ----------------------------------------------------------------------------
Function: CBA_fnc_find

Description:
	Finds a string within another string.

Parameters:
	_haystack - String in which to search [String or ASCII char array]
	_needle - String to search for [String or ASCII char array]
	_initialIndex - Initial character index within _haystack to start the
    search at [Number: 0+, defaults to 0].

Returns:
	First position of string. Returns -1 if not found [Number]

Examples:
	(begin example)
		_result = ["frog-headed fish", "f"] call CBA_fnc_find;
		// _result => 0

		_result = ["frog-headed fish", "f", 5] call CBA_fnc_find;
		// _result => 12

		_result = ["frog-headed fish", "fish"] call CBA_fnc_find;
		// _result => 12
	(end)

Author:
	Xeno
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(find);

// ----------------------------------------------------------------------------

PARAMS_2(_haystack,_needle);
DEFAULT_PARAM(2,_initialIndex,0);

private ["_ret", "_start", "_tempString"];
_start = -1;
_ret = -1;

if (typeName _haystack != "STRING") exitWith {
	-1
};
if (typeName _needle != "STRING") exitWith {
	-1
};

if(_initialIndex < 1) then {
	_ret = _haystack find _needle;
} else {
	_tempString = [_haystack, _initialIndex, ((count _haystack) - _initialIndex)] call CBA_fnc_substring;
	_ret = _tempString find _needle;
	if(_ret > -1) then {
		_ret = _ret + _initialIndex;
	} else {
		_ret = -1;
	};
};

_ret