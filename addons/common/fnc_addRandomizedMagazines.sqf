#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_addRandomizedMagazines

Description:
    Adds the randomized magazines for the weapon(s) added from CBA_fnc_randomizeLoadout.

Parameters:
    _unit - unit <OBJECT>

Returns:
    true on success, false on error <BOOLEAN>

Examples:
    (begin example)
        _unit call CBA_fnc_addRandomizedMagazines;
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

#define INDEX_PRIMARY 0
#define INDEX_LAUNCHER 1
#define INDEX_HANDGUN 2

params [["_unit", objNull, [objNull]]];

if (isNull _unit) exitWith {
    WARNING_1("Unit [%1] is null",_unit);
    false
};

// Disabled conditions
if (!local _unit) exitWith {true};

private _cache = _unit call CBA_fnc_getRandomizedEquipment;

// Exit if unit has no randomization
if (!(_cache select 0)) exitWith { true };
(_unit call CBA_fnc_getLoadout) params ["_loadout", "_extendedInfo"];

{
    // Handle mission maker changing weapons of units
    private _weaponSlot = _loadout select _x;
    if (_weaponSlot isEqualTo []) then { continue };

    private _weaponClass = _weaponSlot select 0;
    private _weaponCache = (_cache select _x + 1);
    if (_weaponCache isEqualTo []) then { continue };

    private _weaponIndex = _weaponCache findIf { _x param [0, ""] isEqualTo _weaponClass};
    if (_weaponIndex == -1) then { continue };
    _weaponCache = _weaponCache select _weaponIndex;
    {
        _x params ["_magazine", "_count"];
        for "_" from 2 to _count do { // 2 since one magazine is added in Eden
            // Exit if magazine can't be added
            if !([_unit, _magazine] call CBA_fnc_addMagazine) exitWith {};
        };
    } forEach (_weaponCache select 1);
} forEach [INDEX_PRIMARY, INDEX_LAUNCHER, INDEX_HANDGUN];

true;
