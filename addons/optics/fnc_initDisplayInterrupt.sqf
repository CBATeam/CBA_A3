#include "script_component.hpp"

// Check if compatible scope is used.
private _display = uiNamespace getVariable [QGVAR(ScriptedOpticDisplay), displayNull];
if (isNull _display) exitWith {};

if (!GVAR(IsUsingOptic)) exitWith {};

// Draw reticle and scope body, because they are otherwise hidden when the pause menu is shown.
QGVAR(pauseOpticLayer) cutRsc ["RscTitleDisplayEmpty", "PLAIN", 0, false];
private _display = uiNamespace getVariable "RscTitleDisplayEmpty";

private _vignette = _display displayCtrl 1202;
_vignette ctrlShow false;

private _ctrlReticle = _display ctrlCreate ["RscPicture", IDC_RETICLE];

private _reticleSize = GVAR(OpticReticleDetailTextures)#0#2;
private _reticlePosition = [
    POS_X(_reticleSize),
    POS_Y(_reticleSize),
    POS_W(_reticleSize),
    POS_H(_reticleSize)
];

_ctrlReticle ctrlSetText (GVAR(OpticReticleDetailTextures)#0#1);
_ctrlReticle ctrlSetPosition _reticlePosition;
_ctrlReticle ctrlCommit 0;

private _ctrlBody = _display ctrlCreate ["RscPicture", IDC_BODY];

private _bodyPosition = [
    POS_X(GVAR(OpticBodyTextureSize)),
    POS_Y(GVAR(OpticBodyTextureSize)),
    POS_W(GVAR(OpticBodyTextureSize)),
    POS_H(GVAR(OpticBodyTextureSize))
];

_ctrlBody ctrlSetText GVAR(OpticBodyTexture);
_ctrlBody ctrlSetPosition _bodyPosition;
_ctrlBody ctrlCommit 0;

private _ctrlBlackLeft = _display ctrlCreate ["RscText", IDC_BLACK_LEFT];
private _ctrlBlackRight = _display ctrlCreate ["RscText", IDC_BLACK_RIGHT];

private _width = THIRD_SCREEN_WIDTH;

if (GVAR(hidePeripheralVision)) then {
    _width = 0.5 - (_bodyPosition select 2)/2 - safezoneXAbs;
};

_ctrlBlackLeft ctrlSetBackgroundColor [0,0,0,1];
_ctrlBlackLeft ctrlSetPosition [
    safezoneXAbs,
    safezoneY,
    _width,
    safezoneH
];
_ctrlBlackLeft ctrlCommit 0;

_ctrlBlackRight ctrlSetBackgroundColor [0,0,0,1];
_ctrlBlackRight ctrlSetPosition [
    safezoneXAbs + safezoneWAbs - _width,
    safezoneY,
    _width,
    safezoneH
];
_ctrlBlackRight ctrlCommit 0;

// Automatically hide when pause menu is closed.
private _script = _display ctrlCreate ["RscMapControl", -1];

_script ctrlSetPosition [0,0,0,0];
_script ctrlCommit 0;

_script ctrlAddEventHandler ["Draw", {
    if (isNull (uiNamespace getVariable [["RscDisplayInterrupt", "RscDisplayMPInterrupt"] select isMultiplayer, displayNull])) then {
        {
            QGVAR(pauseOpticLayer) cutText ["", "PLAIN"];
        } call CBA_fnc_execNextFrame;
    };
}];
