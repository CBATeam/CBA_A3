/* ----------------------------------------------------------------------------
Function: CBA_fnc_northingReversed

Description:
	Checks if the maps northing is reversed (like Chernarus & Utes, or any map pre-OA)

Parameters:
	None

Returns:
	_reversed - Bool, true if its reversed, false if it is not.

Examples:
	(begin example)
		_reversed = [] call CBA_fnc_northingReversed
	(end)

Author:
	Nou

---------------------------------------------------------------------------- */
#include "script_component.hpp"

private ["_test", "_reversed", "_start", "_check", "_plus"];
_reversed = false;
if (isNil QGVAR(mapReversed)) then {
	_test = getNumber (configFile >> "CfgWorlds" >> worldName >> "Grid" >> "Zoom1" >> "stepY");
	if (_test > 0) then {
		_start = format["%1", mapGridPosition [0, 0]];
		_check = parseNumber(_start);
		_plus = 0;
		diag_log text "---------------------";
		while {_check != _start} do {
			_check = parseNumber(format["%1", mapGridPosition [0, _plus]]);
			_plus = _plus + 1;
		};
		if (_check < _start) then {
			_reversed = true;
		};
	};
	GVAR(mapReversed) = _reversed;
} else {
	_reversed = GVAR(mapReversed);
};


_reversed