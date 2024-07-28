#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_substr

Description:
    Retrieves a substring of this instance.
    The substring starts at a specified character position and has a specified length.

    Reliably supports strings with ANSI characters only.

Parameters:
    _string     - String to extract from <STRING>
    _startIndex - Index to start the substring extraction <SCALAR>
    _length     - Length of the extracted substring, <= 0 means whole string is selected (optional, default: 0) <SCALAR>

Returns:
    Extracted string <STRING>

Example:
    (begin example)
        _str = ["Fish frog cheese fromage", 5, 4] call CBA_fnc_substr;
        // => "frog"
    (end)

Author:
    joko // Jonas
--------------------------------------------------------------------------- */
SCRIPT(substr);

params ["_string", "_startIndex", ["_length", 0]];

// Check if _length is set else extract string to end
if (_length <= 0) exitWith {
    _string select [_startIndex] // return
};

// Cut out string
_string select [_startIndex, _length] // return
