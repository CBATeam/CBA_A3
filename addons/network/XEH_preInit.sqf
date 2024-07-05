#include "script_component.hpp"

ADDON = false;

#include "initSettings.inc.sqf"

// Restore loadouts lost by the naked unit bug
[QGVAR(validateLoadout), {
    params ["_unit", "_loadout"];

    if (GVAR(loadoutValidation) > 0 && {getUnitLoadout _unit isNotEqualTo _loadout}) then {
        _unit setUnitLoadout _loadout;
    };
}] call CBA_fnc_addEventHandler;

["CAManBase", "Local", {
    params ["_unit", "_local"];
    if !(_local) then {
        // Broadcast loadout to new owner if unit was once local on this machine
        if (GVAR(loadoutValidation) > 0 && {_unit getVariable [QGVAR(wasLocal), false]}) then {
            if (GVAR(loadoutValidation) == 1 && {!(_unit in playableUnits)}) exitWith {};
            private _loadout = getUnitLoadout _unit;
            [QGVAR(validateLoadout), [_unit, _loadout], _unit] call CBA_fnc_targetEvent;
        };
    };
    _unit setVariable [QGVAR(wasLocal), _local];
}] call CBA_fnc_addClassEventHandler;

["CAManBase", "Init", {
    params ["_unit"];
    if (local _unit) then {
        _unit setVariable [QGVAR(wasLocal), true];
    };
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
