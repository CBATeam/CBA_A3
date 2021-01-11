#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_consumeItem

Description:
    Removes item from inventory.

Parameters:
    _unit      - Unit that consumeds item <OBJECT>
    _item      - Item classname <STRING>
    _slot      - Inventory slot of the item <STRING>
    _container - Container that has the item <OBJECT>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        [player, headgear player, "HEADGEAR"] call CBA_fnc_consumeItem;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

// Force unscheduled environment to prevent race conditions.
if (canSuspend) exitWith {
    [CBA_fnc_consumeItem, _this] call CBA_fnc_directCall;
};

params [
    ["_unit", objNull, [objNull]],
    ["_item", "", [""]],
    ["_slot", "", [""]],
    ["_container", objNull, [objNull]]
];

private _return = false;

if (!local _unit || _item isEqualTo "") exitWith {_return};

// Convert to config case.
_item = configName (_item call CBA_fnc_getItemConfig);

switch _slot do {
    // containers
    case "GROUND";
    case "CARGO": {
        // fail
    };
    case "UNIFORM_CONTAINER": {
        if (_item in uniformItems _unit) then {
            _unit removeItemFromUniform _item;
            _return = true;
        };
    };
    case "VEST_CONTAINER": {
        if (_item in vestItems _unit) then {
            _unit removeItemFromVest _item;
            _return = true;
        };
    };
    case "BACKPACK_CONTAINER": {
        if (_item in backpackItems _unit) then {
            _unit removeItemFromBackpack _item;
            _return = true;
        };
    };

    // clothes
    case "UNIFORM": {
        if (_item == uniform _unit) then {
            removeUniform _unit;
            _return = true;
        };
    };
    case "VEST": {
        if (_item == vest _unit) then {
            removeVest _unit;
            _return = true;
        };
    };
    case "BACKPACK": {
        if (_item == backpack _unit) then {
            removeBackpack _unit;
            _return = true;
        };
    };

    // gear
    case "HEADGEAR": {
        if (_item == headgear _unit) then {
            removeHeadgear _unit;
            _return = true;
        };
    };
    case "GOGGLES": {
        if (_item == goggles _unit) then {
            removeGoggles _unit;
            _return = true;
        };
    };
    case "HMD": {
        if (_item == hmd _unit) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
    case "BINOCULAR": {
        if (_item == binocular _unit) then {
            _unit removeWeapon _item;
            _return = true;
        };
    };

    // rifle
    case "RIFLE": {
        if (_item == primaryWeapon _unit) then {
            _unit removeWeapon _item;
            _return = true;
        };
    };
    case "RIFLE_SILENCER": {
        if (_item == primaryWeaponItems _unit select 0) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };
    case "RIFLE_BIPOD": {
        if (_item == primaryWeaponItems _unit select 3) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };
    case "RIFLE_OPTIC": {
        if (_item == primaryWeaponItems _unit select 2) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };
    case "RIFLE_POINTER": {
        if (_item == primaryWeaponItems _unit select 1) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };
    case "RIFLE_MAGAZINE": {
        if (_item == getUnitLoadout _unit param [0, ["","","","",[],[],""]] select 4 param [0, ""]) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };
    case "RIFLE_MAGAZINE_GL": {
        if (_item == getUnitLoadout _unit param [0, ["","","","",[],[],""]] select 5 param [0, ""]) then {
            _unit removePrimaryWeaponItem _item;
            _return = true;
        };
    };

    // launcher
    case "LAUNCHER": {
        if (_item == secondaryWeapon _unit) then {
            _unit removeWeapon _item;
            _return = true;
        };
    };
    case "LAUNCHER_SILENCER": {
        if (_item == secondaryWeaponItems _unit select 0) then {
            _unit removeSecondaryWeaponItem _item;
            _return = true;
        };
    };
    case "LAUNCHER_BIPOD": {
        if (_item == secondaryWeaponItems _unit select 3) then {
            _unit removeSecondaryWeaponItem _item;
            _return = true;
        };
    };
    case "LAUNCHER_OPTIC": {
        if (_item == secondaryWeaponItems _unit select 2) then {
            _unit removeSecondaryWeaponItem _item;
            _return = true;
        };
    };
    case "LAUNCHER_POINTER": {
        if (_item == secondaryWeaponItems _unit select 1) then {
            _unit removeSecondaryWeaponItem _item;
            _return = true;
        };
    };
    case "LAUNCHER_MAGAZINE": {
        if (_item == secondaryWeaponMagazine _unit select 0) then {
            _unit removeSecondaryWeaponItem _item;
            _return = true;
        };
    };

    // pistol
    case "PISTOL": {
        if (_item == handgunWeapon _unit) then {
            _unit removeWeapon _item;
            _return = true;
        };
    };
    case "PISTOL_SILENCER": {
        if (_item == handgunItems _unit select 0) then {
            _unit removeHandgunItem _item;
            _return = true;
        };
    };
    case "PISTOL_BIPOD": {
        if (_item == handgunItems _unit select 3) then {
            _unit removeHandgunItem _item;
            _return = true;
        };
    };
    case "PISTOL_OPTIC": {
        if (_item == handgunItems _unit select 2) then {
            _unit removeHandgunItem _item;
            _return = true;
        };
    };
    case "PISTOL_POINTER": {
        if (_item == handgunItems _unit select 1) then {
            _unit removeHandgunItem _item;
            _return = true;
        };
    };
    case "PISTOL_MAGAZINE": {
        if (_item == handgunMagazine _unit select 0) then {
            _unit removeHandgunItem _item;
            _return = true;
        };
    };

    // items
    case "MAP": {
        if (_item == getUnitLoadout _unit param [9, ["","","","","",""]] select 0) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
    case "GPS": {
        if (_item == getUnitLoadout _unit param [9, ["","","","","",""]] select 1) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
    case "RADIO": {
        if (_item == getUnitLoadout _unit param [9, ["","","","","",""]] select 2) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
    case "COMPASS": {
        if (_item == getUnitLoadout _unit param [9, ["","","","","",""]] select 3) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
    case "WATCH": {
        if (_item == getUnitLoadout _unit param [9, ["","","","","",""]] select 4) then {
            _unit unlinkItem _item;
            _return = true;
        };
    };
};

_return
