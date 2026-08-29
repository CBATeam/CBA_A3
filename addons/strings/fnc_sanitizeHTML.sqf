#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_sanitizeHTML

Description:
    Replaces all < > and & with HTML character codes.

Parameters:
    _string - String to sanitize <STRING>

Returns:
    Sanitized string <STRING>

Example:
    (begin example)
        "&<br/>abc" call CBA_fnc_sanitizeHTML; // "<&amp;><br/>abc"
    (end)

Author:
    commy2
--------------------------------------------------------------------------- */
SCRIPT(sanitizeHTML);

params ["_string"];

_string = [_string, "&", "&amp;"] call CBA_fnc_replace;
_string = [_string, "<", "&lt;"] call CBA_fnc_replace;
_string = [_string, ">", "&gt;"] call CBA_fnc_replace;

[_string, "&lt;br/&gt;", "<br/>"] call CBA_fnc_replace // return
