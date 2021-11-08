#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_prettyPrint

Description:
    Makes an array easier to read.

Parameters:
    _array - The array to format <ARRAY>
    _tab   - The tab char to use (optional, default: tab) <STRING>
    _depth - Starting indent (optional, default: 0) <NUMBER>

Returns:
    Formatted string <STRING>

Examples:
    (begin example)
        _return = [ [0, 1, ["22", 33, []], 4] ] call CBA_fnc_prettyPrint;
        // _return ==>
        // "[
        //      0,
        //      1,
        //      [
        //          ""22"",
        //          33,
        //          []
        //      ],
        //      4
        //  ]"
        _return = [ [0, 1, ["22", 33, []], 4], ">---" ] call CBA_fnc_prettyPrint;
        // _return ==>
        // [
        // >---0,
        // >---1,
        // >---[
        // >--->---""22"",
        // >--->---33,
        // >--->---[]
        // >---],
        // >---4
        // ]
    (end)

Author:
   Terra
---------------------------------------------------------------------------- */
SCRIPT(prettyPrint);
params [["_array", [], [[]]], ["_tab", toString[9], [""]], ["_depth", 0, [0]]];
if (count _array == 0) exitWith {
    "[]"
};
private _lines = ["["];

{
    private _line = "";
    for "_i" from 1 to (_depth + 1) do {
        _line = _tab + _line;
    };
    _line = if (_x isEqualType []) then {
        _line + ([_x, _tab, _depth + 1] call CBA_fnc_prettyPrint);
    } else {
        _line + str _x;
    };
    if (_forEachIndex != count _array - 1) then {
        _line = _line + ",";
    };
    _lines pushBack _line;
} forEach _array;

private _closingBracket = "";
for "_i" from 1 to _depth do {
    _closingBracket = _tab + _closingBracket;
};
_lines pushBack (_closingBracket + "]");
_lines joinString endl
