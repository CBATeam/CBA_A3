#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_weaponEvents

Description:
    Execute weapon events framework.

    class MyWeapon: MyWeapon_base {
        class EventHandlers {
            fired = "_this call CBA_fnc_weaponEvents";
        };
    };

Parameters:
    _unit   - Unit that fired the weapon <OBJECT>
    _weapon - The weapon fired by the unit <STRING>

Returns:
    Nothing

Examples:
    (begin example)
        fired = "_this call CBA_fnc_weaponEvents";
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit", "_weapon", "_muzzle"];

private _config = configFile >> "CfgWeapons" >> _weapon >> "CBA_WeaponEvents";

private _isEmpty = _unit ammo _weapon == 0;
private _onEmpty = true;

if (isNumber (_config >> "onEmpty")) then {
    _onEmpty = getNumber (_config >> "onEmpty") == 1;
};

private _fnc_soundSource = {
    private _soundSourceName = format [QGVAR(soundSource_%1), _soundLocation];
    private _soundSource = _unit getVariable [_soundSourceName, objNull];

    if (isNull _soundSource) then {
        _soundSource = "#particlesource" createVehicleLocal [0,0,0];
    };

    if !(_soundSource in attachedObjects _unit) then {
        _soundSource attachTo [_unit, [0,0,0], _soundLocation];
        _unit setVariable [_soundSourceName, _soundSource];
    };

    _soundSource
};

if (_isEmpty) then {
    private _sound = getText (_config >> "soundEmpty");
    private _soundLocation = getText (_config >> "soundLocationEmpty");

    if (_sound != "") then {
        (call _fnc_soundSource) say3D _sound;
    };
};

if (!_isEmpty || _onEmpty) then {
    private _handAction = getText (_config >> "handAction");
    private _sound = getText (_config >> "sound");
    private _soundLocation = getText (_config >> "soundLocation");
    private _delay = getNumber (_config >> "delay");
    private _hasOptic = getNumber (_config >> "hasOptic") == 1;

    private _expectedMagazineCount = count magazines _unit;
    private _optic = weaponsItems _unit select {_x select 0 == _weapon} param [0, []] param [3, ""];

    if (_optic isEqualTo "" && _hasOptic) then {
        _optic = _weapon;
    };

    private _triggerReleased = false;

    [{
        params [
            "_unit", "_weapon", "_muzzle", "_optic",
            "_handAction", "_sound", "_soundSource",
            "_expectedMagazineCount", "_time", "_delay",
            "_triggerReleased"
        ];

        // exit if unit switched weapon
        if (currentWeapon _unit != _weapon) exitWith {true};

        // exit if unit started reloading
        if (count magazines _unit != _expectedMagazineCount) exitWith {true};

        // mode 0: while in gunner view, keep waiting
        // mode 1: while holding trigger, keep waiting
        // mode 2: while holding trigger and not pressing it, keep waiting
        private _wait = call ([{
            cameraView == "GUNNER" && _optic != ""
        }, {
            GVAR(triggerPressed)
        }, {
            !_triggerReleased || !GVAR(triggerPressed)
        }] select GVAR(weaponEventMode));

        if (_wait) exitWith {
            // Detect trigger release
            if (GVAR(weaponEventMode) == 2 && !GVAR(triggerPressed) then {
                _this set [9, true];
            };

            _this set [8, CBA_missionTime];
            _unit setWeaponReloadingTime [_unit, _muzzle, 1];
            false
        };

        // keep waiting until time over
        if (CBA_missionTime < _time + _delay) exitWith {false};

        if (local _unit) then {
            _unit playAction _handAction;
        };

        if (_sound != "") then {
            _soundSource say3D _sound;
        };

        true // exit loop
    }, {}, [
        _unit, _weapon, _muzzle, _optic,
        _handAction, _sound, call _fnc_soundSource,
        _expectedMagazineCount, CBA_missionTime, _delay,
        _triggerReleased
    ]] call CBA_fnc_waitUntilAndExecute;
};
