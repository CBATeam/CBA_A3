#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_projectileTracking_trackProjectile

Description:
    Tracks a projectile's position and velocity and writes it to a hash

Parameters:
    _args - PerFrameHandler arguments <ARRAY>
        _projectile             - the projectile that needs to be tracked <OBJECT>
        _index                  - the current index/key of the hash <NUMBER>
        _initialProjectileData  - the initial position and speed of the projectile (due to delayed execution) <ARRAY>
    _handle - PerFrameHandler handle <NUMBER>

Returns:
    nil

Examples:
    (begin example)
        [CBA_diagnostic_fnc_projectileTracking_trackProjectile, 0.1, [_projectile, _index]] call CBA_fnc_addPerFrameHandler;
    (end)

Author:
    bux578
---------------------------------------------------------------------------- */

params ["_args", "_handle"];
_args params ["_projectile", "_index", "_initialProjectileData"];

if (!isNull _projectile) then {
    private _speed = vectorMagnitude velocity _projectile;
    if (_speed < 0.1) then { // If projectile is slowed down, stop tracking after this run
        [_handle] call CBA_fnc_removePerFrameHandler;
    };

    private _data = [];
    private _bulletData = [];

    // array has an entry at this position but is not nil
    if (_index <= (count GVAR(projectileData) - 1) && {!(isNil{(GVAR(projectileData) select _index)})}) then {
        _data = GVAR(projectileData) select _index;
        _bulletData = _data select 1;
    } else {
        _bulletData = [_initialProjectileData];
        _data = [_handle, _bulletData];
        GVAR(projectileData) set [_index, _data];
    };
    _bulletData pushBack [getPosASL _projectile, _speed];

} else {
    [_handle] call CBA_fnc_removePerFrameHandler;
};
