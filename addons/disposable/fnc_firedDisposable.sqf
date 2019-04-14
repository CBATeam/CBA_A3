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

systemChat str [_unit, _weapon];

/*
[{
    params ["_params", "_usedLauncher"];
    _params params ["_unit", "_launcher"];

    if (!local _unit) exitWith {};

    private _launcherItems = secondaryWeaponItems _unit select {_x != ""};

    _unit removeWeapon _launcher;
    _unit addWeapon _usedLauncher;

    {
        _unit addSecondaryWeaponItem _x;
    } forEach _launcherItems;

    _unit selectWeapon _usedLauncher;
}, _this, 1] call CBA_fnc_waitAndExecute;
*/
