// by commy2
#include "script_component.hpp"

params ["_display"];
uiNamespace setVariable ["BWA3_dlgAnimatedReticle", _display];

private _ctrlRedDot = _display displayCtrl IDC_RED_DOT;
private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;
private _ctrlZeroing = _display displayCtrl 168;
private _ctrlMagnification = _display displayCtrl IDC_MAGNIFICATION;

// check if optics are used
// hide all controls otherwise
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

if !(_isUsingOptic) exitWith {};

GVAR(camera) setPosASL AGLToASL positionCameraToWorld [0,0,0.4];
GVAR(camera) camPrepareTarget positionCameraToWorld [0,0,50];
GVAR(camera) camCommitPrepared 0;

// @todo, check if that needs to be done at all
if (cameraView == "GUNNER") then {
    GVAR(camera) camSetFOV 0.7;
    GVAR(camera) camCommit 0;
} else {
    GVAR(camera) camSetFOV 0.01;
    GVAR(camera) camCommit 0;
};

// add magnification to zeroing control
private _zoom = 0.25 call CBA_fnc_getFov select 1;

_ctrlMagnification ctrlSetText format [
    "(%1x)",
    [_zoom, 1, 1] call CBA_fnc_formatNumber
];

private _positionMagnification = ctrlPosition _ctrlZeroing;
_positionMagnification set [0, _positionMagnification#0 + ctrlTextWidth _ctrlZeroing];

_ctrlMagnification ctrlSetPosition _positionMagnification;
_ctrlMagnification ctrlCommit 0;

// calculate lighting
private _dayOpacity = call BWA3_fnc_ambientBrightness;
private _nightOpacity = [1,0] select (_dayOpacity == 1);

// Apply lighting and make layers visible
private _texture = "";
private _detailScaleFactor = 1;

{
    _x params ["_zoomX", "_textureX", "_detailScaleFactorX", "_textureXNight"];

    if (_zoom > _zoomX) then {
        _texture = [_textureX, _textureXNight] select (_dayOpacity < 0.5);
        _detailScaleFactor = _detailScaleFactorX;
    };
} forEach BWA3_OpticReticleDetailTextures;

_display setVariable ["BWA3_detailScaleFactor", _detailScaleFactor];

_ctrlReticle ctrlSetText _texture;
_ctrlBody ctrlSetTextColor [1,1,1,_dayOpacity];
_ctrlBodyNight ctrlSetTextColor [1,1,1,_nightOpacity];
_ctrlBlackScope ctrlShow (BWA3_usePipOptics && !isPipEnabled);

// zooming reticle
if (isNull (_display displayCtrl IDC_ENABLE_ZOOM)) exitWith {};

BWA3_ReticleAdjust set [2, _zoom];
private _reticleAdjust = linearConversion BWA3_ReticleAdjust;

private _sizeReticle = _reticleAdjust /** (_display getVariable "BWA3_sizeReticle")*/ * _detailScaleFactor;

private _positionReticle = [
    POS_X(_sizeReticle) - RETICLE_SAFEZONE_LEFT,
    POS_Y(_sizeReticle) - RETICLE_SAFEZONE_TOP,
    POS_W(_sizeReticle),
    POS_H(_sizeReticle)
];

_ctrlReticle ctrlSetPosition _positionReticle;

if (ctrlCommitted _ctrlBody) then {
    _ctrlReticle ctrlCommit 0;
};

if (_zoom > BWA3_HideRedDotMagnification) then {
    _ctrlRedDot ctrlShow false;
};

BWA3_FadeReticleInterval set [2, _zoom];
_ctrlReticle ctrlSetTextColor [1,1,1,linearConversion BWA3_FadeReticleInterval];
