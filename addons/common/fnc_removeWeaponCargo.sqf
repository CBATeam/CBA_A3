/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeaponCargo

Description:
    Removes specific weapon(s) from cargo space.

    Warning: All weapon attachments/magazines in container will become detached.

Parameters:
    _container - Object with cargo <OBJECT>
    _item      - Classname of weapon(s) to remove <STRING>
    _count     - Number of weapon(s) to remove <NUMBER> (Default: 1)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 Binocular from a box
    _success = [myCoolWeaponBox, "Binocular"] call CBA_fnc_removeWeaponCargo;

    // Remove 2 M16A2 from a box
    _success = [myCoolWeaponBox, "M16A2", 2] call CBA_fnc_removeWeaponCargo;
    (end)

Author:
    silencer.helling3r 2012-12-22, Jonpas
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeWeaponCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]]];

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    false
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    false
};

private _config = configFile >> "CfgWeapons" >> _item;

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

// Returns array in weaponsItems format
private _weaponsItemsCargo = weaponsItemsCargo _container;

// Clear cargo space and readd the items as long it's not the type in question
clearWeaponCargoGlobal _container;

{
    _x params ["_weapon", "_muzzle", "_pointer", "_optic", "_magazine", "_magazineGL", "_bipod"];
    // weaponsItems magazineGL does not exist if not loaded (not even as empty array)
    if (count _x < 7) then {
        _bipod = _magazineGL;
        _magazineGL = "";
    };

    if (_count != 0 && {_weapon == _item}) then {
        // Process removal
        _count = _count - 1;
    } else {
        _weapon = [_weapon] call CBA_fnc_getNonPresetClass;
        _container addWeaponCargoGlobal [_weapon, 1];

        _container addItemCargoGlobal [_muzzle, 1];
        _container addItemCargoGlobal [_pointer, 1];
        _container addItemCargoGlobal [_optic, 1];
        _container addItemCargoGlobal [_bipod, 1];

        _magazine params [["_magazineClass", ""], ["_magazineAmmoCount", ""]];
        _container addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];

        _magazineGL params [["_magazineGLClass", ""], ["_magazineGLAmmoCount", ""]];
        _container addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];
    };
} forEach _weaponsItemsCargo;

(_count == 0)
