#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_selectWeapon

Description:
    Selects a weapon including correctly selecting a weapon mode of specified.

    Has to be executed on the machine where the unit is local.

Parameters:
    _unit   - Unit object to perform function on. <OBJECT>
    _weapon - Weapon or muzzle to select <STRING>
    _mode   - Weapon mode to switch to [optional] <STRING> (default: "")

Returns:
    Success or Failed <BOOLEAN>

Examples:
    (begin example)
    _result = [player, secondaryWeapon player] call CBA_fnc_selectWeapon;
    _result = [player, currentWeapon player, "FullAuto"] call CBA_fnc_selectWeapon;
    _result = [player, "LMG_M200_body"] call CBA_fnc_selectWeapon;
    (end)

Author:
    Sickboy, commy2, johnb43
---------------------------------------------------------------------------- */
SCRIPT(selectWeapon);

// Mode is not guaranteed to be config-case, so no case-sensitive comparisons possible
params [["_unit", objNull, [objNull]], ["_weapon", "", [""]], ["_mode", "", [""]]];

if (!local _unit) exitWith {false};

private _vehicle = [vehicle _unit, _unit] select (_unit call CBA_fnc_canUseWeapon);

// Holster weapon
if (_weapon == "") exitWith {
    _unit action ["SwitchWeapon", _vehicle, _unit, 299];

    currentMuzzle _unit == "" // return
};

// If on foot or in FFV
if (_unit isEqualTo _vehicle) then {
    private _weaponState = (_unit weaponState _weapon) select [0, 3];

    if (_mode != "") then {
        _weaponState set [2, _mode];
    };

    _unit selectWeapon _weaponState // return
} else {
    private _turretPath = _vehicle unitTurret _unit;
    (weaponState [_vehicle, _turretPath, _weapon]) params ["_weapon", "_muzzle", "_currentMode"];

    if (_mode == "") then {
        _mode = _currentMode;
    };

    _vehicle selectWeaponTurret [_weapon, _turretPath, _muzzle, _mode];

    // Get updated state
    (weaponState [_vehicle, _turretPath]) params ["_newWeapon", "_newMuzzle", "_newMode"];

    _newWeapon != "" && {_newWeapon == _weapon} && {_newMuzzle == _muzzle} && {_newMode == _mode} // return
};
