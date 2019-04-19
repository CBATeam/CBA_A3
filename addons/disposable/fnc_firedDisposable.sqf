#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_firedDisposable

Description:
    Handles firing a disposable weapon.

Parameters:
    _unit       - Unit that fired the disposable weapon <OBEJCT>
    _weapon     - Disposable weapon <STRING>
    _muzzle     - Muzzle fired by the disposable weapon <STRING>
    _mode       - Current weapon mode of the disposable weapon <STRING>
    _ammo       - Ammo fired by the disposable weapon <STRING>
    _magazine   - Current magazine of the disposable weapon <STRING>
    _projectile - Fired projectile <OBEJCT>
    _unit       - Always same as element 0 <OBEJCT>

Returns:
    Nothing.

Examples:
    (begin example)
        class EventHandlers {
            fired = "_this call CBA_fnc_firedDisposable";
        };
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit", "_weapon", "_muzzle"];

private _usedLauncher = GVAR(UsedLaunchers) getVariable _weapon;
if (isNil "_usedLauncher") exitWith {};

[{
    params ["_unit", "_launcher", "_usedLauncher"];
    if (!local _unit) exitWith {};

    private _isSelected = currentWeapon _unit == _launcher;

    private _launcherItems = secondaryWeaponItems _unit;
    private _launcherMagazines = secondaryWeaponMagazine _unit;

    _unit addWeapon _usedLauncher;
    {
        _unit addSecondaryWeaponItem _x;
    } forEach _launcherItems;

    {
        _unit addWeaponItem [_usedLauncher, _x];
    } forEach _launcherMagazines;

    if (_isSelected) then {
        _unit selectWeapon _usedLauncher;
    };
}, [_unit, _weapon, _usedLauncher], 1] call CBA_fnc_waitAndExecute;

// @todo drop
