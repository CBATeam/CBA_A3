/* ----------------------------------------------------------------------------
Function: CBA_fnc_dropMagazine

Description:
    Drops a magazine.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success.

Parameters:
    _unit - the unit that should drop a magazine <OBJECT>
    _item - class name of the magazine to drop <STRING>
    _ammo - ammo count (optional). If not specified a random magazine is chosen <NUMBER>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "SmokeShell"] call CBA_fnc_dropMagazine
    (end)

Author:
    ?, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(dropMagazine);

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_ammo", -1, [0]]];

// random mag mode
if (_ammo < 0) then {
    #ifndef LINUX_BUILD
        _ammo = ((magazinesAmmoFull _unit select {_x select 0 == _item && {toLower (_x select 4) in ["uniform","vest","backpack"]}}) call BIS_fnc_selectRandom) param [1, "null"];
    #else
        _ammo = (([magazinesAmmoFull _unit, {_x select 0 == _item && {toLower (_x select 4) in ["uniform","vest","backpack"]}}] call BIS_fnc_conditionalSelect) call BIS_fnc_selectRandom) param [1, "null"];
    #endif
};

// no mag of this type in units inventory
if (_ammo isEqualTo "null") exitWith {
    TRACE_2("Item not available on Unit",_unit,_item);
    false
};

private _return = [_unit, _item, _ammo] call CBA_fnc_removeMagazine;

if (_return) then {
    _unit switchMove "ainvpknlmstpslaywrfldnon_1";

    private _weaponHolder = nearestObject [_unit, "WeaponHolder"];

    if (isNull _weaponHolder || {_unit distance _weaponHolder > 2}) then {
        _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
        _weaponHolder setPosASL getPosASL _unit;
    };

    _weaponHolder addMagazineAmmoCargo [_item, 1, _ammo];
};

_return
