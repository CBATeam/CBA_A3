#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_prettyFormat

Description:
    Makes an array easy to read.

Parameters:
    _array     - Array to format <ARRAY>
    _indents   - Indentation string (optional, default: "    ") <STRING>
    _lineBreak - Seperator string (optional, default: endl) <STRING>
    _depth     - Initial indentation count (optional, default: 0) <SCALAR>

Returns:
    Formatted string <STRING>

Examples:
    (begin example)
        [[0, 1, ["22", 33, []], 4]] call CBA_fnc_prettyFormat;
        //[
        //    0,
        //    1,
        //    [
        //        "22",
        //        33,
        //        []
        //    ],
        //    4
        //]

        [[0, 1, ["22", 33, []], 4], ">---"] call CBA_fnc_prettyFormat;
        //[
        //>---0,
        //>---1,
        //>---[
        //>--->---"22",
        //>--->---33,
        //>--->---[]
        //>---],
        //>---4
        //]

        [[0, 1, ["22", 33, []], 4], ">---", "\n"] call CBA_fnc_prettyFormat;
        //[\n>---0,\n>---1,\n>---[\n>--->---"22",\n>--->---33,\n>--->---[]\n>---],\n>---4\n]
    (end)

Author:
   Terra, Dystopian, commy2

---------------------------------------------------------------------------- */
SCRIPT(prettyFormat);

params [
    ["_array", [], [[]]],
    ["_indent", "    ", [""]],
    ["_lineBreak", endl, [""]],
    ["_depth", 0, [0]]
];

private _indents = STRING_REPEAT(_indent, _depth);

if (_array isEqualTo []) exitWith {
    _indents + "[]" // return
};

private _lines = _array apply {
    if (_x isEqualType []) then {
        [_x, _indent, _lineBreak, _depth + 1] call CBA_fnc_prettyFormat
    } else {
        _indents + _indent + str _x
    };
};

_indents + "[" + _lineBreak + (_lines joinString ("," + _lineBreak)) + _lineBreak + _indents + "]" // return
