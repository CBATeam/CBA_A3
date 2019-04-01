#include "script_component.hpp"

if (isNil QGVAR(OpticReticleDetailTextures) || {GVAR(OpticReticleDetailTextures) isEqualTo []}) then {
    BWA3_LOGWARNING("No scripted reticle info found.");
    private _unit = call CBA_fnc_currentUnit;
    _unit call BWA3_fnc_updateOpticInfo;
};

params ["_display"];

private _ctrlRedDot = _display displayCtrl IDC_RED_DOT;
private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;
private _ctrlMagnification = _display displayCtrl IDC_MAGNIFICATION;

_ctrlRedDot ctrlShow false;
_ctrlReticle ctrlShow false;
_ctrlBody ctrlShow false;
_ctrlBodyNight ctrlShow false;
_ctrlBlackScope ctrlShow false;
_ctrlBlackLeft ctrlShow false;
_ctrlBlackRight ctrlShow false;
_ctrlMagnification ctrlShow false;

private _reticleSize = GVAR(OpticReticleDetailTextures)#0#2;
private _reticlePosition = [
    POS_X(_reticleSize),
    POS_Y(_reticleSize),
    POS_W(_reticleSize),
    POS_H(_reticleSize)
];

_ctrlReticle ctrlSetPosition _reticlePosition;
_ctrlReticle ctrlCommit 0;

private _bodyPosition = [
    POS_X(GVAR(OpticBodyTexture)Size),
    POS_Y(GVAR(OpticBodyTexture)Size),
    POS_W(GVAR(OpticBodyTexture)Size),
    POS_H(GVAR(OpticBodyTexture)Size)
];

_ctrlBody ctrlSetText GVAR(OpticBodyTexture);
_ctrlBody ctrlSetPosition _bodyPosition;
_ctrlBody ctrlCommit 0;

_ctrlBodyNight ctrlSetText GVAR(OpticBodyTextureNight);
_ctrlBodyNight ctrlSetPosition _bodyPosition;
_ctrlBodyNight ctrlCommit 0;

[missionNamespace, "Draw3D", {
    if (isNull _thisArgs) exitWith {
        removeMissionEventHandler ["Draw3D", _thisId];
    };

    _thisArgs call BWA3_fnc_animateReticle;
}, _display] call CBA_fnc_addBISEventHandler;
