/*
Function: CBA_fnc_globalSay3d

DEPRECATED. Use <remoteExec at https://community.bistudio.com/wiki/remoteExec> ["say3D"] instead.

Description:
    Says sound on all client computer in 3D.

Parameters:
    _object - Object that performs Say [Object] can also be _array - [object, targetObject]
    _speechName - Speechname
    _range - (Optional parameter) maximum distance from camera to execute command [Number]

Returns:

Example:
    (begin example)
        [player, "Alarm", 500] call CBA_fnc_globalSay3d;
    (end)

Author:
    Sickboy, commy2
*/
#include "script_component.hpp"

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
