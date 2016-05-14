/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPlayerEventHandler

Description:
    Adds a player event handler.

    Possible events:
        "unit"       - player controlled unit changed
        "weapon"     - currently selected weapon change
        "loadout"    - players loadout changed
        "vehicle"    - players current vehicle changed
        "turret"     - position in vehicle changed
        "visionMode" - player changed to normal/night/thermal view
        "cameraView" - camera mode changed ("Internal", "External", "Gunner" etc.)
        "visibleMap" - opened or closed map

Parameters:
    _type      - Event handler type. <STRING>
    _function  - Function to add to event. <CODE>

Returns:
    _id - The ID of the event handler. <NUMBER>

Examples:
    (begin example)
        _id = ["unit", {systemChat str _this}] call CBA_fnc_addPlayerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addPlayerEventHandler);

#define PLAYER_UNIT (missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player])

params [["_type", "", [""]], ["_function", {}, [{}]]];

if (isNil QGVAR(addedPlayerEvents)) then {
    GVAR(addedPlayerEvents) = [] call CBA_fnc_createNamespace;
};

switch (toLower _type) do {
case ("unit"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldUnit) = objNull;
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = PLAYER_UNIT;
            if !(_data isEqualTo GVAR(oldUnit)) then {
                GVAR(oldUnit) = _data;
                [QGVAR(unitEvent), [_data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(unitEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("weapon"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldWeapon) = "";
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = currentWeapon PLAYER_UNIT;
            if !(_data isEqualTo GVAR(oldWeapon)) then {
                GVAR(oldWeapon) = _data;
                [QGVAR(weaponEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(weaponEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("loadout"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldLoadout) = [];
        GVAR(oldLoadoutNoAmmo) = [];
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = getUnitLoadout PLAYER_UNIT;
            if !(_data isEqualTo GVAR(oldLoadout)) then {
                GVAR(oldLoadout) = _data;

                // we don't want to trigger this just because your ammo counter decreased.
                _data = + GVAR(oldLoadout);

                {
                    private _weaponInfo = _data param [_forEachIndex, []];
                    if !(_weaponInfo isEqualTo []) then {
                        _weaponInfo set [4, _x];
                        _weaponInfo deleteAt 5;
                    };
                } forEach [primaryWeaponMagazine PLAYER_UNIT, secondaryWeaponMagazine PLAYER_UNIT, handgunMagazine PLAYER_UNIT];

                if !(_data isEqualTo GVAR(oldLoadoutNoAmmo)) then {
                    GVAR(oldLoadoutNoAmmo) = _data;
                    [QGVAR(loadoutEvent), [PLAYER_UNIT, GVAR(oldLoadout)]] call CBA_fnc_localEvent;
                };
            };
        }]];
    };

    // add event
    [QGVAR(loadoutEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("vehicle"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldVehicle) = objNull;
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = vehicle PLAYER_UNIT;
            if !(_data isEqualTo GVAR(oldVehicle)) then {
                GVAR(oldVehicle) = _data;
                [QGVAR(vehicleEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(vehicleEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("turret"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldTurret) = [];
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = PLAYER_UNIT call CBA_fnc_turretPath;
            if !(_data isEqualTo GVAR(oldTurret)) then {
                GVAR(oldTurret) = _data;
                [QGVAR(turretEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(turretEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("visionmode"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldVisionMode) = -1;
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = currentVisionMode PLAYER_UNIT;
            if !(_data isEqualTo GVAR(oldVisionMode)) then {
                GVAR(oldVisionMode) = _data;
                [QGVAR(visionModeEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(visionModeEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("cameraview"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldCameraView) = "";
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = cameraView;
            if !(_data isEqualTo GVAR(oldCameraView)) then {
                GVAR(oldCameraView) = _data;
                [QGVAR(cameraViewEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(cameraViewEvent), _function] call CBA_fnc_addEventHandler // return id
};

case ("visiblemap"): {
    // add loop for polling if it doesn't exist yet
    if (isNil {GVAR(addedPlayerEvents) getVariable _type}) then {
        GVAR(oldVisibleMap) = false;
        GVAR(addedPlayerEvents) setVariable [_type, addMissionEventHandler ["EachFrame", {
            private _data = visibleMap;
            if !(_data isEqualTo GVAR(oldVisibleMap)) then {
                GVAR(oldVisibleMap) = _data;
                [QGVAR(visibleMapEvent), [PLAYER_UNIT, _data]] call CBA_fnc_localEvent;
            };
        }]];
    };

    // add event
    [QGVAR(visibleMapEvent), _function] call CBA_fnc_addEventHandler // return id
};
default {-1};
};
