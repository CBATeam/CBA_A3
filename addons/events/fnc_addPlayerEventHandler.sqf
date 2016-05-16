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

params [["_type", "", [""]], ["_function", {}, [{}]]];

_type = toLower _type;

private _id = switch (_type) do {
case ("unit"): {
    [QGVAR(unitEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("weapon"): {
    [QGVAR(weaponEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("loadout"): {
    [QGVAR(loadoutEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("vehicle"): {
    [QGVAR(vehicleEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("turret"): {
    [QGVAR(turretEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("visionmode"): {
    [QGVAR(visionModeEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("cameraview"): {
    [QGVAR(cameraViewEvent), _function] call CBA_fnc_addEventHandler // return id
};
case ("visiblemap"): {
    [QGVAR(visibleMapEvent), _function] call CBA_fnc_addEventHandler // return id
};
default {-1};
};

if (_id != -1) then {
    // add loop for polling if it doesn't exist yet
    if (isNil QGVAR(playerEHInfo)) then {
        GVAR(playerEHInfo) = [];

        GVAR(oldUnit) = objNull;
        GVAR(oldWeapon) = "";
        GVAR(oldLoadout) = [];
        GVAR(oldLoadoutNoAmmo) = [];
        GVAR(oldVehicle) = objNull;
        GVAR(oldTurret) = [];
        GVAR(oldVisionMode) = -1;
        GVAR(oldCameraView) = "";
        GVAR(oldVisibleMap) = false;

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["EachFrame", {
            private _player = call CBA_fnc_currentUnit;
            if !(_player isEqualTo GVAR(oldUnit)) then {
                GVAR(oldUnit) = _player;
                [QGVAR(unitEvent), [_player]] call CBA_fnc_localEvent;
            };

            private _data = currentWeapon _player;
            if !(_data isEqualTo GVAR(oldWeapon)) then {
                GVAR(oldWeapon) = _data;
                [QGVAR(weaponEvent), [_player, _data]] call CBA_fnc_localEvent;
            };

            _data = getUnitLoadout _player;
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
                } forEach [primaryWeaponMagazine _player, secondaryWeaponMagazine _player, handgunMagazine _player];

                if !(_data isEqualTo GVAR(oldLoadoutNoAmmo)) then {
                    GVAR(oldLoadoutNoAmmo) = _data;
                    [QGVAR(loadoutEvent), [_player, GVAR(oldLoadout)]] call CBA_fnc_localEvent;
                };
            };

            _data = vehicle _player;
            if !(_data isEqualTo GVAR(oldVehicle)) then {
                GVAR(oldVehicle) = _data;
                [QGVAR(vehicleEvent), [_player, _data]] call CBA_fnc_localEvent;
            };

            _data = _player call CBA_fnc_turretPath;
            if !(_data isEqualTo GVAR(oldTurret)) then {
                GVAR(oldTurret) = _data;
                [QGVAR(turretEvent), [_player, _data]] call CBA_fnc_localEvent;
            };

            _data = currentVisionMode _player;
            if !(_data isEqualTo GVAR(oldVisionMode)) then {
                GVAR(oldVisionMode) = _data;
                [QGVAR(visionModeEvent), [_player, _data]] call CBA_fnc_localEvent;
            };

            _data = cameraView;
            if !(_data isEqualTo GVAR(oldCameraView)) then {
                GVAR(oldCameraView) = _data;
                [QGVAR(cameraViewEvent), [_player, _data]] call CBA_fnc_localEvent;
            };

            _data = visibleMap;
            if !(_data isEqualTo GVAR(oldVisibleMap)) then {
                GVAR(oldVisibleMap) = _data;
                [QGVAR(visibleMapEvent), [_player, _data]] call CBA_fnc_localEvent;
            };
        }];
    };

    GVAR(playerEHInfo) pushBack [_type, _id];
};

_id
