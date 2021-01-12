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
    if (_local) then {
        // Enable loadout restoration for units transferred to the machine
        _unit setVariable [QGVAR(enableRestoreLoadout), true];
    } else {
        // Broadcast loadout to new owner if local was not triggered by init
        if !(_unit getVariable [QGVAR(enableRestoreLoadout), false]) then {
            _unit setVariable [QGVAR(enableRestoreLoadout), true];
        } else {
            private _loadout = getUnitLoadout _unit;
            [QGVAR(restoreLoadout), [_unit, _loadout], _unit] call CBA_fnc_targetEvent;
        };
    };
}] call CBA_fnc_addClassEventHandler;

// Enable loadout restoration for units spawned on the machine
["CAManBase", "Init", {
    params ["_unit"];
    if (local _unit) then {
        _unit setVariable [QGVAR(enableRestoreLoadout), true];
    };
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
