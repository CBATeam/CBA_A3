#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_substring

Description:
    Extracts the index-based substring from a string.
    Reliably supports strings with ANSI characters only.

Parameters:
    _string     - String to extract from <STRING>
    _startIndex - Index to start the substring extraction <SCALAR>
    _endIndex   - Index to end the substring extraction <SCALAR>

Returns:
    Extracted string <STRING>

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", 5, 8] call CBA_fnc_substring;
        // => "frog"
    (end)

Author:
    jaynus, joko // Jonas
--------------------------------------------------------------------------- */
SCRIPT(substring);

params ["_string", "_startIndex", "_endIndex"];

// Check if _start is larger than _endIndex to prevent issues
if (_startIndex > _endIndex) exitWith {""};

// Calculate difference between _start and _end for select length value
_endIndex = _endIndex + 1 - _startIndex;

// Cut out string
_string select [_startIndex, _endIndex] // return
