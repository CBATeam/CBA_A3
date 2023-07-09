#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_animateScriptedOptic

Description:
    Executed every draw frame to update the scripted weapon info display.

Parameters:
    _display - CBA weapon info display <DISPLAY>

Returns:
    Nothing.

Examples:
    (begin example)
        _weaponInfoDisplay call cba_optics_fnc_animateScriptedOptic;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_display"];
if (!ctrlShown (_display displayCtrl IDC_ACTIVE_DISPLAY)) exitWith {};
uiNamespace setVariable [QGVAR(ScriptedOpticDisplay), _display];

private _ctrlRedDot = _display displayCtrl IDC_RED_DOT;
private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;
private _ctrlReticleSafezone = _display displayCtrl IDC_RETICLE_SAFEZONE;
private _ctrlZeroing = _display displayCtrl 168;
private _ctrlMagnification = _display displayCtrl IDC_MAGNIFICATION;

// Check if optics are used, hide all controls otherwise.
private _isUsingOptic = ctrlShown (_display displayCtrl 154);

_ctrlRedDot ctrlShow _isUsingOptic;
_ctrlReticle ctrlShow _isUsingOptic;
_ctrlBody ctrlShow _isUsingOptic;
_ctrlBodyNight ctrlShow _isUsingOptic;
_ctrlBlackScope ctrlShow _isUsingOptic;
_ctrlBlackLeft ctrlShow _isUsingOptic;
_ctrlBlackRight ctrlShow _isUsingOptic;
//_ctrlZeroing ctrlShow _isUsingOptic;
_ctrlMagnification ctrlShow _isUsingOptic;

GVAR(ppEffects) ppEffectEnable _isUsingOptic;

if (_isUsingOptic isNotEqualTo GVAR(IsUsingOptic)) then {
    GVAR(IsUsingOptic) = _isUsingOptic;
    [QGVAR(UsingOptic), [_display, _isUsingOptic]] call CBA_fnc_localEvent;
};

if !(_isUsingOptic) exitWith {};

GVAR(camera) setPosASL AGLToASL positionCameraToWorld [0,0,0.4];
GVAR(camera) camPrepareTarget positionCameraToWorld [0,0,50];
GVAR(camera) camCommitPrepared 0;

// @todo, check if that needs to be done at all
if (cameraView == "GUNNER") then {
    GVAR(camera) camSetFOV 0.75;
    GVAR(camera) camCommit 0;
} else {
    GVAR(camera) camSetFOV 0.01;
    GVAR(camera) camCommit 0;
};

// Add magnification to zeroing control.
private _zoom = 0.25 call CBA_fnc_getFov select 1;

// To avoid flickering of the magnification text, anything above and including 0.995 is rounded to 1
if (_zoom >= 0.995) then {
	_zoom = 1 max _zoom;
};

_ctrlMagnification ctrlSetText format [
    "(%1x)",
    [_zoom, 1, 1] call CBA_fnc_formatNumber
];

_ctrlMagnification ctrlShow (_zoom >= 1 && {!GVAR(hideMagnification)});

private _positionMagnification = ctrlPosition _ctrlZeroing;
_positionMagnification set [0, _positionMagnification#0 + ctrlTextWidth _ctrlZeroing];

_ctrlMagnification ctrlSetPosition _positionMagnification;
_ctrlMagnification ctrlCommit 0;

// Calculate lighting.
private _dayOpacity = AMBIENT_BRIGHTNESS;
private _nightOpacity = [1,0] select (_dayOpacity == 1);

private _useReticleNight = GVAR(useReticleNight);

if (!GVAR(manualReticleNightSwitch)) then {
    _useReticleNight = _dayOpacity < 0.5;
};

// Apply lighting and make layers visible.
private _texture = "";
private _detailScaleFactor = 1;

{
    _x params ["_zoomX", "_textureX", "_detailScaleFactorX", "_textureXNight"];

    if (_zoom > _zoomX) then {
        _texture = [_textureX, _textureXNight] select _useReticleNight;
        _detailScaleFactor = _detailScaleFactorX;
    };
} forEach GVAR(OpticReticleDetailTextures);

_display setVariable [QGVAR(DetailScaleFactor), _detailScaleFactor];

_ctrlReticle ctrlSetText _texture;
_ctrlBody ctrlSetTextColor [1,1,1,_dayOpacity];
_ctrlBodyNight ctrlSetTextColor [1,1,1,_nightOpacity];
_ctrlBlackScope ctrlShow (GVAR(usePipOptics) && !isPipEnabled);

// tilt while leaning
private _bank = 0;

if (!GVAR(disableTilt)) then {
    _bank = call FUNC(gunBank);
};

_ctrlReticle ctrlSetAngle [_bank, 0.5, 0.5];
_ctrlBody ctrlSetAngle [_bank, 0.5, 0.5];
_ctrlBodyNight ctrlSetAngle [_bank, 0.5, 0.5];

// zooming reticle
if (isNull (_display displayCtrl IDC_ENABLE_ZOOM)) exitWith {};

if (_zoom >= 1) then {
    GVAR(magnificationCache) = _zoom;
};

GVAR(ReticleAdjust) set [2, _zoom];
private _reticleAdjust = linearConversion GVAR(ReticleAdjust);
private _sizeReticle = _reticleAdjust * _detailScaleFactor;
ctrlPosition _ctrlReticleSafezone params ["_reticleSafeZonePositionLeft", "_reticleSafeZonePositionTop"];

private _positionReticle = [
    POS_X(_sizeReticle) - _reticleSafeZonePositionLeft,
    POS_Y(_sizeReticle) - _reticleSafeZonePositionTop,
    POS_W(_sizeReticle),
    POS_H(_sizeReticle)
];

_ctrlReticle ctrlSetPosition _positionReticle;

if (ctrlCommitted _ctrlBody) then {
    _ctrlReticle ctrlCommit 0;
};

if (_zoom > GVAR(HideRedDotMagnification)) then {
    _ctrlRedDot ctrlShow false;
};

GVAR(FadeReticleInterval) set [2, _zoom];
_ctrlReticle ctrlSetTextColor [1,1,1,linearConversion GVAR(FadeReticleInterval)];
