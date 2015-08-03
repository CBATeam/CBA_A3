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
    joko // Jonas
--------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(substring);

// ----------------------------------------------------------------------------
PARAMS_3(_string, _startIndex, _endIndex);
//params["_string","_startIndex","_endIndex"];
// Check if _start is Larger than _endIndex to Prevent Issues
if (_startIndex > _endIndex) exitWith {""};
// Calculate Differenz between _start and _end for select lenth value
_endIndex = _endIndex + 1 - _startIndex;
// Cut out String
_string select [_startIndex, _endIndex]; // Return
