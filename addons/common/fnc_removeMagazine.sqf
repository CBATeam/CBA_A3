#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeMagazine

Description:
    Remove a magazine.

    Function which verifies existence of _item and _unit, returns false in case
    of trouble, or when able to remove _item from _unit true in case of success.

Parameters:
    _unit - the unit or vehicle <OBJECT>
    _item - name of the magazine to remove <STRING>
    _ammo - ammo count. used to remove a specific magazine (optional) <NUMBER>

Returns:
    true on success, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _result = [player, "SmokeShell"] call CBA_fnc_removeMagazine
    (end)

Author:
    esteldunedain, johnb43 (from ACE)

---------------------------------------------------------------------------- */
SCRIPT(removeMagazine);

params [["_unit", objNull, [objNull]], ["_item", "", [""]], ["_ammo", -1, [0]]];

private _return = false;

if (isNull _unit) exitWith {
    TRACE_2("Unit not Object or null",_unit,_item);
    _return
};

if (_item isEqualTo "") exitWith {
    TRACE_2("Item not String or empty",_unit,_item);
    _return
};

private _config = configFile >> "CfgMagazines" >> _item;

if (!isClass _config || {getNumber (_config >> "scope") < 2}) exitWith {
    TRACE_2("Item does not exist in Config",_unit,_item);
    _return
};

// Make sure magazine is in config case
_item = configName _config;

// Ensure proper ammo
_ammo = round _ammo;

if (_ammo < 0) then {
    if (_unit isKindOf "CAManBase") then {
        if !(_item in magazines _unit) exitWith {
            TRACE_2("Item not available on Unit",_unit,_item);
        };

        _unit removeMagazineGlobal _item; // removeMagazine fails on remote units

        _return = true;
    } else {
        if !(_item in magazineCargo _unit) exitWith {
            TRACE_2("Item not available on Unit",_unit,_item);
        };

        _unit addMagazineCargoGlobal [_item, -1];

        _return = true;
    };
} else {
    private _magArray = [_item, _ammo];

    private _fnc_removeMagazine = {
        params ["_container"];

        if (_magArray in (magazinesAmmoCargo _container)) exitWith {
            _container addMagazineAmmoCargo [_item, -1, _ammo];

            true
        };

        false
    };

    private _containerArray = if (_unit isKindOf "CAManBase") then {
        [uniformContainer _unit, vestContainer _unit, backpackContainer _unit]
    } else {
        [_unit]
    };

    {
        if (_x call _fnc_removeMagazine) exitWith {_return = true};
    } forEach _containerArray;
};

_return
