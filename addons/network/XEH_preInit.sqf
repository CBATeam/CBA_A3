#include "script_component.hpp"

ADDON = false;

// Restore loadouts lost by the naked unit bug
[QGVAR(validateLoadout), {
    params ["_unit", "_loadout"];

    if !(getUnitLoadout _unit isEqualTo _loadout) then {
        _unit setUnitLoadout _loadout;
    };

}] call CBA_fnc_addEventHandler;

["CAManBase", "Local", {
    params ["_unit", "_local"];
    if (_local) then {
        _unit setVariable [QGVAR(wasLocal), true];
    } else {
        // Broadcast loadout to new owner if unit was once local on this machine
        if (_unit getVariable [QGVAR(wasLocal), false]) then {
            private _loadout = getUnitLoadout _unit;
            [QGVAR(validateLoadout), [_unit, _loadout], _unit] call CBA_fnc_targetEvent;
        };
    };
}] call CBA_fnc_addClassEventHandler;

["CAManBase", "Init", {
    params ["_unit"];
    if (local _unit) then {
        _unit setVariable [QGVAR(wasLocal), true];
    };
}] call CBA_fnc_addClassEventHandler;

ADDON = true;
