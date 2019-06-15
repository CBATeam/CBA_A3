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

private _pelvis = _unit modelToWorldVisualWorld (_unit selectionPosition "Pelvis");
private _camera = _unit modelToWorldVisualWorld (_unit selectionPosition "camera");
private _bodyUp = _pelvis vectorFromTo _camera;

private _weaponDir = _unit weaponDirection currentWeapon _unit;
private _weaponLat = vectorNormalized (_weaponDir vectorCrossProduct _bodyUp);
private _weaponUp = _weaponLat vectorCrossProduct _weaponDir;

private _screenRight = AGLToASL positionCameraToWorld [0,0,0] vectorFromTo AGLToASL positionCameraToWorld [1,0,0];

90 - acos (_screenRight vectorCos _weaponUp) // return
