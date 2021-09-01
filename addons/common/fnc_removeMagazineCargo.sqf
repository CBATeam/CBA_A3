#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMagazineCargo

Description:
    Removes specific magazine(s) from cargo space.

Parameters:
    _container - Object with cargo <OBJECT>
    _item      - Classname of magazine(s) to remove <STRING>
    _count     - Number of magazine(s) to remove <NUMBER> (Default: 1)
    _ammo      - Ammo of magazine(s) to remove (-1 for magazine(s) with any ammo) <NUMBER> (Default: -1)

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
    // Remove 1 Smokegrenade from a box
    _success = [myCoolMagazineBox, "SmokeShell"] call CBA_fnc_removeMagazineCargo;

    // Remove 2 Handgrenades from a box
    _success = [myCoolMagazineBox, "HandGrenade_West", 2] call CBA_fnc_removeMagazineCargo;

    // Remove 2 magazines which each have 5 bullets in them from a box
    _success = [myCoolMagazineBox, "30Rnd_65x39_caseless_mag", 2, 5] call CBA_fnc_removeMagazineCargo;
    (end)

Author:
    silencer.helling3r 2012-12-22, Jonpas
---------------------------------------------------------------------------- */
SCRIPT(removeMagazineCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]], ["_ammo", -1, [0]]];

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    false
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_container,_item);
    false
};

private _config = configFile >> "CfgMagazines" >> _item;

if (isNull _config || {getNumber (_config >> "scope") < 2}) exitWith {
    TRACE_2("Item does not exist in Config",_container,_item);
    false
};

if (_count <= 0) exitWith {
    TRACE_3("Count is not a positive number",_container,_item,_count);
    false
};

// Ensure proper count
_count = round _count;

// [[type1, ammo1], [type2, ammo2], ...]
private _magazinesAmmo = magazinesAmmoCargo _container;

// Clear cargo space and readd the items as long it's not the type in question
clearMagazineCargoGlobal _container;

// Engine will agressively cleanup "empty" ground containers, even if magazines are re-added in same frame, so re-create a new container
private _containerType = typeOf _container;
if (((toLower _containerType) in ["groundweaponholder", "weaponholdersimulated"]) 
    && {(weaponCargo _container) isEqualTo []}
    && {(itemCargo _container) isEqualTo []}
    && {(backpackCargo _container) isEqualTo []}) then {
    _container = createVehicle [_containerType, getPosATL _container, [], 0, "CAN_COLLIDE"];
};

{
    _x params ["_magazineClass", "_magazineAmmo"];

    if (_count != 0 && {_magazineClass == _item} && {_ammo < 0 || {_magazineAmmo == _ammo}}) then {
        // Process removal
        _count = _count - 1;
    } else {
        // Readd
        _container addMagazineAmmoCargo [_magazineClass, 1, _magazineAmmo];
    };
} forEach _magazinesAmmo;

(_count == 0)
