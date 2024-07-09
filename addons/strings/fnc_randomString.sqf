#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_randomString

Description:
    Creates a randomized string with letters and numbers.

Parameters:
    _length - Length of the string [String] (default: 10)

Returns:
    Randomized string [String]

Example:
    (begin example)
        _result = [20] call CBA_fnc_randomString;
        // _result => "03q7npfpthkyiush4yz5"

        _makerName = [20] call CBA_fnc_randomString
        _marker = createMarker [_makerName, player];
    (end)

Author:
    AndreasBrostrom

---------------------------------------------------------------------------- */
params [["_length", 10, [0]]];

private _array = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"];
private _string = "";

for "_i" from 1 to _length do {
    _string = [(selectRandom _array), _string] joinString "";
};

_string
