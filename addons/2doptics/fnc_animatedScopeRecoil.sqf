/*
 * Author: Taosenai, KoffeinFlummi, commy2
 * Animates 2D scope when firing.
 *
 * Arguments:
 * 0: Unit (Object)
 * 1: Weapon (String)
 * 2: Muzzle (String)
 * 3: Mode (String)
 * 4: Ammo (Object)
 * 5: Magazine (String)
 * 6: Projectile (Object)
 *
 * Return Value:
 * None
 *
 * Public: No
 */
#include "script_component.hpp"

params ["_unit", "_weapon"];

// check if compatible scope is used
private _display = uiNamespace getVariable ["BWA3_dlgAnimatedReticle", displayNull];

if (isNull _display) exitWith {};

private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;

// Reduce the reticle movement as the player drops into lower, supported stances.
private _recoilCoef = 1;

if (isWeaponDeployed _unit) then {
    _recoilCoef = 0.1;
} else {
    if (isWeaponRested _unit) then {
        _recoilCoef = 0.4;
    };
};

// Constants which determine how the scope recoils
private _recoilScope = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_RECOIL_MIN, SCOPE_RECOIL_MAX, false];

private _reticleShiftX = _recoilCoef * linearConversion [0, 1, random 1, RETICLE_SHIFT_X_MIN, RETICLE_SHIFT_X_MAX, false];
private _reticleShiftY = _recoilCoef * linearConversion [0, 1, random 1, RETICLE_SHIFT_Y_MIN, RETICLE_SHIFT_Y_MAX, false];

private _scopeShiftX = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_SHIFT_X_MIN, SCOPE_SHIFT_X_MAX, false];
private _scopeShiftY = _recoilCoef * linearConversion [0, 1, random 1, SCOPE_SHIFT_Y_MIN, SCOPE_SHIFT_Y_MAX, false];

// read default sizes from display
private _sizeBody = BWA3_OpticBodyTextureSize;

// Create and commit recoil effect
private _reticleAdjust = 1;
private _reticleSafeZoneOffsetLeft = 0;
private _reticleSafeZoneOffsetTop = 0;

if (!isNull (_display displayCtrl IDC_RETICLE_SAFEZONE)) then {
    _reticleAdjust = linearConversion BWA3_ReticleAdjust;
    _reticleSafeZoneOffsetLeft = - RETICLE_SAFEZONE_LEFT;
    _reticleSafeZoneOffsetTop = - RETICLE_SAFEZONE_TOP;
};

private _detailScaleFactor = _display getVariable ["BWA3_detailScaleFactor", 1];
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

// Bring them all back
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
