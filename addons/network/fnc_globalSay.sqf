#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_globalSay

Description:
    Says sound on all clients.

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
    Sickboy, commy2, DartRuffian
---------------------------------------------------------------------------- */

params [["_objects", [], [[], objNull]], ["_params", "", ["", []]]];

if (_objects isEqualType objNull) then {
    _objects = [_objects];
};

{
    [QGVAR(say), [_x, _params]] call CBA_fnc_globalEvent;
} forEach _objects;

nil
