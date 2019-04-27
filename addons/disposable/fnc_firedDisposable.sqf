#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_firedDisposable

Description:
    Handles firing a disposable weapon.

Parameters:
    _unit       - Unit that fired the disposable weapon <OBEJCT>
    _launcher   - Disposable weapon <STRING>
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

params ["_unit", "_launcher", "_muzzle", "", "", "", "_projectile"];

private _usedLauncher = GVAR(UsedLaunchers) getVariable _launcher;
if (isNil "_usedLauncher") exitWith {};

[{
    params ["_unit", "_launcher", "_usedLauncher", "_projectile"];

    // switch to used tube
    if (local _unit) then {
        private _isSelected = currentWeapon _unit == _launcher;

        private _launcherItems = secondaryWeaponItems _unit;
        private _launcherMagazines = WEAPON_MAGAZINES(_unit,secondaryWeapon _unit);

        [_unit, _usedLauncher] call CBA_fnc_addWeaponWithoutItems;

        if (_isSelected) then {
            _unit selectWeapon _usedLauncher;
        };

        {
            _unit addSecondaryWeaponItem _x;
        } forEach _launcherItems;

        {
            _unit addWeaponItem [_usedLauncher, _x];
        } forEach _launcherMagazines;
    };

    // automatically drop
    if (GVAR(dropUsedLauncher) isEqualTo 0) exitWith {};

    [{
        params ["_unit", "_usedLauncher", "_projectile"];

        // quit if dead or weapon is gone
        if (!alive _unit || secondaryWeapon _unit != _usedLauncher) exitWith {true};

        if (local _unit && {
            if (_unit == call CBA_fnc_currentUnit) then {
                cameraView != "GUNNER"
            } else {
                isNull _projectile
            };
        }) exitWith {
            if (GVAR(dropUsedLauncher) isEqualTo 1 && {_unit == call CBA_fnc_currentUnit}) exitWith {true};

            private _launcherItems = secondaryWeaponItems _unit;
            private _launcherMagazines = WEAPON_MAGAZINES(_unit,secondaryWeapon _unit);

            _unit removeWeapon _usedLauncher;

            private _dir = getDir _unit - 180;

            private _container = createVehicle ["WeaponHolderSimulated", [0,0,0], [], 0, "CAN_COLLIDE"];
            _container addWeaponCargoGlobal [_usedLauncher, 1];

            _container setDir (_dir + 90);
            _container setPosASL AGLToASL (_unit modelToWorld (_unit selectionPosition "rightshoulder" vectorAdd [0, 0.2, 0.1]));
            _container setVelocity (velocity _unit vectorAdd ([sin _dir, cos _dir, 0] vectorMultiply 1.5));

            /*
            _container addWeaponWithAttachmentsCargoGlobal [
                _usedLauncher,
                _silencer, _pointer, _optic, _bipod, [
                    _magazine1, _ammo1,
                    _magazine2, _ammo2
                ],
            1];
            */

            {
                _container addItemCargoGlobal [_x, 1];
            } forEach _launcherItems;

            {
                _x params ["_magazine", "_ammo"];

                if (_ammo > 0) then {
                    _container addMagazineAmmoCargo [_x, 1, _ammo];
                };
            } forEach _launcherMagazines;

            true // quit
        };

        false // continue
    }, {}, [_unit, _usedLauncher, _projectile]] call CBA_fnc_waitUntilAndExecute;
}, [_unit, _launcher, _usedLauncher, _projectile], 1] call CBA_fnc_waitAndExecute;
