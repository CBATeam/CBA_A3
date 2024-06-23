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

// Unlike CBA_fnc_turretPath, this will return [-1] when player is driver
private _turret = _vehicle unitTurret _unit;

private _state = [
    _unit, group _unit, leader _unit,
    currentWeapon _unit, currentMuzzle _unit, currentWeaponMode _unit,
    getUnitLoadout _unit, _vehicle, _turret, _vehicle currentWeaponTurret _turret,
    currentVisionMode focusOn, cameraView
];

if (_state isNotEqualTo GVAR(oldState)) then {
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

    if (_unit isNotEqualTo GVAR(oldUnit)) then {
        LOG_2("unit playerEvent - new: %1 - old: %2",_unit,GVAR(oldUnit));
        [QGVAR(unitEvent), [_unit, GVAR(oldUnit)]] call CBA_fnc_localEvent;
        GVAR(oldUnit) = _unit;
    };

    if (_newGroup isNotEqualTo GVAR(oldGroup)) then {
        LOG_2("group playerEvent - new: %1 - old: %2",_newGroup,GVAR(oldGroup));
        [QGVAR(groupEvent), [_unit, GVAR(oldGroup), _newGroup]] call CBA_fnc_localEvent; // intentionally reversed order for backwards compatiblity
        GVAR(oldGroup) = _newGroup;
    };

    if (_newLeader isNotEqualTo GVAR(oldLeader)) then {
        LOG_2("leader playerEvent - new: %1 - old: %2",_newLeader,GVAR(oldLeader));
        [QGVAR(leaderEvent), [_unit, GVAR(oldLeader), _newLeader]] call CBA_fnc_localEvent; // intentionally reversed order for backwards compatiblity
        GVAR(oldLeader) = _newLeader;
    };

    if (_newWeapon isNotEqualTo GVAR(oldWeapon)) then {
        LOG_2("weapon playerEvent - new: %1 - old: %2",_newWeapon,GVAR(oldWeapon));
        [QGVAR(weaponEvent), [_unit, _newWeapon, GVAR(oldWeapon)]] call CBA_fnc_localEvent;
        GVAR(oldWeapon) = _newWeapon;
    };

    if (_newTurretWeapon isNotEqualTo GVAR(oldTurretWeapon)) then {
        LOG_2("turretWeapon playerEvent - new: %1 - old: %2",_newTurretWeapon,GVAR(oldTurretWeapon));
        [QGVAR(turretWeaponEvent), [_unit, _newTurretWeapon, GVAR(oldTurretWeapon)]] call CBA_fnc_localEvent;
        GVAR(oldTurretWeapon) = _newTurretWeapon;
    };

    if (_newMuzzle isNotEqualTo GVAR(oldMuzzle)) then {
        LOG_2("muzzle playerEvent - new: %1 - old: %2",_newMuzzle select 2,GVAR(oldMuzzle) select 2);
        [QGVAR(muzzleEvent), [_unit, _newMuzzle select 2, GVAR(oldMuzzle) select 2]] call CBA_fnc_localEvent;
        GVAR(oldMuzzle) = _newMuzzle;
    };

    if (_newWeaponMode isNotEqualTo GVAR(oldWeaponMode)) then {
        LOG_2("group playerEvent - new: %1 - old: %2",_newWeaponMode select 2,GVAR(oldWeaponMode) select 2);
        [QGVAR(weaponModeEvent), [_unit, _newWeaponMode select 2, GVAR(oldWeaponMode) select 2]] call CBA_fnc_localEvent;
        GVAR(oldWeaponMode) = _newWeaponMode;
    };

    if (_newLoadout isNotEqualTo GVAR(oldLoadout)) then {
        // We don't want to trigger this just because your ammo counter decreased.
        private _newLoadoutNoAmmo = + _newLoadout;

        {
            private _weaponInfo = _newLoadoutNoAmmo param [_forEachIndex, []];
            if (_weaponInfo isNotEqualTo []) then {
                _weaponInfo set [4, _x];
                _weaponInfo deleteAt 5;
            };
        } forEach [primaryWeaponMagazine _unit, secondaryWeaponMagazine _unit, handgunMagazine _unit];

        if (_newLoadoutNoAmmo isNotEqualTo GVAR(oldLoadoutNoAmmo)) then {
            LOG_2("loadout playerEvent - new: %1 - old: %2",_newLoadout,GVAR(oldLoadout));
            [QGVAR(loadoutEvent), [_unit, _newLoadout, GVAR(oldLoadout)]] call CBA_fnc_localEvent;
            GVAR(oldLoadoutNoAmmo) = _newLoadoutNoAmmo;
        };

        GVAR(oldLoadout) = _newLoadout;
    };

    if (_vehicle isNotEqualTo GVAR(oldVehicle)) then {
        LOG_2("vehicle playerEvent - new: %1 - old: %2",_newVehicle,GVAR(oldVehicle));
        [QGVAR(vehicleEvent), [_unit, _vehicle, GVAR(oldVehicle)]] call CBA_fnc_localEvent;
        GVAR(oldVehicle) = _vehicle;
    };

    if (_turret isNotEqualTo GVAR(oldTurret)) then {
        LOG_2("turret playerEvent - new: %1 - old: %2",_newTurret,GVAR(oldTurret));
        [QGVAR(turretEvent), [_unit, _turret, GVAR(oldTurret)]] call CBA_fnc_localEvent;
        GVAR(oldTurret) = _turret;
    };

    if (_newVisionMode isNotEqualTo GVAR(oldVisionMode)) then {
        LOG_2("visionMode playerEvent - new: %1 - old: %2",_newVisionMode,GVAR(oldVisionMode));
        [QGVAR(visionModeEvent), [_unit, _newVisionMode, GVAR(oldVisionMode)]] call CBA_fnc_localEvent;
        GVAR(oldVisionMode) = _newVisionMode;
    };

    if (_newCameraView isNotEqualTo GVAR(oldCameraView)) then {
        LOG_2("cameraView playerEvent - new: %1 - old: %2",_newCameraView,GVAR(oldCameraView));
        [QGVAR(cameraViewEvent), [_unit, _newCameraView, GVAR(oldCameraView)]] call CBA_fnc_localEvent;
        GVAR(oldCameraView) = _newCameraView; // This assignment may be returned.
    };
};
