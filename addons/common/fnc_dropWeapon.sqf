#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_dropWeapon

Description:
    Drops a weapon (including binocular).

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success

Parameters:
    _unit - the unit that should drop a weapon <OBJECT>
    _item - class name of the weapon to drop <STRING>
    _skipAnim - does not play the animation when true (optional, default: false) <BOOLEAN>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, primaryWeapon player] call CBA_fnc_dropWeapon
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(dropWeapon);

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_skipAnim", false, [true]]];

private _weaponInfo = [];

{
    if (_x param [0, ""] == _item) exitWith {
        _weaponInfo = _x;
    };
} forEach weaponsItems _unit;

private _return = [_unit, _item] call CBA_fnc_removeWeapon;

if (_return) then {
    if (!_skipAnim) then { _unit switchMove "ainvpknlmstpslaywrfldnon_1"; };

    private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

    if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
        _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
        _weaponHolder setPosASL getPosASL _unit;
    };

    _weaponHolder addWeaponWithAttachmentsCargoGlobal [_weaponInfo, 1];
};

_return
