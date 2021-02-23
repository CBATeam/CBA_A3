#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPlayerEventHandler

Description:
    Adds a player event handler.

    Possible events:
        "unit"          - player controlled unit changed
        "weapon"        - currently selected weapon change
        "turretweapon"  - currently selected turret weapon change
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

// Skip retroactive execution if no current unit.
if (_applyRetroactively && {isNull (missionNamespace getVariable [QGVAR(oldUnit), objNull])}) then {
    _applyRetroactively = false;
};

private _id = switch (_type) do {
    case "unit": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), objNull] call _function;
        };
        [QGVAR(unitEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "weapon": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), currentWeapon GVAR(oldUnit), ""] call _function;
        };
        [QGVAR(weaponEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "turretweapon": {
        if (_applyRetroactively) then {
            private _vehicle = vehicle GVAR(oldUnit);
            private _turret = _vehicle unitTurret GVAR(oldUnit);
            [GVAR(oldUnit), _vehicle currentWeaponTurret _turret, ""] call _function;
        };
        [QGVAR(turretWeaponEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "muzzle": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), currentMuzzle GVAR(oldUnit), ""] call _function;
        };
        [QGVAR(muzzleEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "weaponmode": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), currentWeaponMode GVAR(oldUnit), ""] call _function;
        };
        [QGVAR(weaponModeEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "loadout": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), getUnitLoadout GVAR(oldUnit), []] call _function;
        };
        [QGVAR(loadoutEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "vehicle": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), vehicle GVAR(oldUnit), objNull] call _function;
        };
        [QGVAR(vehicleEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "turret": {
        if (_applyRetroactively) then {
            private _vehicle = vehicle GVAR(oldUnit);
            private _turret = _vehicle unitTurret GVAR(oldUnit);
            [GVAR(oldUnit), _turret, []] call _function;
        };
        [QGVAR(turretEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "visionmode": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), currentVisionMode GVAR(oldUnit), -1] call _function;
        };
        [QGVAR(visionModeEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "cameraview": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), cameraView, ""] call _function;
        };
        [QGVAR(cameraViewEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "featurecamera": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), call CBA_fnc_getActiveFeatureCamera] call _function;
        };
        [QGVAR(featureCameraEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "visiblemap": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), visibleMap] call _function;
        };
        [QGVAR(visibleMapEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "group": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), GVAR(oldGroup), GVAR(oldGroup)] call _function; // backwards compatiblity
        };
        [QGVAR(groupEvent), _function] call CBA_fnc_addEventHandler // return id
    };
    case "leader": {
        if (_applyRetroactively) then {
            [GVAR(oldUnit), GVAR(oldLeader), GVAR(oldLeader)] call _function; //backwards compatiblity
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
        GVAR(oldTurretWeapon) = "";
        GVAR(oldMuzzle) = [objNull, "", ""];
        GVAR(oldWeaponMode) = [objNull, GVAR(oldMuzzle), ""];
        GVAR(oldLoadout) = [];
        GVAR(oldLoadoutNoAmmo) = [];
        GVAR(oldVehicle) = objNull;
        GVAR(oldTurret) = [];
        GVAR(oldVisionMode) = -1;
        GVAR(oldCameraView) = "";
        GVAR(oldFeatureCamera) = "";
        GVAR(oldVisibleMap) = false;
        GVAR(oldState) = [];

        GVAR(playerEHInfo) pushBack addMissionEventHandler ["EachFrame", {call FUNC(playerEvent)}];
        GVAR(playerEHInfo) pushBack addMissionEventHandler ["Map", {
            SCRIPT(playerEvent_Map);

            params ["_data"]; // visibleMap is updated one frame later
            if (_data isNotEqualTo GVAR(oldVisibleMap)) then {
                GVAR(oldVisibleMap) = _data;
                [QGVAR(visibleMapEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
            };
        }];

        // emulate change to first value from default one frame later
        // using spawn-dc to not having to wait for postInit to complete
        0 spawn {
            {
                private _data = visibleMap;
                if (_data isNotEqualTo GVAR(oldVisibleMap)) then {
                    GVAR(oldVisibleMap) = _data;
                    [QGVAR(visibleMapEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
                };
            } call CBA_fnc_directCall;
        };

        GVAR(playerEHInfo) pushBack ([{
            SCRIPT(playerEH_featureCamera);

            private _data = call CBA_fnc_getActiveFeatureCamera;
            if (_data isNotEqualTo GVAR(oldFeatureCamera)) then {
                GVAR(oldFeatureCamera) = _data;
                [QGVAR(featureCameraEvent), [call CBA_fnc_currentUnit, _data]] call CBA_fnc_localEvent;
            };
        }, 0.5] call CBA_fnc_addPerFrameHandler);

    };

    GVAR(playerEHInfo) pushBack [_type, _id];
};

_id
