#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_prettyFormat

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
        _return = [ [0, 1, ["22", 33, []], 4] ] call CBA_fnc_prettyFormat;
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
        _return = [ [0, 1, ["22", 33, []], 4], ">---" ] call CBA_fnc_prettyFormat;
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
SCRIPT(prettyFormat);
params [["_array", [], [[]]], ["_tab", toString [9], [""]], ["_depth", 0, [0]]];
private _tabs = [];
_tabs resize _depth;
_tabs = _tabs apply {_tab} joinString "";
if (_array isEqualTo []) exitWith {
    _tabs + "[]"
};
private _lines = [_tabs + "["];
private _lastIndex = count _array - 1;
{
    private _line = if (_x isEqualType []) then {
        ([_x, _tab, _depth + 1] call CBA_fnc_prettyFormat);
    } else {
        _tab + _tabs + str _x;
    };
    if (_forEachIndex != _lastIndex) then {
        _line = _line + ",";
    };
    _lines pushBack _line;
} forEach _array;

_lines pushBack (_tabs + "]");
_lines joinString endl
