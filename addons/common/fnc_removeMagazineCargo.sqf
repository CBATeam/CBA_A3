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
    silencer.helling3r 2012-12-22, Jonpas, esteldunedain, johnb43 (from ACE)
---------------------------------------------------------------------------- */
SCRIPT(removeMagazineCargo);

params [["_container", objNull, [objNull]], ["_item", "", [""]], ["_count", 1, [0]], ["_ammo", -1, [0]]];

if (isNull _container) exitWith {
    TRACE_2("Container not Object or null",_container,_item);
    false
};

if (_container isKindOf "CAManBase") exitWith {
    TRACE_2("Container is unit",_container,_item);
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

// Make sure magazine is in config case
_item = configName _config;

// Ensure proper count
_count = round _count;
_ammo = round _ammo;

if (_ammo < 0) then {
    (getMagazineCargo _container) params ["_magazines", "_magazinesCount"];

    private _index = _magazines find _item;

    if (_index == -1) exitWith {};

    _container addMagazineCargoGlobal [_item, -_count];

    // Check the amount of mags that were present before removal
    (_magazinesCount select _index) >= _count // return
} else {
    // [[type1, ammo1], [type2, ammo2], ...]
    private _magazinesAmmo = magazinesAmmoCargo _container;
    private _index = -1;
    private _magArray = [_item, _ammo];

    while {_count != 0} do {
        _index = _magazinesAmmo find _magArray;

        if (_index != -1) then {
            _container addMagazineAmmoCargo [_item, -1, _ammo];

            // Process removal
            _magazinesAmmo deleteAt _index;
            _count = _count - 1;
        } else {
            break;
        };
    };

    _count == 0 // return
};
