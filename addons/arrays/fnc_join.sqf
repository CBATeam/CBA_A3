/* ----------------------------------------------------------------------------
Function: CBA_fnc_join

DEPRECATED - Please use <joinString at https://community.bistudio.com/wiki/joinString> added in Arma 3 1.50

Description:
    Joins an array of values into a single string.

    Eeach value is joined around a separator string. Inverse of <CBA_fnc_split>.

Parameters:
    _array - Array to join together as a string [Array]
    _separator - String to put between each element of _array
        [String, defaults to ""]

Returns:
    The joined string [String]

Example:
    (begin example)
        _result = [["FISH", "Cheese", "frog.sqf"], "\"] call CBA_fnc_join;
        // _result ==> "FISH\Cheese\frog.sqf"

        _result = [[3, 2, 1, "blast-off!"], "..."] call CBA_fnc_join;
        // _result ==> "3...2...1...blast-off!"
    (end)

Author:
    Spooner
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(join);

// ----------------------------------------------------------------------------

params [["_array",[]], ["_separator",""]];

_array joinString _separator
