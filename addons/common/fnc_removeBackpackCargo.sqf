/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBackpackCargo

Description:
    Removes specific backpack(s) from cargo space.

    Warning: All weapon attachments/magazines in all backpacks in the box will become detached.

Parameters:
    _container - Object with cargo <OBJECT>
    _item      - Classname of backpack(s) to remove <STRING>
    _count     - Number of backpack(s) to remove <NUMBER> (Default: 1)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 Kitbag Tan backpack from a box
    _success = [myCoolBackpackBox, "B_Kitbag_cbr"] call CBA_fnc_removeBackpackCargo;

    // Remove 2 Carryall Desert Camo backpacks from a box
    _success = [myCoolBackpackBox, "B_Carryall_ocamo", 2] call CBA_fnc_removeBackpackCargo;
    (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeBackpackCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]]];

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    false
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    false
};

private _config = _item call CBA_fnc_getObjectConfig;

if (isNull _config || {getNumber (_config >> "scope") < 1} || {getNumber (_config >> "isBackpack") != 1}) exitWith {
    TRACE_2("Item not exist in Config",_container,_item);
    false
};

if (_count <= 0) exitWith {
    TRACE_3("Count is not a positive number",_container,_item,_count);
    false
};

// Ensure proper count
_count = round _count;

// Save backpacks and contents
private _backpackData = [];
{
    _backpackData pushBack [typeOf _x, getItemCargo _x, magazinesAmmoCargo _x, weaponsItemsCargo _x];
} forEach (everyBackpack _container); // [object1, object2, ...]

// Clear cargo space and readd the items as long it's not the type in question
clearBackpackCargoGlobal _container;

private _removed = 0;
{
    _x params ["_backpackClass", "_itemCargo", "_magazinesAmmoCargo", "_weaponsItemsCargo"];

    if (_removed != _count && {_backpackClass == _item}) then {
        // Process removal
        _removed = _removed + 1;
    } else {
        // Save all backpacks for finding the one we readd after this
        private _addedBackpacks = everyBackpack _container;

        // Readd
        private _backpack = [_backpackClass, "CfgVehicles"] call CBA_fnc_getNoLinkedItemsClass;
        _container addBackpackCargoGlobal [_backpack, 1];

        // Find just added backpack and add contents (no command returns reference when adding)
        private _backpack = (everyBackpack _container - _addedBackpacks) select 0;

        // Items
        {
            private _itemCount = (_itemCargo select 1) select _forEachIndex;
            _backpack addItemCargoGlobal [_x, _itemCount];
        } forEach (_itemCargo select 0);

        // Magazines (and their ammo count)
        {
            _backpack addMagazineAmmoCargo [_x select 0, 1, _x select 1];
            diag_log format ["adding mag: %1", _x];
        } forEach _magazinesAmmoCargo;

        // Weapons (and their attachments)
        // Put attachments next to weapon, no command to put it directly onto a weapon when weapon is in a container
        {
            private _weapon = [_x select 0] call CBA_fnc_getNoLinkedItemsClass;
            _backpack addWeaponCargoGlobal [_weapon, 1]; // Weapon

            _backpack addItemCargoGlobal [_x select 1, 1]; // Muzzle
            _backpack addItemCargoGlobal [_x select 2, 1]; // Pointer
            _backpack addItemCargoGlobal [_x select 3, 1]; // Optic

            // Magazine
            (_x select 4) params ["_magazineClass", "_magazineAmmoCount"];
            _backpack addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];

            if (count _x > 6) then {
                // Magazine GL
                (_x select 5) params ["_magazineGLClass", "_magazineGLAmmoCount"];
                _backpack addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];

                _backpack addItemCargoGlobal [_x select 6, 1]; // Bipod
            } else {
                _backpack addItemCargoGlobal [_x select 5, 1]; // Bipod
            };
        } forEach _weaponsItemsCargo;
    };
} forEach _backpackData;

(_removed == _count)
