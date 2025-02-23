#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalSay3D

Description:
    Says sound on all clients in 3D.

Parameters:
    _objects - Object or array of objects that perform Say <OBJECT, ARRAY>
    _params  - classname or parameter array - see biki: say3d <STRING, ARRAY>
    _range   - Maximum distance from camera to execute command - will be ignored if _params is an array (optional, default: nil) <NUMBER>
    _attach  - Attach created sound to _object (optional, default: false) <BOOL>

Returns:
    Nothing

Example:
    (begin example)
        [player, "Alarm", 500] call CBA_fnc_globalSay3D;
    (end)

Author:
    Sickboy, commy2, DartRuffian
---------------------------------------------------------------------------- */

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]], ["_distance", nil, [0]], ["_attach", false, [false]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

if (!isNil "_distance" && { _params isEqualType "" } ) then { _params = [_params, _distance]; };

{
    [QGVAR(say3D), [_x, _params, _attach]] call CBA_fnc_globalEvent;
} forEach _objects;

nil
