/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeDisplayHandler

Description:
    Removes an action from the main display.

Parameters:
    _type - Display handler type to remove. <STRING>
    _id   - Display handler ID to remove. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        ["KeyDown", _id] call CBA_fnc_removeDisplayHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeDisplayHandler);

if (!hasInterface) exitWith {};

params [["_type", "", [""]], ["_id", -1, [0]]];

_type = toLower _type;

if (_id < 0) exitWith {};

private _handlers = [GVAR(handlerHash), _type] call CBA_fnc_hashGet;

private _handler = _handlers param [_id];

if (!isNil "_handler") then {
    (uiNamespace getVariable ["CBA_missionDisplay", displayNull]) displayRemoveEventHandler [_type, _handler param [0, -1]];

    _handlers set [_id, []];

    [GVAR(handlerHash), _type, _handlers] call CBA_fnc_hashSet;
};

nil
