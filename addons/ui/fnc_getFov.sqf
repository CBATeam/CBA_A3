#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getFov

Description:
    Get current camera's vertical field of view in radians and zoom.

    Zoom is relative to specified config FOV, defaults to 0.7 (vehicle driver initFov).

Parameters:
    (optional) base config fov value corresponding to 1x zoom, defaults to 0.7.

Examples:
    (begin example)
    _fovarray = call CBA_fnc_getFov

    _fovarray = 0.75 call CBA_fnc_getFov
    (end)

Returns:
    Array [fov,zoom]

Authors:
    q1184 (original code and calculation method)
    ceeeb (improved code and new zoom calculation method)

---------------------------------------------------------------------------- */

#define __dist 10000
#define __xOff 5000

private _zoomRef = if (IS_SCALAR(_this)) then {_this} else {0.75};

private _widthReal = safeZoneW / 2;
private _safeZoneAspectRatio = (safeZoneW / safeZoneH);
private _screenAspectRatio = _safeZoneAspectRatio * (4 / 3);

private _pos = positionCameraToWorld [__xOff, 0, __dist];
private _xPos = (worldToScreen _pos) select 0;
private _deltaX = _xPos - 0.5;

private _trigRatio = ((_widthReal * __xOff) / (__dist * _deltaX));
private _fovH = 2 * atan _trigRatio;
private _fovV = _fovH / _screenAspectRatio;
private _fovVRads = _fovV * pi / 180;
private _configFov = _trigRatio / _safeZoneAspectRatio;
private _zoom = _zoomRef / _configFov;

[_fovVRads, _zoom]
