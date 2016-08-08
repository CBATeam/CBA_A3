/* ----------------------------------------------------------------------------
Function: CBA_fnc_preprocessFunction

Description:
    Preprocess a function and insert various logging and debug code.

Parameters:
    0: _function - Path to function sqf file <STRING>

Returns:
    Preprocessed function. <STRING>

Examples:
    (begin example)
        [_file] call CBA_fnc_preprocessFunction;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_function", "", [""]]];

_function = preprocessFileLineNumbers _function;

private "_startPos";

while {
    _startPos = _function find """#CBA ";
    !(_startPos isEqualTo -1)
} do {
    private _tail = _function select [_startPos + 6];
    private _endPos = _tail find " #\CBA""";

    // insert custom macro
    _function = (_function select [0, _startPos]) + (_tail select [0, _endPos]) + (_tail select [_endPos + 7]);
};

_function
