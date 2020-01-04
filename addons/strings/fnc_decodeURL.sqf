#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_decodeURL

Description:
    Reverse URL encoded text to readable text.

Parameters:
    _string - URL encoded text <STRING>

Returns:
    _return - Human readable text <STRING>

Examples:
    (begin example)
        "Mission%20Name" call CBA_fnc_decodeURL; // "Mission Name"
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_string", "", [""]]];
if (_string isEqualTo "") exitWith {""};

private _cache = missionNamespace getVariable [QGVAR(URLCache), objNull];
private _return = _cache getVariable _string;

if (isNil "_return") then {
    _return = _string;
    
    //Only need to check if there is atleast one character to replace in the stirng
    if ("%" in _return) then {
        {
            _return = ([_return] + _x) call CBA_fnc_replace;
        } forEach UTF8_TABLE;
    }
    if (isNull _cache) then {
        _cache = [] call CBA_fnc_createNamespace;
        missionNamespace setVariable [QGVAR(URLCache), _cache];
    };

    _cache setVariable [_string, _return];
};

_return
