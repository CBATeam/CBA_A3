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

#include <script_component.hpp>
#define __dist 10000
#define __xOff 5000

private ["_zoomRef", "_widthReal", "_safeZoneAspectRatio", "_screenAspectRatio", "_pos", "_xPos", "_deltaX", "_trigRatio", "_fovH", "_fovV", "_fovVRads", "_configFov", "_zoom"];

_zoomRef = if (IS_SCALAR(_this)) then {_this} else {0.75};

_widthReal = safeZoneW / 2;
_safeZoneAspectRatio = (safeZoneW / safeZoneH);
_screenAspectRatio = _safeZoneAspectRatio * (4 / 3);

_pos = positionCameraToWorld [__xOff, 0, __dist];
_xPos = (worldToScreen _pos) select 0;
_deltaX = _xPos - 0.5;

_trigRatio = ((_widthReal * __xOff) / (__dist * _deltaX));
_fovH = 2 * atan _trigRatio;
_fovV = _fovH / _screenAspectRatio;
_fovVRads = _fovV * pi / 180;
_configFov = _trigRatio / _safeZoneAspectRatio;
_zoom = _zoomRef / _configFov;

[_fovVRads, _zoom]
