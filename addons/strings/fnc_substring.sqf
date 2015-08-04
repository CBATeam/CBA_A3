/* ----------------------------------------------------------------------------
Function: CBA_fnc_substring

Description:
    Extracts the index-based substring from a string.(deprec)

Parameters:
    _string - String to make replacement in [String]
    _startIndex - Index to start the substring extraction [String]
    _endIndex - Index to end the substring extraction [String]

Returns:
    String extracted [String]

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", 5, 8] call CBA_fnc_substring;
        // => "frog"
    (end)

Author:
    jaynus
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(substring);

// ----------------------------------------------------------------------------

PARAMS_3(_string,_startIndex, _endIndex);
private ["_arr", "_ret", "_i", "_x"];
_arr = toArray _string;
_ret = [];

_x = 0;
while { _startIndex < _endIndex && (_x+_startIndex) < (count _arr) } do {
    _ret set[_x, (_arr select _startIndex)];
    _x = _x + 1;
    _startIndex = _startIndex + 1;
};

_ret = toString _ret;

_ret