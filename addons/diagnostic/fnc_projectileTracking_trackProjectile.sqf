/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_projectileTracking_trackProjectile

Description:
    Tracks a projectile's position and velocity and writes it to a hash

Parameters:
    _args - PerFrameHandler arguments <ARRAY>
        _projectile - the projectile that needs to be tracked <OBJECT>
        _index      - the current index/key of the hash <NUMBER>
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
#include "script_component.hpp"

params ["_args", "_handle"];
_args params ["_projectile", "_index"];

if (!isNull _projectile) then {

    private _data = [];
    private _bulletData = [];

    if ( [GVAR(projectileData), _index] call CBA_fnc_hashHasKey ) then {
        _data = [GVAR(projectileData), _index] call CBA_fnc_hashGet;
        _bulletData = _data select 1;
    } else {
        _bulletData = [];
        _data = [_handle, _bulletData];
    };

    _bulletData pushBack [(getPos _projectile), vectorMagnitude (velocity _projectile)];

    _data set [1, _bulletData];

    [GVAR(projectileData), _index, _data] call CBA_fnc_hashSet;

} else {
    [_handle] call CBA_fnc_removePerFrameHandler;
};
