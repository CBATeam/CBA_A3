#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFov

Description:
    Get current camera's vertical field of view in radians and zoom.

    Zoom is relative to specified config FOV, defaults to 0.75 (vehicle driver initFov).

Parameters:
    (optional) base config fov value corresponding to 1x zoom, defaults to 0.75.

Examples:
    (begin example)
        private _fieldOfView = [] call CBA_fnc_getFov select 0;
        private _zoom = 0.75 call CBA_fnc_getFov select 1;
    (end)

Returns:
    Array [fov,zoom]

Authors:
    q1184 (original code and calculation method)
    ceeeb (improved code and new zoom calculation method)
    streamlined by commy2
---------------------------------------------------------------------------- */

params [["_baseFOV", 0.75, [0]]];

private _trigRatio = safeZoneW / 2 / ((worldToScreen positionCameraToWorld [10000, 0, 10000] select 0) - 0.5);

[
    rad (2 * atan _trigRatio / (getResolution select 4)),
    _baseFOV * (safeZoneW / safeZoneH) / _trigRatio
]
