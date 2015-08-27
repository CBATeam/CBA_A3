/* ----------------------------------------------------------------------------
Function: CBA_fnc_split

Description:
    Splits a string into substrings using a separator. Inverse of <CBA_fnc_join>.

Parameters:
    _string - String to split up [String]
    _separator - String to split around. If an empty string, "", then split
        every character into a separate string [String, defaults to ""]

Returns:
    The split string [Array of Strings]

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

#include "script_component.hpp"

SCRIPT(split);

// ----------------------------------------------------------------------------

params [["_input",""], ["_separator",""]];

_input splitString _separator
