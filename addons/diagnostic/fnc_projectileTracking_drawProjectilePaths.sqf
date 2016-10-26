/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_projectileTracking_drawProjectilePaths

Description:
    Draws the tracked projectiles flight paths

Parameters:
    _args - PerFrameHandler arguments <ARRAY>
        _projectile - the projectile that needs to be tracked <OBJECT>
        _index      - the current index/key of the hash <NUMBER>
    _handle - PerFrameHandler handle <NUMBER>

Returns:
    nil

Examples:
    (begin example)
        [CBA_diagnostic_fnc_projectileTracking_drawProjectilePaths, 0, []] call CBA_fnc_addPerFrameHandler;
    (end)

Author:
    bux578
---------------------------------------------------------------------------- */
#include "script_component.hpp"

for "_index" from 0 to GVAR(projectileMaxLines) do {

    if ( ([GVAR(projectileData), _index] call CBA_fnc_hashHasKey) ) then {

        private _currentEntry = [GVAR(projectileData), _index] call CBA_fnc_hashGet;
        private _projectileData = _currentEntry select 1;

        private _i = 1;
        private _arrCount = count _projectileData;

        private _startSpeed = 0;

        while {_i < _arrCount} do {
            private _currentProjectileData = _projectileData select _i;

            private _prevProjectileData = nil;

            if (_i == 1) then {
                _prevProjectileData = _projectileData select 0;
                _startSpeed = _currentProjectileData select 1;
            } else {
                _prevProjectileData = _projectileData select (_i - 1);
            };

            private _currentSpeed = _currentProjectileData select 1;

            private _green = _currentSpeed / _startSpeed;
            private _red = 1 - _green;

            drawLine3D [_prevProjectileData select 0, _currentProjectileData select 0, [_red, _green, 0, 1]];

            _i = _i + 1;
        };

    };
};
