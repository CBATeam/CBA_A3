#include "script_component.hpp"
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
        "group"      - player group changes
        "leader"     - leader of player changes

Parameters:
    _type      - Event handler type. <STRING>
    _function  - Function to add to event. <CODE>
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
        GVAR(oldLoadout) = [];
        GVAR(oldLoadoutNoAmmo) = [];
        GVAR(oldVehicle) = objNull;
        GVAR(oldTurret) = [];
        GVAR(oldVisionMode) = -1;
        GVAR(oldCameraView) = "";
        GVAR(oldVisibleMap) = false;

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["EachFrame", {call FUNC(playerEH_EachFrame)}];
        [QFUNC(playerEH_EachFrame), {
            private _player = call CBA_fnc_currentUnit;
            if !(_player isEqualTo GVAR(oldUnit)) then {
                [QGVAR(unitEvent), [_player, GVAR(oldUnit)]] call CBA_fnc_localEvent;
                GVAR(oldUnit) = _player;
            };

            private _data = group _player;
            if !(_data isEqualTo GVAR(oldGroup)) then {
                [QGVAR(groupEvent), [_player, GVAR(oldGroup)]] call CBA_fnc_localEvent;
                GVAR(oldGroup) = _data;
            };

            _data = leader _player;
            if !(_data isEqualTo GVAR(oldLeader)) then {
                [QGVAR(leaderEvent), [_player, GVAR(oldLeader)]] call CBA_fnc_localEvent;
                GVAR(oldLeader) = _data;
            };

            _data = currentWeapon _player;
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
        }] call CBA_fnc_compileFinal;

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["Map", {call FUNC(playerEH_Map)}];
        [QFUNC(playerEH_Map), {
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
    };

    GVAR(playerEHInfo) pushBack [_type, _id];
};

_id
