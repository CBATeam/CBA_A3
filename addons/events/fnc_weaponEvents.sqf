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
#include "script_component.hpp"

params ["_unit", "_weapon"];

private _config = configFile >> "CfgWeapons" >> _weapon >> "CBA_WeaponEvents";

private _isEmpty = _unit ammo _weapon == 0;
private _onEmpty = true;

if (isNumber (_config >> "onEmpty")) then {
    _onEmpty = getNumber (_config >> "onEmpty") == 1;
};

private _fnc_soundSource = {
    private _soundSourceName = format [QGVAR(soundSource_%1), _soundLocation];
    private _soundSource = _unit getVariable [_soundSourceName, objNull];

    if !(_soundSource in attachedObjects _unit) then {
        _soundSource = "#particlesource" createVehicleLocal [0,0,0];
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

    [{
        params ["_unit", "_handAction", "_sound", "_soundSource"];

        if (local _unit) then {
            _unit playAction _handAction;
        };

        if (_sound != "") then {
            _soundSource say3D _sound;
        };
    }, [_unit, _handAction, _sound, call _fnc_soundSource], _delay] call CBA_fnc_waitAndExecute;
};
