#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_find

Description:
    Finds a string within another string.
    Reliably supports strings with ANSI characters only.

Parameters:
    _haystack     - String in which to search <STRING>
    _needle       - String to search for <STRING>
    _initialIndex - Initial character index within _haystack to start the
    search at, should be >= 0 (optional, default: 0) <SCALAR>

Returns:
    First position of string. Returns -1 if not found <SCALAR>

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
    jaynus
---------------------------------------------------------------------------- */
SCRIPT(find);

params ["_haystack", "_needle", ["_initialIndex", 0]];

if !(_haystack isEqualType "") exitWith {-1};
if !(_needle isEqualType "") exitWith {-1};

_haystack find [_needle, _initialIndex max 0] // return
