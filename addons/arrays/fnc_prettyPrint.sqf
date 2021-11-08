#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_prettyPrint

Description:
	Makes an array easier to read.

Parameters:
    _this - Array <ARRAY>

Returns:
	Formatted string <STRING>

Examples:
    (begin example)
		_return = [0, 1, ["22", 33, []], 4] call CBA_fnc_prettyPrint;
		// _return ==>
		// "[
		//		0,
		//		1,
		//		[
		//			""22"",
		//			33,
		//			[]
		//		],
		//		4
		//	]" 
    (end)

Author:
   Terra 
---------------------------------------------------------------------------- */
SCRIPT(prettyPrint);

if (count _this == 0) exitWith {
	"[]"
};
private _lines = ["["];
// Recursive function calls have _depth already defined
private _depth = if (isNil "_depth") then {
	0
} else {
	_depth + 1
};

{
	private _line = "";
	for "_i" from 1 to (_depth + 1) do {
		_line = "	" + _line;
	};
	_line = if (_x isEqualType []) then {
		_line + (_x call CBA_fnc_prettyPrint);
	} else {
		_line + str _x;
	};
	if (_forEachIndex != count _this - 1) then {
		_line = _line + ",";
	};
	_lines pushBack _line;
} forEach _this;

private _closingBracket = "";
for "_i" from 1 to _depth do {
	_closingBracket = "	" + _closingBracket;
};
_lines pushBack (_closingBracket + "]");
_lines joinString endl
