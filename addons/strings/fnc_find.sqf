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

private ["_haystackCount", "_needleCount", "_foundPos",
	"_needleIndex", "_doexit", "_notfound"];

if (typeName _haystack == "STRING") then {
	_haystack = toArray _haystack;
};

if (typeName _needle == "STRING") then {
	_needle = toArray _needle;
};

_haystackCount = count _haystack;
_needleCount = count _needle;
_foundPos = -1;

if ((_haystackCount - _initialIndex) < _needleCount) exitWith {_foundPos};

_needleIndex = 0;
_doexit = false;
for "_i" from _initialIndex to (_haystackCount - 1) do {
	if (_haystack select _i == _needle select _needleIndex) then {
		if (_needleCount == 1) exitWith {
			_foundPos = _i;
			_doexit = true;
		};
		if (_haystackCount - _i < _needleCount) exitWith {_doexit = true};
		INC(_needleIndex);
		_notfound = false;
		for "_j" from (_i + 1) to (_i + _needleCount - 1) do {
			if (_haystack select _j != _needle select _needleIndex) exitWith {
				_notfound = true;
			};
			INC(_needleIndex);
		};
		if (_notfound) then {
			_needleIndex = 0;
		} else {
			_foundPos = _i;
			_doexit = true;
		};
	};
	if (_doexit) exitWith {};
};

_foundPos