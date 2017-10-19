/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeBackpackCargo

Description:
    Removes specific backpack(s) from cargo space.

    Warning: All weapon attachments/magazines in all backpacks in container will become detached.
    Warning: Preset weapons without non-preset parents will get their attachments readded (engine limitation).

Parameters:
    _container    - Object with cargo <OBJECT>
    _item         - Classname of backpack(s) to remove <STRING>
    _count        - Number of backpack(s) to remove <NUMBER> (Default: 1)
    _keepContents - Keep contents of the removed backpack <BOOLEAN> (Default: false)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 Kitbag Tan backpack from a box
    _success = [myCoolBackpackBox, "B_Kitbag_cbr"] call CBA_fnc_removeBackpackCargo;

    // Remove 2 Carryall Desert Camo backpacks from a box
    _success = [myCoolBackpackBox, "B_Carryall_ocamo", 2] call CBA_fnc_removeBackpackCargo;

    // Remove 1 Backpack from a box and keep contents
    _success = [myCoolWeaponBox, "B_AssaultPack_khk", 1, true] call CBA_fnc_removeBackpackCargo;
    (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeBackpackCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]], ["_keepContents", false, [true]]];

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

// Add contents to backpack or box helper function
private _fnc_addContents = {
    params ["_container", "_itemCargo", "_magazinesAmmoCargo", "_weaponsItemsCargo"];

    // Items
    {
        private _itemCount = (_itemCargo select 1) select _forEachIndex;
        _container addItemCargoGlobal [_x, _itemCount];
    } forEach (_itemCargo select 0);

    // Magazines (and their ammo count)
    {
        _container addMagazineAmmoCargo [_x select 0, 1, _x select 1];
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

        // Some weapons don't have non-preset parents
        private _weaponNonPreset = [_weapon] call CBA_fnc_getNonPresetClass;
        if (_weaponNonPreset == "") then {
            _weaponNonPreset = _weapon;
        };

        _container addWeaponCargoGlobal [_weaponNonPreset, 1];

        // If weapon does not have a non-preset parent, only add attachments that were custom added
        // Removed attachments cannot be handled (engine limitation) and will be readded due to having to readd preset weapon
        private _presetAttachments = [];
        if (_weaponNonPreset == _weapon) then {
            _presetAttachments = _weapon call CBA_fnc_weaponComponents;
        };
        if !(toLower _muzzle in _presetAttachments) then {
            _container addItemCargoGlobal [_muzzle, 1];
        };
        if !(toLower _pointer in _presetAttachments) then {
            _container addItemCargoGlobal [_pointer, 1];
        };
        if !(toLower _optic in _presetAttachments) then {
            _container addItemCargoGlobal [_optic, 1];
        };
        if !(toLower _bipod in _presetAttachments) then {
            _container addItemCargoGlobal [_bipod, 1];
        };

        _magazine params [["_magazineClass", ""], ["_magazineAmmoCount", 0]];
        if (_magazineClass != "") then {
            _container addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];
        };

        _magazineGL params [["_magazineGLClass", ""], ["_magazineGLAmmoCount", 0]];
        if (_magazineGLClass != "") then {
            _container addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];
        };
    } forEach _weaponsItemsCargo;
};

// Process all backpacks
{
    _x params ["_backpackClass", "_itemCargo", "_magazinesAmmoCargo", "_weaponsItemsCargo"];

    if (_count != 0 && {_backpackClass == _item}) then {
        // Process removal
        _count = _count - 1;

        if (_keepContents) then {
            [_container, _itemCargo, _magazinesAmmoCargo, _weaponsItemsCargo] call _fnc_addContents;
        };
    } else {
        // Save all backpacks for finding the one we readd after this
        private _addedBackpacks = everyBackpack _container;

        // Readd
        private _backpack = [_backpackClass, "CfgVehicles"] call CBA_fnc_getNonPresetClass;
        _container addBackpackCargoGlobal [_backpack, 1];

        // Find just added backpack and add contents (no command returns reference when adding)
        private _backpack = (everyBackpack _container - _addedBackpacks) select 0;

        [_backpack, _itemCargo, _magazinesAmmoCargo, _weaponsItemsCargo] call _fnc_addContents;
    };
} forEach _backpackData;

(_count == 0)
