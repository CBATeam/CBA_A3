#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeWeaponCargo

Description:
    Removes specific weapon(s) from cargo space.

    Warning: All weapon attachments/magazines in container will become detached.
    Warning: Preset weapons without non-preset parents will get their attachments re-added (engine limitation).

Parameters:
    _container       - Object with cargo <OBJECT>
    _item            - Classname of weapon(s) to remove <STRING>
    _count           - Number of weapon(s) to remove <NUMBER> (Default: 1)
    _keepAttachments - Keep attachments/magazines of the removed weapon <BOOLEAN> (Default: false)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 Binocular from a box
    _success = [myCoolWeaponBox, "Binocular"] call CBA_fnc_removeWeaponCargo;

    // Remove 2 M16A2 from a box
    _success = [myCoolWeaponBox, "M16A2", 2] call CBA_fnc_removeWeaponCargo;

    // Remove 1 MX (with ACO and IR pointer) from a box and keep attachments
    _success = [myCoolWeaponBox, "arifle_MX_ACO_pointer_F", 1, true] call CBA_fnc_removeWeaponCargo;
    (end)

Author:
    silencer.helling3r 2012-12-22, Jonpas
---------------------------------------------------------------------------- */
SCRIPT(removeWeaponCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]], ["_keepAttachments", false, [true]]];

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

// Clear cargo space and re-add the items as long as it's not the type in question
clearWeaponCargoGlobal _container;

{
    _x params ["_weapon", "_muzzle", "_pointer", "_optic", "_magazine", "_magazineGL", "_bipod"];

    // weaponsItems magazineGL does not exist if not loaded (not even as empty array)
    if (count _x < 7) then {
        _bipod = _magazineGL;
        _magazineGL = [];
    };

    // Some weapons don't have non-preset parents
    private _weaponNonPreset = [_weapon] call CBA_fnc_getNonPresetClass;
    if (_weaponNonPreset == "") then {
        _weaponNonPreset = _weapon;
    };

    if (_count != 0 && {_weapon == _item || _weaponNonPreset == _item}) then {
        // Process removal
        _count = _count - 1;

        if (_keepAttachments) then {
            _container addItemCargoGlobal [_muzzle, 1];
            _container addItemCargoGlobal [_pointer, 1];
            _container addItemCargoGlobal [_optic, 1];
            _container addItemCargoGlobal [_bipod, 1];

            _magazine params [["_magazineClass", ""], ["_magazineAmmoCount", 0]];
            if (_magazineClass != "") then {
                _container addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmoCount];
            };

            _magazineGL params [["_magazineGLClass", ""], ["_magazineGLAmmoCount", 0]];
            if (_magazineGLClass != "") then {
                _container addMagazineAmmoCargo [_magazineGLClass, 1, _magazineGLAmmoCount];
            };
        };
    } else {
        _container addWeaponWithAttachmentsCargoGlobal [
            [
                _weaponNonPreset,
                _muzzle, _pointer, _optic,
                _magazine, _magazineGL,
                _bipod
            ], 1
        ];
    };
} forEach _weaponsItemsCargo;

(_count == 0)
