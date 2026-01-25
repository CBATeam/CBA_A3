#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_uniqueUnitItems

Description:
    Retrieves a unique list of items in the units inventory.

Parameters:
    _unit           - Unit to retrieve the items from
    _weaponItems    - Include weapons, attachments, loaded magazines (Default: false)
    _backpack       - Include items in backpack    (Default: true)
    _vest           - Include items in vest        (Default: true)
    _uniform        - Include items in uniform     (Default: true)
    _assignedItems  - Include assigned items       (Default: true)
    _magazines      - Include not loaded magazines (Default: false)

Example:
    (begin example)
        _allItems = [player, true, false] call CBA_fnc_uniqueUnitItems
    (end)

Returns:
    Array of item classnames <ARRAY>

Author:
    Dedmen, commy2
---------------------------------------------------------------------------- */

params [
    ["_unit", objNull, [objNull]],
    ["_weaponItems", false, [false]],
    ["_backpack", true, [false]],
    ["_vest", true, [false]],
    ["_uniform", true, [false]],
    ["_assignedItems", true, [false]],
    ["_magazines", false, [false]]
];

private _allItems = if (_assignedItems) then {assignedItems _unit} else {[]};

if (_uniform) then {
    _allItems append (getItemCargo uniformContainer _unit select 0);
};

if (_vest) then {
    _allItems append (getItemCargo vestContainer _unit select 0);
};

if (_backpack) then {
    _allItems append (getItemCargo backpackContainer _unit select 0);
};

if (_weaponItems) then {
    _allItems append [
        primaryWeapon _unit,
        secondaryWeapon _unit,
        handgunWeapon _unit // binocular covered by assignedItems
    ];

    _allItems append primaryWeaponItems _unit;
    _allItems append secondaryWeaponItems _unit;
    _allItems append handgunItems _unit;

    if (_magazines) then {
        _allItems append primaryWeaponMagazine _unit;
        _allItems append secondaryWeaponMagazine _unit;
        _allItems append handgunMagazine _unit;
        _allItems pushBack (_unit call CBA_fnc_binocularMagazine);
    };

    _allItems = _allItems - [""];
};

if (_magazines) then {
    if (_uniform) then {
        _allItems append (getMagazineCargo uniformContainer _unit select 0);
    };

    if (_vest) then {
        _allItems append (getMagazineCargo vestContainer _unit select 0);
    };

    if (_backpack) then {
        _allItems append (getMagazineCargo backpackContainer _unit select 0);
    };
};

_allItems arrayIntersect _allItems //Remove duplicates
