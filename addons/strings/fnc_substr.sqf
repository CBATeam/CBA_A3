#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_substr

Description:
    Retrieves a substring of this instance.

    The substring starts at a specified character position and has a specified length.

Parameters:
    _string - String to extract from [String]
    _startIndex - Index to start the substring extraction [Number]
    _length - length of the extracted substring [Number](Optional) if is not set than from _startIndex to end

Returns:
    String extracted [String]

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", 5, 4] call CBA_fnc_substr;
        // => "frog"
    (end)

Author:
    joko // Jonas
--------------------------------------------------------------------------- */
SCRIPT(substr);

params ["_string", "_startIndex", "_length"];

// Check if _length is set else extract string to end
if (isNil "_length" || {_length <= 0}) exitWith {_string select [_startIndex];};

// Cut out String
_string select [_startIndex, _length] // return
