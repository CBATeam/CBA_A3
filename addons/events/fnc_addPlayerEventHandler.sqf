#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPlayerEventHandler

Description:
    Adds a player event handler.

    Possible events:
        "unit"          - player controlled unit changed
        "weapon"        - currently selected weapon change
        "muzzle"        - currently selected muzzle change
        "weaponMode"    - currently selected weapon mode change
        "loadout"       - players loadout changed
        "vehicle"       - players current vehicle changed
        "turret"        - position in vehicle changed
        "visionMode"    - player changed to normal/night/thermal view
        "cameraView"    - camera mode changed ("Internal", "External", "Gunner" etc.)
        "featureCamera" - camera changed (Curator, Arsenal, Spectator etc.)
        "visibleMap"    - opened or closed map
        "group"         - player group changes
        "leader"        - leader of player changes

Parameters:
    _type               - Event handler type. <STRING>
    _function           - Function to add to event. <CODE>
    _applyRetroactively - Call function immediately if player is defined already (optional, default: false) <BOOL>

Returns:
    _id - The ID of the event handler. <NUMBER>

Examples:
    (begin example)
        _id = ["unit", {systemChat str _this}] call CBA_fnc_addPlayerEventHandler;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(addPlayerEventHandler);

if (!hasInterface) exitWith {-1};

params [["_type", "", [""]], ["_function", {}, [{}]], ["_applyRetroactively", false, [false]]];

_type = toLower _type;

