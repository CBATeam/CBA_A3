#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_decodeHTML

Description:
    Reverse HTML encoded text to readable text.

Parameters:
    _string - HTML encoded text <STRING>

Returns:
    _return - Human readable text <STRING>

Examples:
    (begin example)
        "Mission%20Name" call CBA_fnc_decodeHTML; // "Mission Name"
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

#define UTF8_TABLE [\
    ["%e4","ä"],\
    ["%f6","ö"],\
    ["%fc","ü"],\
    ["%c4","Ä"],\
    ["%d6","Ö"],\
    ["%dc","Ü"],\
    ["%df","ß"],\
    ["%20"," "],\
    ["%21","!"],\
    ["%3F","?"],\
    ["%2e","."],\
    ["%25","%"]\
]

params [["_string", "", [""]]];
if (_string isEqualTo "") exitWith {""};

private _cache = missionNamespace getVariable [QGVAR(HTMLCache), objNull];
private _return = _cache getVariable _string;

if (isNil "_return") then {
    _return = _string;

    {
        _return = ([_return] + _x) call CBA_fnc_replace;
    } forEach UTF8_TABLE;

    if (isNull _cache) then {
        _cache = [] call CBA_fnc_createNamespace;
        missionNamespace setVariable [QGVAR(HTMLCache), _cache];
    };

    _cache setVariable [_string, _return];
};

_return
