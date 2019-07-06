#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: cba_optics_fnc_updateOpticInfo

Description:
    Caches the current optic's parameters in mission namespace variables.

Parameters:
    _unit - The avatar <OBJECT>

Returns:
    Nothing.

Examples:
    (begin example)
        player call cba_optics_fnc_updateOpticInfo;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */

params ["_unit"];

// Update scripted optic cache.
private _optic = _unit call FUNC(currentOptic);systemChat str [_optic, diag_frameNo];
if (_optic isEqualTo GVAR(currentOptic)) exitWith {};
GVAR(currentOptic) = _optic;

private _config = configFile >> "CfgWeapons" >> _optic >> "CBA_ScriptedOptic";
if (!isClass _config) exitWith {
    GVAR(OpticReticleDetailTextures) = [[0,"",1,""]];
    GVAR(OpticBodyTexture) = "";
    ppEffectDestroy GVAR(ppEffects);
};

getArray (_config >> "minMagnificationReticleScale") apply {PARSE(_x)} params [["_minMagnification", 1], ["_minMagnificationReticleScale", 1]];
getArray (_config >> "maxMagnificationReticleScale") apply {PARSE(_x)} params [["_maxMagnification", 1], ["_maxMagnificationReticleScale", 1]];

GVAR(ReticleAdjust) = [
    _minMagnification, _maxMagnification, 1,
    _minMagnificationReticleScale, _maxMagnificationReticleScale
];

GVAR(HideRedDotMagnification) = getNumber (_config >> "hideRedDotMagnification");

getArray (_config >> "fadeReticleInterval") apply {PARSE(_x)} params [["_fadeStart", 0], ["_fadeEnd", 0]];

GVAR(FadeReticleInterval) = [
    _fadeStart, _fadeEnd, 1,
    1, 0, true
];

GVAR(OpticReticleDetailTextures) = getArray (_config >> "reticleDetailTextures") apply {[PARSE(_x#0), _x#1, PARSE(_x#2), _x param [3, _x#1]]};

if (GVAR(OpticReticleDetailTextures) isEqualTo []) then {
    private _reticleTexture = getText (_config >> "reticleTexture");
    private _reticleTextureSize = getNumber (_config >> "reticleTextureSize");
    private _reticleTextureeNight = getText (_config >> "reticleTextureNight");

    if (_reticleTextureeNight isEqualTo "") then {
        _reticleTextureeNight = _reticleTexture;
    };

    GVAR(OpticReticleDetailTextures) = [[0, _reticleTexture, _reticleTextureSize, _reticleTextureeNight]];
};

GVAR(OpticBodyTexture) = getText (_config >> "bodyTexture");
GVAR(OpticBodyTextureSize) = getNumber (_config >> "bodyTextureSize");
GVAR(OpticBodyTextureNight) = getText (_config >> "bodyTextureNight");

if (GVAR(OpticBodyTextureNight) isEqualTo "") then {
    GVAR(OpticBodyTextureNight) = GVAR(OpticBodyTexture);
};

GVAR(manualReticleNightSwitch) = getNumber (_config >> "manualReticleNightSwitch") != 0;

GVAR(reticleSafezoneSize) = RETICLE_SAFEZONE_DEFAULT_SIZE;

if (isNumber (_config >> "reticleSafezoneSize")) then {
    GVAR(reticleSafezoneSize) = getNumber (_config >> "reticleSafezoneSize");
};

GVAR(hidePeripheralVision) = getNumber (_config >> "hidePeripheralVision") != 0;

// zeroing distances
configProperties [configFile >> "CfgWeapons" >> _optic >> "ItemInfo" >> "OpticsModes"] findIf {
    GVAR(ZeroingDistances) = getArray (_x >> "discreteDistance");
    !(GVAR(ZeroingDistances) isEqualTo [])
};

// pp effects
ppEffectDestroy GVAR(ppEffects);

GVAR(ppEffects) = getArray (_config >> "opticsPPEffects") apply {
    private _config = configFile >> "CfgOpticsEffect" >> _x;
    private _type = getText (_config >> "type");
    private _priority = getNumber (_config >> "priority");
    private _params = getArray (_config >> "params") apply {
        if (_x isEqualType "") then {
            call compile _x
        } else {_x};
    };

    private _ppEffect = ppEffectCreate [_type, _priority];
    _ppEffect ppEffectAdjust _params;

    _ppEffect ppEffectEnable false;
    _ppEffect ppEffectForceInNVG true;
    _ppEffect ppEffectCommit 0;
    _ppEffect
};

GVAR(hideMagnification) = getNumber (_config >> "hideMagnification") != 0;
GVAR(disableTilt) = getNumber (_config >> "disableTilt") != 0;

[uiNamespace getVariable QGVAR(ScriptedOpticDisplay), false] call FUNC(loadScriptedOptic);

//INFO_1("Updated optic info %1.",_optic);

nil
