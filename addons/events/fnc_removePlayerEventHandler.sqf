/* ----------------------------------------------------------------------------
Function: CBA_fnc_removePlayerEventHandler

Description:
    Removes a player event handler.

Parameters:
    _type - Event handler type. <STRING>
    _id   - The ID of the event handler. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        ["unit", _id] call CBA_fnc_removePlayerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removePlayerEventHandler);

params [["_type", "", [""]], ["_id", -1, [0]]];

_type = toLower _type;

switch (_type) do {
    case "unit": {
        [QGVAR(unitEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "weapon": {
        [QGVAR(weaponEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "loadout": {
        [QGVAR(loadoutEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "vehicle": {
        [QGVAR(vehicleEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "turret": {
        [QGVAR(turretEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "visionmode": {
        [QGVAR(visionModeEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "cameraview": {
        [QGVAR(cameraViewEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "visiblemap": {
        [QGVAR(visibleMapEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "group": {
        [QGVAR(groupEvent), _id] call CBA_fnc_removeEventHandler;
    };
    case "leader": {
        [QGVAR(leaderEvent), _id] call CBA_fnc_removeEventHandler;
    };
    default {nil};
};

if (!isNil QGVAR(playerEHInfo)) then {
    GVAR(playerEHInfo) deleteAt (GVAR(playerEHInfo) find [_type, _id]);

    // First two entries are mission eventhandler ids. Rest are framework
    // specific ids in array form. If all playerChanged eventhandlers were
    // removed, then also clean up the mission eventhandlers.
    if (count GVAR(playerEHInfo) == 2) then {
        removeMissionEventHandler ["EachFrame", GVAR(playerEHInfo) select 0];
        removeMissionEventHandler ["Map",       GVAR(playerEHInfo) select 1];
        GVAR(playerEHInfo) = nil;
    };
};

nil
