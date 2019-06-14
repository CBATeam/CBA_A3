#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_gunBank

Description:
    Reports the bank at which the primary weapon is tilted.

Parameters:
    None.

Returns:
    Leaning angle of avatar.

Examples:
    (begin example)
        call cba_optics_fnc_gunBank;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

private _unit = [] call CBA_fnc_currentUnit;

private _aim = _unit modelToWorldVisualWorld (_unit selectionPosition "Pelvis");
private _cam = _unit modelToWorldVisualWorld (_unit selectionPosition "camera");
private _up = _aim vectorFromTo _cam;

private _wDir = _unit weaponDirection primaryWeapon _unit;
private _wLat = vectorNormalized (_wDir vectorCrossProduct _up);
private _wUp = _wLat vectorCrossProduct _wDir;

private _right = AGLToASL positionCameraToWorld [0,0,0] vectorFromTo AGLToASL positionCameraToWorld [1,0,0];

90 - acos (_right vectorCos _wUp) // return
