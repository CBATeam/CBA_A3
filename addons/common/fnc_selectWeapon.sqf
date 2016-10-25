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
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(selectWeapon);

#define MAXIMUM_TRIES 100

params [["_unit", objNull, [objNull]], ["_weapon", "", [""]], ["_mode", "", [""]]];

if (!local _unit) exitWith {false};

private _vehicle = [vehicle _unit, _unit] select (_unit call CBA_fnc_canUseWeapon);

private _index = 0;

if (_mode isEqualTo "") then {
    while {_index < MAXIMUM_TRIES && {currentMuzzle _unit != _weapon}} do {
        _unit action ["SwitchWeapon", _vehicle, _unit, _index];
        _index = _index + 1;
    };
} else {
    while {_index < MAXIMUM_TRIES && {currentMuzzle _unit != _weapon || {currentWeaponMode _unit != _mode}}} do {
        _unit action ["SwitchWeapon", _vehicle, _unit, _index];
        _index = _index + 1;
    };
};

_index < MAXIMUM_TRIES // return
