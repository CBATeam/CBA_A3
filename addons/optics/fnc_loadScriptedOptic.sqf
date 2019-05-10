#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_loadScriptedOptic

Description:
    Sets up the CBA_ScriptedOptic weapon info display and adds the draw script.

Parameters:
    _display - CBA weapon info display <DISPLAY>
    _init    - Begin draw script, true when called from onLoad event <BOOLEAN>

Returns:
    Nothing.

Examples:
    (begin example)
        _weaponInfoDisplay call cba_optics_fnc_loadScriptedOptic;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params [["_display", displayNull], ["_init", false]];

if (_init) then {
    private _unit = call CBA_fnc_currentUnit;

    _unit call FUNC(updateOpticInfo);
};

private _ctrlRedDot = _display displayCtrl IDC_RED_DOT;
private _ctrlReticle = _display displayCtrl IDC_RETICLE;
private _ctrlBody = _display displayCtrl IDC_BODY;
private _ctrlBodyNight = _display displayCtrl IDC_BODY_NIGHT;
private _ctrlBlackScope = _display displayCtrl IDC_BLACK_SCOPE;
private _ctrlBlackLeft = _display displayCtrl IDC_BLACK_LEFT;
private _ctrlBlackRight = _display displayCtrl IDC_BLACK_RIGHT;
private _ctrlReticleSafezone = _display displayCtrl IDC_RETICLE_SAFEZONE;
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
    POS_X(GVAR(OpticBodyTextureSize)),
    POS_Y(GVAR(OpticBodyTextureSize)),
    POS_W(GVAR(OpticBodyTextureSize)),
    POS_H(GVAR(OpticBodyTextureSize))
];

_ctrlBody ctrlSetText GVAR(OpticBodyTexture);
_ctrlBody ctrlSetPosition _bodyPosition;
_ctrlBody ctrlCommit 0;

_ctrlBodyNight ctrlSetText GVAR(OpticBodyTextureNight);
_ctrlBodyNight ctrlSetPosition _bodyPosition;
_ctrlBodyNight ctrlCommit 0;

_ctrlReticleSafezone ctrlSetPosition [
    POS_X(GVAR(reticleSafezoneSize)),
    POS_Y(GVAR(reticleSafezoneSize)),
    POS_W(GVAR(reticleSafezoneSize)),
    POS_H(GVAR(reticleSafezoneSize))
];
_ctrlReticleSafezone ctrlCommit 0;

private _width = THIRD_SCREEN_WIDTH;

if (GVAR(hidePeripheralVision)) then {
    _width = 0.5 - (_bodyPosition select 2)/2 - safezoneXAbs;
};

_ctrlBlackLeft ctrlSetPositionW _width;
_ctrlBlackLeft ctrlCommit 0;

_ctrlBlackRight ctrlSetPositionW _width;
_ctrlBlackRight ctrlSetPositionX (safezoneXAbs + safezoneWAbs - _width);
_ctrlBlackRight ctrlCommit 0;

if (_init) then {
    [missionNamespace, "Draw3D", {
        if (isNull _thisArgs) exitWith {
            removeMissionEventHandler ["Draw3D", _thisId];
        };

        _thisArgs call FUNC(animateScriptedOptic);
    }, _display] call CBA_fnc_addBISEventHandler;
};

//INFO("Scripted optic weapon info display loaded.");

nil
