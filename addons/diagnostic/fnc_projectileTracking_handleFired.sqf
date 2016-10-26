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
#include "script_component.hpp"

params ["", "", "", "", "", "", "_projectile"];

private _index = GVAR(projectileIndex);

// if there's already an entry than remove this entry and remove the corresponding PFH
if ( [GVAR(projectileData), _index] call CBA_fnc_hashHasKey ) then {
    private _data = [GVAR(projectileData), _index] call CBA_fnc_hashGet;
    private _handle = _data select 0;

    [_handle] call CBA_fnc_removePerFrameHandler;
    [GVAR(projectileData), _index] call CBA_fnc_hashRem;
};

// using 0.1 to improve performance, we don't need that many bullet position to draw a line
[FUNC(projectileTracking_trackProjectile), 0.1, [_projectile, _index, [(getPos _projectile), vectorMagnitude (velocity _projectile)] ]] call CBA_fnc_addPerFrameHandler;


private _maxLines = GVAR(projectileMaxLines) min 20;

GVAR(projectileIndex) = _index + 1;
if (GVAR(projectileIndex) >= _maxLines) then {
    GVAR(projectileIndex) = 0;
};
