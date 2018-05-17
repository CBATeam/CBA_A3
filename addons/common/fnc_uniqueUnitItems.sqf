/* ----------------------------------------------------------------------------
Function: CBA_fnc_uniqueUnitItems

Description:
    Retrievs a unique list of items in the units inventory.

Parameters:
    _unit           - Unit to retrieve the items from
    _weaponItems    - Include weapons, attachments, loaded magazines (Default: false)
    _backpack       - Include items in backpack (Default: true)
    _vest           - Include items in vest     (Default: true)
    _uniform        - Include items in uniform  (Default: true)
    _assignedItems  - Include assigned items    (Default: true)

Example:
    (begin example)
    _allItems = [player, true, false] call CBA_fnc_uniqueUnitItems
    (end)

Returns:
    Array of item classnames <ARRAY>

Author:
    Dedmen
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(uniqueUnitItems);

params [["_unit", objNull, [objNull]], ["_weaponItems", false, [true]], ["_backpack", true, [true]], ["_vest", true, [true]], ["_uniform", true, [true]], ["_assignedItems", true, [true]]];

private _allItems = if (_assignedItems) then {assignedItems _unit} else {[]};
if (_uniform) then {_allItems append ((getItemCargo (uniformContainer _unit)) select 0)};
if (_vest) then {_allItems append ((getItemCargo (vestContainer _unit)) select 0)};
if (_backpack) then {_allItems append ((getItemCargo (backpackContainer _unit)) select 0)};

if (_weaponItems) then {
    _allItems append (primaryWeaponItems _unit);
    _allItems append (secondaryWeaponItems _unit);
    _allItems append (handgunItems _unit);
    _allItems append (primaryWeaponMagazine _unit);
    _allItems append (secondaryWeaponMagazine _unit);
    _allItems append (handgunMagazine _unit);
    _allItems append [
        primaryWeapon _unit, secondaryWeapon _unit, handgunWeapon _unit
     ];
     _allItems pushBack (_unit call CBA_fnc_binocularMagazine);
};

_allItems arrayIntersect _allItems //Remove duplicates
