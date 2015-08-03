/* ----------------------------------------------------------------------------
Function: CBA_fnc_substring_new

Description:
    Retrieves a substring of this instance. The substring starts at a specified character position and has a specified length.

Parameters:
    _string - String to make replacement in [String]
    _startIndex - Index to start the substring extraction [String]
    _endIndex - Index to end the substring extraction [String]

Returns:
    String extracted [String]

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", 5, 4] call CBA_fnc_substring_new;
        // => "frog"
    (end)

Author:
    joko // Jonas
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(substring_new);

// ----------------------------------------------------------------------------

params["_string","_startIndex","_lenth"];
// Cut out String
_ret = _string select [_startIndex, _lenth];

_ret // Return
