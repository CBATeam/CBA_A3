#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_escapeRegex

Description:
    Escapes special characters used in regex from a string

Parameters:
    _string   - String to sanitize <STRING>

Returns:
    Safe string <STRING>

Examples:
    (begin example)
        "\Q.*?AK-15.*?\E" call CBA_fnc_escapeRegex;
    (end)

Author:
    LinkIsGrim
---------------------------------------------------------------------------- */
SCRIPT(escapeRegex);

params [["_string", "", [""]]];

// https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Regular_Expressions#escaping
_string regexReplace ["[.?*+^$[\]\\(){}|-]/gio", "\\$&"]
