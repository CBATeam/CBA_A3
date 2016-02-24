/*
Function: CBA_fnc_globalSay

Description:
    Says sound on all client computer. DEPRECATED. Use remoteExec ["say"] instead.

Parameters:
    [_objects] - Array of Objects that perform Say [Object]
    _say - [sound, maxTitlesDistance,speed] or "sound" [Array or String]

Returns:

Example:
    (begin example)
        [[player], "Alarm"] call CBA_fnc_globalSay;
    (end)

Author:
    Sickboy, commy2
*/
#include "script_component.hpp"

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

{
    [_x, _params] remoteExecCall ["say"];
} forEach _objects;

nil
