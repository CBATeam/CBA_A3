/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBackpackCargo

Description:
    Removes specific backpack(s) from cargo space.

    Warning: All weapon attachments/magazines in all backpacks in container will become detached.

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

{
    _x params ["_backpackClass", "_itemCargo", "_magazinesAmmoCargo", "_weaponsItemsCargo"];

    if (_count != 0 && {_backpackClass == _item}) then {
        // Process removal
        _count = _count - 1;
    } else {
        // Save all backpacks for finding the one we readd after this
        private _addedBackpacks = everyBackpack _container;

        // Readd
        private _backpack = [_backpackClass, "CfgVehicles"] call CBA_fnc_getNonPresetClass;
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
        } forEach _magazinesAmmoCargo;

        // Weapons (and their attachments)
        // Put attachments next to weapon, no command to put it directly onto a weapon when weapon is in a container
        {
            _x params ["_weapon", "_muzzle", "_pointer", "_optic", "_magazine", "_magazineGL", "_bipod"];
            // weaponsItems magazineGL does not exist if not loaded (not even as empty array)
            if (count _x < 7) then {
                _bipod = _magazineGL;
                _magazineGL = "";
            };

            private _weapon = [_weapon] call CBA_fnc_getNonPresetClass;
            _backpack addWeaponCargoGlobal [_weapon, 1];

            _backpack addItemCargoGlobal [_muzzle, 1];
            _backpack addItemCargoGlobal [_pointer, 1];
            _backpack addItemCargoGlobal [_optic, 1];
            _backpack addItemCargoGlobal [_bipod, 1];

            _magazine params ["_magazineClass", "_magazineAmmoCount"];
            _backpack addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];

            _magazineGL params ["_magazineGLClass", "_magazineGLAmmoCount"];
            _backpack addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];
        } forEach _weaponsItemsCargo;
    };
} forEach _backpackData;

(_count == 0)