private _id = switch (_type) do {
    case "unit": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), objNull] call _function;
        };
        [QGVAR(unitEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "weapon": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), currentWeapon GVAR(oldUnit)] call _function;
        };
        [QGVAR(weaponEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "muzzle": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), currentMuzzle GVAR(oldUnit)] call _function;
        };
        [QGVAR(muzzleEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "weaponmode": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), currentWeaponMode GVAR(oldUnit)] call _function;
        };
        [QGVAR(weaponModeEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "loadout": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), getUnitLoadout GVAR(oldUnit)] call _function;
        };
        [QGVAR(loadoutEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "vehicle": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), vehicle GVAR(oldUnit)] call _function;
        };
        [QGVAR(vehicleEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "turret": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), GVAR(oldUnit) call CBA_fnc_turretPath] call _function;
        };
        [QGVAR(turretEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "visionmode": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), currentVisionMode GVAR(oldUnit)] call _function;
        };
        [QGVAR(visionModeEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "cameraview": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), cameraView] call _function;
        };
        [QGVAR(cameraViewEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "featurecamera": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), call CBA_fnc_getActiveFeatureCamera] call _function;
        };
        [QGVAR(featureCameraEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "visiblemap": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), visibleMap] call _function;
        };
        [QGVAR(visibleMapEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "group": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), group GVAR(oldUnit)] call _function;
        };
        [QGVAR(groupEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "leader": {
        if (_applyRetroactively && {!isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
            [GVAR(oldUnit), group GVAR(oldUnit)] call _function;
        };
        [QGVAR(leaderEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    default {-1};
};

if (_id != -1) then {
    // add loop for polling if it doesn't exist yet
    if (isNil QGVAR(playerEHInfo)) then {
        GVAR(playerEHInfo) = [];

        GVAR(oldUnit) = objNull;
        GVAR(oldGroup) = grpNull;
        GVAR(oldLeader) = objNull;
        GVAR(oldWeapon) = "";
        GVAR(oldMuzzle) = "";
        GVAR(oldWeaponMode) = "";
        GVAR(oldLoadout) = [];
        GVAR(oldLoadoutNoAmmo) = [];
        GVAR(oldVehicle) = objNull;
        GVAR(oldTurret) = [];
        GVAR(oldVisionMode) = -1;
        GVAR(oldCameraView) = "";
        GVAR(oldFeatureCamera) = "";
        GVAR(oldVisibleMap) = false;
        GVAR(oldState) = [];

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["EachFrame", {call FUNC(playerEH_EachFrame)}];
        [QFUNC(playerEH_EachFrame), {
            SCRIPT(playerEH_EachFrame);
            private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
            private _vehicle = vehicle _unit;

            private _controlledEntity = _unit;
            if (!isNull getConnectedUAV _unit) then {
                private _uavControl = UAVControl getConnectedUAV _unit;
                _uavControl = _uavControl param [(_uavControl find _unit) + 1, ""];
                if (_uavControl isEqualTo "DRIVER") exitWith {
                    _controlledEntity = driver getConnectedUAV _unit;
                };

                if (_uavControl isEqualTo "GUNNER") exitWith {
                    _controlledEntity = gunner getConnectedUAV _unit;
                };
            };

            private _turret = [];
            if (_unit != _vehicle) then {
                _turret = allTurrets [_vehicle, true] select {_vehicle turretUnit _x == _unit} param [0, []];
            };

            private _state = [
                _unit, group _unit, leader _unit,
                currentWeapon _unit, currentMuzzle _unit, currentWeaponMode _unit,
                getUnitLoadout _unit,
                _vehicle, _turret,
                currentVisionMode _controlledEntity, cameraView
            ];

            if !(_state isEqualTo GVAR(oldState)) then {
                GVAR(oldState) = _state;

                _state params [
                    "_newunit", "_newGroup", "_newLeader",
                    "_newWeapon", "_newMuzzle", "_newWeaponMode",
                    "_newLoadout", "_newVehicle", "_newTurret",
                    "_newVisionMode", "_newCameraView"
                ];

                if !(_newunit isEqualTo GVAR(oldUnit)) then {
                    [QGVAR(unitEvent), [_unit, GVAR(oldUnit)]] call CBA_fnc_localEvent;
                    GVAR(oldUnit) = _unit;
                };

                if !(_newGroup isEqualTo GVAR(oldGroup)) then {
                    [QGVAR(groupEvent), [_unit, GVAR(oldGroup)]] call CBA_fnc_localEvent;
                    GVAR(oldGroup) = _newGroup;
                };

                if !(_newLeader isEqualTo GVAR(oldLeader)) then {
                    [QGVAR(leaderEvent), [_unit, GVAR(oldLeader)]] call CBA_fnc_localEvent;
                    GVAR(oldLeader) = _newLeader;
                };

                if !(_newWeapon isEqualTo GVAR(oldWeapon)) then {
                    [QGVAR(weaponEvent), [_unit, _newWeapon]] call CBA_fnc_localEvent;
                    GVAR(oldWeapon) = _newWeapon;
                };

                if !(_newMuzzle isEqualTo GVAR(oldMuzzle)) then {
                    [QGVAR(muzzleEvent), [_unit, _newMuzzle]] call CBA_fnc_localEvent;
                    GVAR(oldMuzzle) = _newMuzzle;
                };

                if !(_newWeaponMode isEqualTo GVAR(oldWeaponMode)) then {
                    [QGVAR(weaponModeEvent), [_unit, _newWeaponMode]] call CBA_fnc_localEvent;
                    GVAR(oldWeaponMode) = _newWeaponMode;
                };

                if !(_newLoadout isEqualTo GVAR(oldLoadout)) then {
                    // We don't want to trigger this just because your ammo counter decreased.
                    _newLoadoutNoAmmo = + _newLoadout;

                    {
                        private _weaponInfo = _newLoadoutNoAmmo param [_forEachIndex, []];
                        if !(_weaponInfo isEqualTo []) then {
                            _weaponInfo set [4, _x];
                            _weaponInfo deleteAt 5;
                        };
                    } forEach [primaryWeaponMagazine _unit, secondaryWeaponMagazine _unit, handgunMagazine _unit];

                    if !(_newLoadoutNoAmmo isEqualTo GVAR(oldLoadoutNoAmmo)) then {
                        [QGVAR(loadoutEvent), [_unit, GVAR(oldLoadout)]] call CBA_fnc_localEvent;
                        GVAR(oldLoadoutNoAmmo) = _newLoadoutNoAmmo;
                    };

                    GVAR(oldLoadout) = _newLoadout;
                };

                if !(_newVehicle isEqualTo GVAR(oldVehicle)) then {
                    [QGVAR(vehicleEvent), [_unit, _newVehicle]] call CBA_fnc_localEvent;
                    GVAR(oldVehicle) = _newVehicle;
                };

                if !(_newTurret isEqualTo GVAR(oldTurret)) then {
                    [QGVAR(turretEvent), [_unit, _newTurret]] call CBA_fnc_localEvent;
                    GVAR(oldTurret) = _newTurret;
                };

                if !(_newVisionMode isEqualTo GVAR(oldVisionMode)) then {
                    [QGVAR(visionModeEvent), [_unit, _newVisionMode]] call CBA_fnc_localEvent;
                    GVAR(oldVisionMode) = _newVisionMode;
                };

                if !(_newCameraView isEqualTo GVAR(oldCameraView)) then {
                    [QGVAR(cameraViewEvent), [_unit, _newCameraView]] call CBA_fnc_localEvent;
                    GVAR(oldCameraView) = _newCameraView;
                };
            };
        }] call CBA_fnc_compileFinal;

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["Map", {call FUNC(playerEH_Map)}];
        [QFUNC(playerEH_Map), {
            SCRIPT(playerEH_Map);
            params ["_data"]; // visibleMap is updated one frame later
            if !(_data isEqualTo GVAR(oldVisibleMap)) then {
                GVAR(oldVisibleMap) = _data;
                [QGVAR(visibleMapEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
            };
        }] call CBA_fnc_compileFinal;

        // emulate change to first value from default one frame later
        // using spawn-dc to not having to wait for postInit to complete
        0 spawn {
            {
                private _data = visibleMap;
                if !(_data isEqualTo GVAR(oldVisibleMap)) then {
                    GVAR(oldVisibleMap) = _data;
                    [QGVAR(visibleMapEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
                };
            } call CBA_fnc_directCall;
        };

        GVAR(playerEHInfo) pushBack ([{
            SCRIPT(playerEH_featureCamera);
            private _data = call CBA_fnc_getActiveFeatureCamera;
            if !(_data isEqualTo GVAR(oldFeatureCamera)) then {
                GVAR(oldFeatureCamera) = _data;
                [QGVAR(featureCameraEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
            };
        }, 0.5] call CBA_fnc_addPerFrameHandler);

    };

    GVAR(playerEHInfo) pushBack [_type, _id];
};

_id
