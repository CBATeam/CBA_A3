/* ----------------------------------------------------------------------------
Function: CBA_fnc_addDisplayHandler

Description:
    Adds an action to the main display.

    They are reapplied after loading a save game. Actions only persist for the
    mission and are removed after restart.

Parameters:
    _type - Display handler type to attach. <STRING>
    _code - Code to execute upon event. <STRING, CODE>

Returns:
    _id - The ID of the attached handler. Used to remove with "CBA_fnc_removeDisplayHandler" <NUMBER>

Examples:
    (begin example)
        _id = ["KeyDown", {_this call myKeyDownEH}] call CBA_fnc_addDisplayHandler;
    (end)

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addDisplayHandler);

if (!hasInterface) exitWith {-1};

params [["_type", "", [""]], ["_code", "", ["", {}]]];

_type = toLower _type;

private _handlers = [GVAR(handlerHash), _type] call CBA_fnc_hashGet;

private _handlerId = (uiNamespace getVariable ["CBA_missionDisplay", displayNull]) displayAddEventHandler [_type, _code];

private _id = _handlers pushBack [_handlerId, _code];

[GVAR(handlerHash), _type, _handlers] call CBA_fnc_hashSet;

_id
