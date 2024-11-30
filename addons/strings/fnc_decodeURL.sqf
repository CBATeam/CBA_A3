#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_decodeURL

Description:
    Reverse URL encoded text to readable text.

Parameters:
    _string - URL encoded text <STRING>

Returns:
    Human readable text <STRING>

Examples:
    (begin example)
        "Mission%20Name" call CBA_fnc_decodeURL; // "Mission Name"
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(decodeURL);

params [["_string", "", [""]]];

if (_string isEqualTo "") exitWith {""};

if (isNil QGVAR(URLCache)) then {
    GVAR(URLCache) = createHashMap;
};

private _return = GVAR(URLCache) get _string;

if (isNil "_return") then {
    _return = _string;

    // Only replace if there is at least one character to replace
    if ("%" in _return) then {
        {
            _return = ([_return] + _x) call CBA_fnc_replace;
        } forEach UTF8_TABLE;
    };

    GVAR(URLCache) set [_string, _return];
};

_return // return
