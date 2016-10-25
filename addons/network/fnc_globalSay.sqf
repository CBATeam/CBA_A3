/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalSay

Description:
    Says sound on all clients.

    DEPRECATED. Use <remoteExec at https://community.bistudio.com/wiki/remoteExec> ["say"] instead.

Parameters:
    _objects - Object or array of objects that perform Say <OBJECT, ARRAY>
    _params  - [sound, maxTitlesDistance,speed] or "sound" <ARRAY, STRING>

Returns:
    Nothing

Example:
    (begin example)
        [[player], "Alarm"] call CBA_fnc_globalSay;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

{
    [_x, _params] remoteExecCall ["say"];
} forEach _objects;

nil
