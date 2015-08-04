/* ----------------------------------------------------------------------------
Function: CBA_fnc_substring_new

Description:
    Retrieves a substring of this instance. The substring starts at a specified character position and has a specified length.

Parameters:
    _string - String to make replacement in [String]
    _startIndex - Index to start the substring extraction [Number]
    _lenth - lenth of the extracted substring [Number](Optinal) if is not set than from _startIndex to end

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
PARAMS_3(_string, _startIndex, _lenth);
// Check if _lenth is set else extrakt string to end
if (isNil "_lenth" || _lenth <= 0) exitWith { _string select [_startIndex]; };
// Cut out String
_string select [_startIndex, _lenth]; // Return
