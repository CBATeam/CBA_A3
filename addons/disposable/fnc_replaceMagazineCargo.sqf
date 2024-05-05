#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_disposable_fnc_replaceMagazineCargo

Description:
    Replaces disposable launcher magazines with loaded disposable launchers.

Parameters:
    _container - Any object with cargo <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        _container call cba_disposable_fnc_replaceMagazineCargo
    (end)

Author:
    commy2, johnb43
---------------------------------------------------------------------------- */

if (!GVAR(replaceDisposableLauncher)) exitWith {};

params ["_container"];

if (!local _container) exitWith {};
if (missionNamespace getVariable [QGVAR(disableMagazineReplacement), false]) exitWith {};

private _containers = everyBackpack _container;

if (_container isKindOf "CAManBase") then {
    _containers append ([uniformContainer _container, vestContainer _container, backpackContainer _container] select {!isNull _x});
};

// Replace all magazines recursively
{
    _x call FUNC(replaceMagazineCargo);
} forEach _containers;

private _magazines = (magazineCargo _container) select {_x in GVAR(magazines)};

if (_magazines isEqualTo []) exitWith {};

// Replace magazines with disposable launchers
{
    _container addMagazineCargoGlobal [_x, -1];

    // Ignores slot restrictions, but that's wanted, as magazines shouldn't just vanish
    _container addWeaponCargoGlobal [GVAR(MagazineLaunchers) getVariable _x, 1];
} forEach _magazines;
