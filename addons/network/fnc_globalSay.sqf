/*
Function: CBA_fnc_globalSay

Description:
    Says sound on all client computer

Parameters:
    [_objects] - Array of Objects that perform Say [Object]
    _say - [sound, maxTitlesDistance,speed] or "sound" [Array or String]

Returns:

Example:
    (begin example)
        [[player], "Alarm01"] call CBA_fnc_globalSay;
    (end)

Author:
    Sickboy
*/
// Deprecated?, use now globalEvent
#include "script_component.hpp"
TRACE_1("",_this);

[QGVAR(say), _this] call CBA_fnc_globalEvent;
