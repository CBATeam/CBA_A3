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

---------------------------------------------------------------------------- */
#include "script_component.hpp"
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

if !(configName _config in magazines _unit) exitWith {
    TRACE_2("Item not available on Unit",_unit,_item);
    _return
};

if (_ammo < 0) then {
    _unit removeMagazineGlobal _item; // removeMagazine fails on remote units
    _return = true;
} else {
    private _uniformMagazines = [];
    private _vestMagazines = [];
    private _backpackMagazines = [];

    private _uniform = uniformContainer _unit;
    private _vest = vestContainer _unit;
    private _backpack = backpackContainer _unit;

    // magazinesAmmoCargo bugged. returns nil for objNull.
    #ifndef LINUX_BUILD
        if (!isNull _uniform) then {
            _uniformMagazines = magazinesAmmoCargo _uniform select {_x select 0 == _item};
        };

        if (!isNull _vest) then {
            _vestMagazines = magazinesAmmoCargo _vest select {_x select 0 == _item};
        };

        if (!isNull _backpack) then {
            _backpackMagazines = magazinesAmmoCargo _backpack select {_x select 0 == _item};
        };
    #else
        if (!isNull _uniform) then {
            _uniformMagazines = [magazinesAmmoCargo _uniform, {_x select 0 == _item}] call BIS_fnc_conditionalSelect;
        };

        if (!isNull _vest) then {
            _vestMagazines = [magazinesAmmoCargo _vest, {_x select 0 == _item}] call BIS_fnc_conditionalSelect;
        };

        if (!isNull _backpack) then {
            _backpackMagazines = [magazinesAmmoCargo _backpack, {_x select 0 == _item}] call BIS_fnc_conditionalSelect;
        };
    #endif

    {
        if (_x select 1 == _ammo) exitWith {
            _uniformMagazines deleteAt _forEachIndex;
            _return = true;
        };
    } forEach _uniformMagazines;

    if !(_return) then {
        {
            if (_x select 1 == _ammo) exitWith {
                _vestMagazines deleteAt _forEachIndex;
                _return = true;
            };
        } forEach _vestMagazines;
    };

    if !(_return) then {
        {
            if (_x select 1 == _ammo) exitWith {
                _backpackMagazines deleteAt _forEachIndex;
                _return = true;
            };
        } forEach _backpackMagazines;
    };

    if (_return) then {
        _unit removeMagazines _item; // doc wrong. works on remote units

        {
            _uniform addMagazineAmmoCargo [_item, 1, _x select 1];
        } forEach _uniformMagazines;

        {
            _vest addMagazineAmmoCargo [_item, 1, _x select 1];
        } forEach _vestMagazines;

        {
            _backpack addMagazineAmmoCargo [_item, 1, _x select 1];
        } forEach _backpackMagazines;
    };
};

_return
