#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_2doptics_fnc_animateOpticRecoil

Description:
    Animates the 2D optic when firing.

Parameters:
    _unit   - The avatar <OBJECT>
    _weapon - Fired weapon <STRING>

Returns:
    Nothing.

Examples:
    (begin example)
        [player, currentWeapon player] call cba_2doptics_fnc_animateOpticRecoil;
    (end)

Author:
    commy2, (Taosenai, KoffeinFlummi)
---------------------------------------------------------------------------- */

params ["_unit", "_weapon"];
if (_unit != call CBA_fnc_currentUnit) exitWith {};

// Check if compatible scope is used.
private _display = uiNamespace getVariable [QGVAR(ScriptedOpticDisplay), displayNull];

if (isNull _display) exitWith {};

private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;

// Reduce the reticle movement as the player drops into lower, supported stances.
private _recoilCoef = SCOPE_RECOIL_COEF;

if (isWeaponDeployed _unit) then {
    _recoilCoef = SCOPE_RECOIL_COEF_DEPLOYED;
} else {
    if (isWeaponRested _unit) then {
        _recoilCoef = SCOPE_RECOIL_COEF_RESTED;
    };
};

// Constants which determine how the scope recoils.
private _recoilScope = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_RECOIL_MIN, SCOPE_RECOIL_MAX, false];

private _reticleShiftX = _recoilCoef * linearConversion [0, 1, random 1, RETICLE_SHIFT_X_MIN, RETICLE_SHIFT_X_MAX, false];
private _reticleShiftY = _recoilCoef * linearConversion [0, 1, random 1, RETICLE_SHIFT_Y_MIN, RETICLE_SHIFT_Y_MAX, false];

private _scopeShiftX = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_SHIFT_X_MIN, SCOPE_SHIFT_X_MAX, false];
private _scopeShiftY = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_SHIFT_Y_MIN, SCOPE_SHIFT_Y_MAX, false];

// Read default sizes from display.
private _sizeBody = GVAR(OpticBodyTextureSize);

// Create and commit recoil effect.
private _reticleAdjust = 1;
private _reticleSafeZoneOffsetLeft = 0;
private _reticleSafeZoneOffsetTop = 0;

if (!isNull (_display displayCtrl IDC_RETICLE_SAFEZONE)) then {
    _reticleAdjust = linearConversion GVAR(ReticleAdjust);
    _reticleSafeZoneOffsetLeft = - RETICLE_SAFEZONE_LEFT;
    _reticleSafeZoneOffsetTop = - RETICLE_SAFEZONE_TOP;
};

private _detailScaleFactor = _display getVariable [QGVAR(DetailScaleFactor), 1];
private _size = _reticleAdjust * _detailScaleFactor + _recoilScope;

private _positionReticle = [
    POS_X(_size + _reticleShiftX) + _reticleSafeZoneOffsetLeft,
    POS_Y(_size + _reticleShiftY) + _reticleSafeZoneOffsetTop,
    POS_W(_size),
    POS_H(_size)
];

_ctrlReticle ctrlSetPosition _positionReticle;

_size = _sizeBody + _recoilScope;

private _positionBody = [
    POS_X(_size + _reticleShiftX),
    POS_Y(_size + _reticleShiftY),
    POS_W(_size),
    POS_H(_size)
];

_ctrlBody ctrlSetPosition _positionBody;
_ctrlBodyNight ctrlSetPosition _positionBody;

_ctrlReticle ctrlCommit 0;
_ctrlBody ctrlCommit 0;
_ctrlBodyNight ctrlCommit 0;

// Bring them all back.
private _sizeReticle = _reticleAdjust * _detailScaleFactor;

_positionReticle = [
    POS_X(_sizeReticle) + _reticleSafeZoneOffsetLeft,
    POS_Y(_sizeReticle) + _reticleSafeZoneOffsetTop,
    POS_W(_sizeReticle),
    POS_H(_sizeReticle)
];

_ctrlReticle ctrlSetPosition _positionReticle;

_positionBody = [
    POS_X(_sizeBody),
    POS_Y(_sizeBody),
    POS_W(_sizeBody),
    POS_H(_sizeBody)
];

_ctrlBody ctrlSetPosition _positionBody;
_ctrlBodyNight ctrlSetPosition _positionBody;

_ctrlReticle ctrlCommit RECENTER_TIME;
_ctrlBody ctrlCommit RECENTER_TIME;
_ctrlBodyNight ctrlCommit RECENTER_TIME;
