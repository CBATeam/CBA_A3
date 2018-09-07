#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_projectileTracking_handleFired

Description:
    Handles the "Fired" event for projectile tracking

Parameters:
    _eargs - Fired Event Args <ARRAY>

Returns:
    nil

Examples:
    (begin example)
        player addEventHandler ["Fired", CBA_diagnostic_fnc_projectileTracking_handleFired];
    (end)

Author:
    bux578
---------------------------------------------------------------------------- */

params ["", "", "", "", "", "", "_projectile"];

private _index = GVAR(projectileIndex);

// if there's already an entry than remove this entry and remove the corresponding PFH
if (_index <= (count GVAR(projectileData) - 1)) then {

    private _data = GVAR(projectileData) select _index;
    private _handle = _data select 0;

    [_handle] call CBA_fnc_removePerFrameHandler;
    GVAR(projectileData) set [_index, nil];
};

// using 0.1 to improve performance, we don't need that many bullet position to draw a line
[FUNC(projectileTracking_trackProjectile), 0.1, [_projectile, _index, [(getPos _projectile), vectorMagnitude (velocity _projectile)]]] call CBA_fnc_addPerFrameHandler;

private _maxLines = GVAR(projectileMaxLines) min 20;

GVAR(projectileIndex) = _index + 1;
if (GVAR(projectileIndex) >= _maxLines) then {
    GVAR(projectileIndex) = 0;
};
