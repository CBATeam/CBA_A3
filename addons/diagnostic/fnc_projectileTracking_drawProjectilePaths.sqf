#include "script_component.hpp"
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

private _maxLines = GVAR(projectileMaxLines) min 20;

for "_index" from 0 to _maxLines do {
    if (_index <= (count GVAR(projectileData) - 1) ) then {
        private _currentEntry = GVAR(projectileData) select _index;

        if (!(isNil {_currentEntry})) then {
            private _projectileData = _currentEntry select 1;
            private _arrCount = count _projectileData;
            private _startSpeed = 0;

            {
                private _currentProjectileData = _x;
                private _nextProjectileData = nil;

                if (_forEachIndex == 0) then {
                    _startSpeed = _currentProjectileData select 1;
                };

                if (_forEachIndex == _arrCount - 1) then {
                    _nextProjectileData =  _currentProjectileData;
                } else {
                    _nextProjectileData = _projectileData select (_forEachIndex + 1);
                };

                private _currentSpeed = _currentProjectileData select 1;
                private _green = _currentSpeed / _startSpeed;
                private _red = 1 - _green;

                drawLine3D [_currentProjectileData select 0, _nextProjectileData select 0, [_red, _green, 0, 1]];

            } forEach _projectileData;
        };
    };
};
