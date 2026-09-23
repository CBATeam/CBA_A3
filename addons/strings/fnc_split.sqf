#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_split

Description:
    Splits a string into substrings using a separator. Inverse of <CBA_fnc_join>.

Parameters:
    _string - String to split up <STRING>
    _separator - String to split around. <STRING> (defaults to "")
        If an empty string, "", then split every character into a separate string 

Returns:
    The split string <ARRAY of STRING>

Examples:
    (begin example)
        _result = ["FISH\Cheese\frog.sqf", "\"] call CBA_fnc_split;
        _result is ["Fish", "Cheese", "frog.sqf"]

        _result = ["Peas", ""] call CBA_fnc_split;
        _result is ["P", "e", "a", "s"]
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */
SCRIPT(split);

params [["_input", ""], ["_separator", ""]];

// Corner cases
if (_separator isEqualTo "") exitWith {_input splitString ""};
if (_input isEqualTo "") exitWith {[]};

private _split = [];
private _index = 0;
private _separatorCount = count _separator;

// find searches from an index without copying the rest of the string first, so
// what is left between two separators is the only thing that gets cut out
while {true} do {
    private _found = _input find [_separator, _index];

    if (_found == -1) exitWith {
        _split pushBack (_input select [_index]);
    };

    _split pushBack (_input select [_index, _found - _index]);

    _index = _found + _separatorCount;
};

_split // return
