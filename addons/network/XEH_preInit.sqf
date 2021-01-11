#include "script_component.hpp"

ADDON = false;

// Restore loadouts lost by the naked unit bug
[QGVAR(restoreLoadout), {
    params ["_unit", "_loadout"];
    if (count _loadout < 7) exitWith {};

    // Check if loadout got lost
    private _loadoutLost = False;
    {
        (_loadout select _forEachIndex) params [["_backup", "", [""]]];
        // Reject backup if it contains less information
        if (_backup isEqualTo "" && !(_x isEqualTo "")) exitWith {};
        if !(_x isEqualTo _backup) exitWith {
            _loadoutLost = True;
        };
    } forEach [
        primaryWeapon _unit,
        secondaryWeapon _unit,
        handgunWeapon _unit,
        uniform _unit,
        vest _unit,
        backpack _unit,
        headgear _unit
    ];

    if (_loadoutLost) then {
        _unit setUnitLoadout _loadout;
    };
}] call CBA_fnc_addEventHandler;

["CAManBase", "Local", {
    params ["_unit", "_local"];
    if !(_local) then {
        private _loadout = getUnitLoadout _unit;
        [QGVAR(restoreLoadout), [_unit, _loadout], _unit] call CBA_fnc_targetEvent;
    };
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
