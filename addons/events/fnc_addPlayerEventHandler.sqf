/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPlayerEventHandler

Description:
    Adds a player event handler.

Parameters:
    _type      - Event handler type. <STRING>
    _function  - Function to add to event. <CODE>

Returns:
    _id - The ID of the event handler. Same as _thisID <NUMBER>

Examples:
    (begin example)
        _id = ["unit", {systemChat str _this}] call CBA_fnc_addPlayerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addPlayerEventHandler);

params [["_type", "", [""]], ["_function", {}, [{}]]];

_type = toLower _type;

if (isNil QGVAR(addedPlayerEvents)) then {
    GVAR(addedPlayerEvents) = [] call CBA_fnc_createNamespace;
};

switch (_type) do {
case ("unit"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldUnit) = objNull;
        GVAR(addedPlayerEvents) setVariable [_type,
            addMissionEventHandler ["EachFrame", {
                private _data = call CBA_fnc_currentUnit;
                if !(_data isEqualTo GVAR(oldUnit)) then {
                    GVAR(oldUnit) = _data;
                    [QGVAR(unitEvent), _data] call CBA_fnc_localEvent;
                };
            }]
        ];
    };

    // add event
    [QGVAR(unitEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("weapon"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldWeapon) = "<null>";
        GVAR(addedPlayerEvents) setVariable [_type,
            addMissionEventHandler ["EachFrame", {
                private _data = currentWeapon (call CBA_fnc_currentUnit);
                if !(_data isEqualTo GVAR(oldWeapon)) then {
                    GVAR(oldWeapon) = _data;
                    [QGVAR(weaponEvent), _data] call CBA_fnc_localEvent;
                };
            }]
        ];
    };

    // add event
    [QGVAR(weaponEvent), _function] call CBA_fnc_addEventHandler // return id
};
default {-1};
};
