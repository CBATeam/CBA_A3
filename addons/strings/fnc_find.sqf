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
    jaynus
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(find);

// ----------------------------------------------------------------------------

params ["_haystack", "_needle", ["_initialIndex", 0]];

if !(_haystack isEqualType "") exitWith {-1};
if !(_needle isEqualType "") exitWith {-1};

private _start = -1;
private _return = -1;

if (_initialIndex < 1) then {
    _return = _haystack find _needle;
} else {
    if (_initialIndex > (count _haystack)) exitWith {-1};
    private _tempString = [_haystack, _initialIndex] call CBA_fnc_substr;
    _return = _tempString find _needle;

    if (_return > -1) then {
        _return = _return + _initialIndex;
    } else {
        _return = -1;
    };
};

_return
