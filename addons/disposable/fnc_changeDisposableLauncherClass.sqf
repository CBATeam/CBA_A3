#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_disposable_fnc_changeDisposableLauncherClass

Description:
    Switch loaded launcher class to class that can be fired with magazine.

Parameters:
    _unit - The avatar <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_disposable_fnc_changeDisposableLauncherClass;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];
if (!local _unit) exitWith {};

private _launcher =  GVAR(NormalLaunchers) getVariable secondaryWeapon _unit;

if (!isNil "_launcher") then {
    _launcher params ["_launcher", "_magazine"];

    private _launcherItems = secondaryWeaponItems _unit;
    private _launcherMagazines = WEAPON_MAGAZINES(_unit,secondaryWeapon _unit);

    if (!isNil "_magazine") then {
        _launcherMagazines pushBack _magazine;
    };

    [_unit, _launcher] call CBA_fnc_addWeaponWithoutItems;

    {
        _unit addSecondaryWeaponItem _x;
    } forEach _launcherItems;

    {
        _unit addWeaponItem [_launcher, _x];
    } forEach _launcherMagazines;
};
