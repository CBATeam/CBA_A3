#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_events_fnc_playerEvent

Description:
    Poll player event states and possibly raise events on state change.

Parameters:
    None.

Returns:
    Nothing. (May return assignment.)

Examples:
    (begin example)
        call CBA_events_fnc_playerEvent;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(playerEvent);

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];
private _vehicle = vehicle _unit;

private _controlledEntity = _unit;
if (!isNull getConnectedUAV _unit) then {
    private _uavControl = UAVControl getConnectedUAV _unit;
    _uavControl = _uavControl param [(_uavControl find _unit) + 1, ""]; // Will be position STRING if actively controlling, or OBJECT if not.
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
    getUnitLoadout _unit, _vehicle, _turret, _vehicle currentWeaponTurret _turret,
    currentVisionMode _controlledEntity, cameraView
];

if !(_state isEqualTo GVAR(oldState)) then {
    GVAR(oldState) = _state;

    _state params [
        "", "_newGroup", "_newLeader",
        "_newWeapon", "_newMuzzle", "_newWeaponMode",
        "_newLoadout", "", "", "_newTurretWeapon",
        "_newVisionMode", "_newCameraView"
    ];

    // These events should fire if the context of the state has changed.
    // I.e. switching to a different weapon with "Single" fire mode is an implicit weapon mode switch.
    // The modes just happen to share the same name.
    _newMuzzle = [_unit, _newWeapon, _newMuzzle];
    _newWeaponMode = [_unit, _newMuzzle, _newWeaponMode];

    if !(_unit isEqualTo GVAR(oldUnit)) then {
        [QGVAR(unitEvent), [_unit, GVAR(oldUnit)]] call CBA_fnc_localEvent;
        GVAR(oldUnit) = _unit;
    };

    if !(_newGroup isEqualTo GVAR(oldGroup)) then {
        [QGVAR(groupEvent), [_unit, GVAR(oldGroup), _newGroup]] call CBA_fnc_localEvent;
        GVAR(oldGroup) = _newGroup;
    };

    if !(_newLeader isEqualTo GVAR(oldLeader)) then {
        [QGVAR(leaderEvent), [_unit, GVAR(oldLeader), _newLeader]] call CBA_fnc_localEvent;
        GVAR(oldLeader) = _newLeader;
    };

    if !(_newWeapon isEqualTo GVAR(oldWeapon)) then {
        [QGVAR(weaponEvent), [_unit, _newWeapon, GVAR(oldWeapon)]] call CBA_fnc_localEvent;
        GVAR(oldWeapon) = _newWeapon;
    };

    if !(_newTurretWeapon isEqualTo GVAR(oldTurretWeapon)) then {
        [QGVAR(turretWeaponEvent), [_unit, _newTurretWeapon, GVAR(oldTurretWeapon)]] call CBA_fnc_localEvent;
        GVAR(oldTurretWeapon) = _newTurretWeapon;
    };

    if !(_newMuzzle isEqualTo GVAR(oldMuzzle)) then {
        [QGVAR(muzzleEvent), [_newMuzzle select 2, GVAR(oldMuzzle) select 2]] call CBA_fnc_localEvent;
        GVAR(oldMuzzle) = _newMuzzle;
    };

    if !(_newWeaponMode isEqualTo GVAR(oldWeaponMode)) then {
        [QGVAR(weaponModeEvent), [_unit, _newWeaponMode select 2, GVAR(oldWeaponMode) select 2]] call CBA_fnc_localEvent;
        GVAR(oldWeaponMode) = _newWeaponMode;
    };

    if !(_newLoadout isEqualTo GVAR(oldLoadout)) then {
        // We don't want to trigger this just because your ammo counter decreased.
        private _newLoadoutNoAmmo = + _newLoadout;

        {
            private _weaponInfo = _newLoadoutNoAmmo param [_forEachIndex, []];
            if !(_weaponInfo isEqualTo []) then {
                _weaponInfo set [4, _x];
                _weaponInfo deleteAt 5;
            };
        } forEach [primaryWeaponMagazine _unit, secondaryWeaponMagazine _unit, handgunMagazine _unit];

        if !(_newLoadoutNoAmmo isEqualTo GVAR(oldLoadoutNoAmmo)) then {
            [QGVAR(loadoutEvent), [_unit, _newLoadout, GVAR(oldLoadout)]] call CBA_fnc_localEvent;
            GVAR(oldLoadoutNoAmmo) = _newLoadoutNoAmmo;
        };

        GVAR(oldLoadout) = _newLoadout;
    };

    if !(_vehicle isEqualTo GVAR(oldVehicle)) then {
        [QGVAR(vehicleEvent), [_unit, _vehicle, GVAR(oldVehicle)]] call CBA_fnc_localEvent;
        GVAR(oldVehicle) = _vehicle;
    };

    if !(_turret isEqualTo GVAR(oldTurret)) then {
        [QGVAR(turretEvent), [_unit, _turret, GVAR(oldTurret)]] call CBA_fnc_localEvent;
        GVAR(oldTurret) = _turret;
    };

    if !(_newVisionMode isEqualTo GVAR(oldVisionMode)) then {
        [QGVAR(visionModeEvent), [_unit, _newVisionMode, GVAR(oldVisionMode)]] call CBA_fnc_localEvent;
        GVAR(oldVisionMode) = _newVisionMode;
    };

    if !(_newCameraView isEqualTo GVAR(oldCameraView)) then {
        [QGVAR(cameraViewEvent), [_unit, _newCameraView, GVAR(oldCameraView)]] call CBA_fnc_localEvent;
        GVAR(oldCameraView) = _newCameraView; // This assignment may be returned.
    };
};
