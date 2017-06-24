/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeItemCargo

Description:
    Removes specific item(s) from cargo space.

    Warning: All weapon attachments/magazines in containers in container will become detached.

Parameters:
    _container - Object with cargo <OBJECT>
    _item      - Classname of item(s) to remove <STRING>
    _count     - Number of item(s) to remove <NUMBER> (Default: 1)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 GPS from a box
    _success = [myCoolItemBox, "ItemGPS"] call CBA_fnc_removeItemCargo;

    // Remove 2 Compasses from a box
    _success = [myCoolItemBox, "ItemCompass", 2] call CBA_fnc_removeItemCargo;
    (end)

Author:
    Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeItemCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]]];

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    false
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    false
};

private _config = _item call CBA_fnc_getItemConfig;

if (isNull _config || {getNumber (_config >> "scope") < 1}) exitWith {
    TRACE_2("Item does not exist in Config",_container,_item);
    false
};

if (_count <= 0) exitWith {
    TRACE_3("Count is not a positive number",_container,_item,_count);
    false
};

// Ensure proper count
_count = round _count;

// Save containers and contents
private _containerData = []; // [object1, object2, ...]
private _containerNames = [];
{
    _x params ["_class", "_object"];
    if !(_object in (everyBackpack _container)) then {
        _containerData pushBack [getItemCargo _object, magazinesAmmoCargo _object, weaponsItemsCargo _object];
        _containerNames pushBack _class;
    };
} forEach (everyContainer _container); // [["class1", object1], ["class2", object2]]

// [[type1, typeN, ...], [count1, countN, ...]]
(getItemCargo _container) params ["_allItemsType", "_allItemsCount"];

// Clear cargo space and readd the items as long it's not the type in question
clearItemCargoGlobal _container;

{
    private _itemCount = _allItemsCount select _forEachIndex;
    private _containerIndex = _containerNames find _x;

    if (_count != 0 && {_x == _item}) then {
        // Process removal
        if (_containerIndex < 0) then {
            _itemCount = _itemCount - _count;
            if (_itemCount > 0) then {
                // Add with new count
                _container addItemCargoGlobal [_x, _itemCount];
            };
        } else {
            _containerData deleteAt _containerIndex;
            _containerNames deleteAt _containerIndex;
        };
        _count = 0;
    } else {
        // Readd only
        if (_containerIndex < 0) then {
            _container addItemCargoGlobal [_x, _itemCount];
        } else {
            (_containerData select _containerIndex) params ["_itemCargo", "_magazinesAmmoCargo", "_weaponsItemsCargo"];

            // Save all containers for finding the one we readd after this
            private _addedContainers = ((everyContainer _container) apply {_x select 1}) - everyBackpack _container;

            // Readd
            private _addedContainer = [_containerNames select _containerIndex] call CBA_fnc_getNonPresetClass;
            _container addItemCargoGlobal [_addedContainer, 1];

            // Find just added container and add contents (no command returns reference when adding)
            private _addedContainer = ((((everyContainer _container) apply {_x select 1}) - everyBackpack _container) - _addedContainers) select 0;

            // Items
            {
                private _itemCount = (_itemCargo select 1) select _forEachIndex;
                _addedContainer addItemCargoGlobal [_x, _itemCount];
            } forEach (_itemCargo select 0);

            // Magazines (and their ammo count)
            {
                _addedContainer addMagazineAmmoCargo [_x select 0, 1, _x select 1];
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
                _addedContainer addWeaponCargoGlobal [_weapon, 1];

                _addedContainer addItemCargoGlobal [_muzzle, 1];
                _addedContainer addItemCargoGlobal [_pointer, 1];
                _addedContainer addItemCargoGlobal [_optic, 1];
                _addedContainer addItemCargoGlobal [_bipod, 1];

                _magazine params [["_magazineClass", ""], ["_magazineAmmoCount", ""]];
                _addedContainer addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];

                _magazineGL params [["_magazineGLClass", ""], ["_magazineGLAmmoCount", ""]];
                _addedContainer addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];
            } forEach _weaponsItemsCargo;
        };
    };
} forEach _allItemsType;

(_count == 0)
