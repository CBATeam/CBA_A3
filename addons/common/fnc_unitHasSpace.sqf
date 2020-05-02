#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_unitHasSpace

Description:
    Checks if unit has enough free space in inventory to store item.

    Doesn't take current unit load into account unlike canAdd command.

Parameters:
    _unit          - Unit <OBJECT>
    _item          - Item to store <STRING>
    _count         - Item count <NUMBER> (Default: 1)
    _checkUniform  - Check space in uniform <BOOLEAN> (Default: true)
    _checkVest     - Check space in vest <BOOLEAN> (Default: true)
    _checkBackpack - Check space in backpack <BOOLEAN> (Default: true)

Returns:
    True if unit has free space, false otherwise <BOOLEAN>

Examples:
    (begin example)
        [player, "acc_flashlight"] call CBA_fnc_unitHasSpace
        [player, "30Rnd_556x45_Stanag", 7, false, true, false] call CBA_fnc_unitHasSpace
    (end)

Author:
    Dystopian
---------------------------------------------------------------------------- */
SCRIPT(unitHasSpace);

params [
    "_unit",
    "_item",
    ["_count", 1],
    ["_checkUniform", true],
    ["_checkVest", true],
    ["_checkBackpack", true]
];

#define TYPE_VEST 701
#define TYPE_UNIFORM 801
#define TYPE_BACKPACK 901

if (isNil QGVAR(itemMassAllowedSlots)) then {
    LOG("create ns");
    GVAR(itemMassAllowedSlots) = [] call CBA_fnc_createNamespace;
};

(GVAR(itemMassAllowedSlots) getVariable [_item, []]) params ["_mass", "_allowedSlots"];

if (isNil "_mass") then {
    _allowedSlots = [TYPE_UNIFORM, TYPE_VEST, TYPE_BACKPACK];
    private _cfgWeaponsItem = configFile >> "CfgWeapons" >> _item;
    if (isClass _cfgWeaponsItem) then {
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
    } else {
        private _cfgMagazinesItem = configFile >> "CfgMagazines" >> _item;
        if (isClass _cfgMagazinesItem) then {
            _mass = getNumber (_cfgMagazinesItem >> "mass");
            private _cfgAllowedSlots = _cfgMagazinesItem >> "allowedSlots";
            if (isArray _cfgAllowedSlots) then {
                _allowedSlots = getArray _cfgAllowedSlots;
            };
        } else {
            private _cfgGlassesItem = configFile >> "CfgGlasses" >> _item;
            if (isClass _cfgGlassesItem) then {
                _mass = getNumber (_cfgGlassesItem >> "mass");
            } else {
                _mass = -1;
                _allowedSlots = [];
            };
        };
    };
    TRACE_3("caching",_item,_mass,_allowedSlots);
    GVAR(itemMassAllowedSlots) setVariable [_item, [_mass, _allowedSlots]];
};

if (_mass == -1) exitWith {false}; // item doesn't exist

if (
    _checkUniform
    && {
        private _maxLoad = getContainerMaxLoad uniform _unit;
        _maxLoad >= _mass * _count + _maxLoad * loadUniform _unit
    }
    && {TYPE_UNIFORM in _allowedSlots}
) exitWith {true};

if (
    _checkVest
    && {
        private _maxLoad = getContainerMaxLoad vest _unit;
        _maxLoad >= _mass * _count + _maxLoad * loadVest _unit
    }
    && {TYPE_VEST in _allowedSlots}
) exitWith {true};

if (
    _checkBackpack
    && {
        private _maxLoad = getContainerMaxLoad backpack _unit;
        _maxLoad >= _mass * _count + _maxLoad * loadBackpack _unit
    }
    && {TYPE_BACKPACK in _allowedSlots}
) exitWith {true};

false
