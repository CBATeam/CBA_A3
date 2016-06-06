/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFirer

Description:
    A function used to find out which unit exactly fired.

    Replacement for gunner, on multi-turret vehicles.

Parameters:
    _vehicle - a vehicle with turrets <OBJECT>
    _weapon  - a weapon in the vehicles turret <STRING>

Example:
    (begin example)
        _turretPath = [cameraOn, "HMG_127_mbt"] call CBA_fnc_getFirer
    (end)

Returns:
    <ARRAY>
        Firer of the weapon. objNull if the weapon does not exist on the vehicle <OBJECT>
        Turret path of the firer. [] if firer is not in a turret <ARRAY>

Author:
    Rocko, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getFirer);

params [["_vehicle", objNull, [objNull]], ["_weapon", "", [""]]];

_weapon = configName (configFile >> "CfgWeapons" >> _weapon); // fix case sensitivity issues

private _gunner = objNull;
private _turret = [];

if (driver _vehicle isEqualTo _vehicle) then {
    // handle soldiers
    private _weapons = weapons _vehicle;

    _weapons append [
        configName (configFile >> "CfgWeapons" >> "Throw"),
        configName (configFile >> "CfgWeapons" >> "Put")
    ];

    if (_weapon in _weapons) then {
        _gunner = driver _vehicle;
    };
} else {
    // handle vehicles
    private _turrets = allTurrets _vehicle;
    _turrets pushBack [-1];

    {
        if (_weapon in (_vehicle weaponsTurret _x)) exitWith {
            if (_x isEqualTo [-1]) then {
                _gunner = driver _vehicle;
            } else {
                _gunner = _vehicle turretUnit _x;
                _turret = _x;
            };

            // at least return something when pilot used manual fire
            if (isNull _gunner && {isManualFire _vehicle}) then {
                _gunner = effectiveCommander _vehicle;
            };
        };
    } forEach _turrets;
};

[_gunner, _turret]
