#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalSay3d

Description:
    Says sound on all clients in 3D.

    DEPRECATED. Use <remoteExec at https://community.bistudio.com/wiki/remoteExec> ["say3D"] instead.

Parameters:
    _objects - Object or array of objects that perform Say <OBJECT, ARRAY>
    _params  - [sound, maxTitlesDistance,speed] or "sound" <STRING, ARRAY>
    _range   - Maximum distance from camera to execute command (optional) <NUMBER>

Returns:
    Nothing

Example:
    (begin example)
        [player, "Alarm", 500] call CBA_fnc_globalSay3d;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]], ["_distance", nil, [0]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

if (!isNil "_distance") then {
    _params = [_params, _distance];
};

{
    [_x, _params] remoteExecCall ["say3D"];
} forEach _objects;

nil
