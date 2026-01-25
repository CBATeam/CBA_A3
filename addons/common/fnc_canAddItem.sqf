#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_canAddItem

Description:
    Checks if unit or object has enough free space in inventory to store item.

    Doesn't take current unit load into account unlike canAdd command.

Parameters:
    _unit          - Unit <OBJECT>
    _item          - Item to store <STRING>
    _count         - Item count <NUMBER> (Default: 1)
    _checkUniform  - Check space in uniform <BOOLEAN> (Default: true)
    _checkVest     - Check space in vest <BOOLEAN> (Default: true)
    _checkBackpack - Check space in backpack <BOOLEAN> (Default: true)

Returns:
    True if unit or object has free space, false otherwise <BOOLEAN>

Examples:
    (begin example)
        [player, "acc_flashlight"] call CBA_fnc_canAddItem
        [player, "30Rnd_556x45_Stanag", 7, false, true, false] call CBA_fnc_canAddItem
    (end)

Author:
    Dystopian
---------------------------------------------------------------------------- */
SCRIPT(canAddItem);

params [
    ["_unit", objNull, [objNull]],
    ["_item", "", [""]],
    ["_count", 1, [0]],
    ["_checkUniform", true, [false]],
    ["_checkVest", true, [false]],
    ["_checkBackpack", true, [false]]
];

if (isNull _unit || {_item isEqualTo ""}) exitWith {false};

#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_BACKPACK 901

if (isNil QGVAR(itemMassAllowedSlots)) then {
    GVAR(itemMassAllowedSlots) = createHashMap;
};

(GVAR(itemMassAllowedSlots) getOrDefault [_item, []]) params ["_mass", "_allowedSlots"];

if (isNil "_mass") then {
    _allowedSlots = [TYPE_UNIFORM, TYPE_VEST, TYPE_BACKPACK];
    private _cfgWeaponsItem = configFile >> "CfgWeapons" >> _item;
    private _cfgMagazinesItem = configFile >> "CfgMagazines" >> _item;
    private _cfgGlassesItem = configFile >> "CfgGlasses" >> _item;
    switch true do {
        case (isClass _cfgWeaponsItem): {
            private _cfgItemInfo = _cfgWeaponsItem >> "ItemInfo";
            private _cfgWeaponSlotsInfo = _cfgWeaponsItem >> "WeaponSlotsInfo";
            if (isNumber (_cfgItemInfo >> "mass")) then {
                _mass = getNumber (_cfgItemInfo >> "mass");
            } else {
                _mass = getNumber (_cfgWeaponSlotsInfo >> "mass");
            };

            {
                if (isArray _x) exitWith {
                    _allowedSlots = getArray _x;
                };
            } forEach [
                _cfgWeaponsItem >> "allowedSlots",
                _cfgItemInfo >> "allowedSlots",
                _cfgWeaponSlotsInfo >> "allowedSlots"
            ];
        };
        case (isClass _cfgMagazinesItem): {
            _mass = getNumber (_cfgMagazinesItem >> "mass");
            private _cfgAllowedSlots = _cfgMagazinesItem >> "allowedSlots";
            if (isArray _cfgAllowedSlots) then {
                _allowedSlots = getArray _cfgAllowedSlots;
            };
        };
        case (isClass _cfgGlassesItem): {
            _mass = getNumber (_cfgGlassesItem >> "mass");
        };
        default {
            _mass = -1;
            _allowedSlots = [];
        };
    };
    TRACE_3("caching",_item,_mass,_allowedSlots);
    GVAR(itemMassAllowedSlots) set [_item, [_mass, _allowedSlots]];
};

if (_mass == -1) exitWith {false}; // item doesn't exist

if (_unit isKindOf "CAManBase") then {
    // is a person
    if (
        _checkUniform
        && {TYPE_UNIFORM in _allowedSlots}
        && {
            private _maxLoad = maxLoad uniformContainer _unit;
            if (_maxLoad == 0) exitWith { false };
            _mass == 0
            || {
                // each time subtract whole number of items which can be put in container
                _count = _count - floor (_maxLoad * (1 - loadUniform _unit) / _mass);
                _count <= 0
            }
        }
    ) exitWith {true};

    if (
        _checkVest
        && {TYPE_VEST in _allowedSlots}
        && {
            private _maxLoad = maxLoad vestContainer _unit;
            if (_maxLoad == 0) exitWith { false };
            _mass == 0
            || {
                _count = _count - floor (_maxLoad * (1 - loadVest _unit) / _mass);
                _count <= 0
            }
        }
    ) exitWith {true};

    if (
        _checkBackpack
        && {TYPE_BACKPACK in _allowedSlots}
        && {
            private _maxLoad = maxLoad backpackContainer _unit;
            if (_maxLoad == 0) exitWith { false };
            _mass == 0
            || {
                _count = _count - floor (_maxLoad * (1 - loadBackpack _unit) / _mass);
                _count <= 0
            }
        }
    ) exitWith {true};

    false
} else {
    // is a vehicle, crate etc.
    private _maxLoad = maxLoad _unit;
    if (_maxLoad == 0) exitWith { false };
    _mass == 0
    || {
        _count = _count - floor (_maxLoad * (1 - load _unit) / _mass);
        _count <= 0
    }
};
