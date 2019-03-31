#include "script_component.hpp"

params ["_unit"];

// update scripted optic cache
private _optic = _unit call BWA3_fnc_currentOptic;
if (_optic isEqualTo BWA3_currentOptic) exitWith {};
BWA3_currentOptic = _optic;

private _config = configFile >> "CfgWeapons" >> _optic >> "BWA3_ScriptedOptic";
if (!isClass _config) exitWith {};

getArray (_config >> "minMagnificationReticleScale") apply {PARSE(_x)} params [["_minMagnification", 1], ["_minMagnificationReticleScale", 1]];
getArray (_config >> "maxMagnificationReticleScale") apply {PARSE(_x)} params [["_maxMagnification", 1], ["_maxMagnificationReticleScale", 1]];

BWA3_ReticleAdjust = [
    _minMagnification, _maxMagnification, 1,
    _minMagnificationReticleScale, _maxMagnificationReticleScale
];

BWA3_HideRedDotMagnification = getNumber (_config >> "hideRedDotMagnification");

getArray (_config >> "fadeReticleInterval") apply {PARSE(_x)} params [["_fadeStart", 0], ["_fadeEnd", 0]];

BWA3_FadeReticleInterval = [
    _fadeStart, _fadeEnd, 1,
    1, 0, true
];

BWA3_OpticReticleDetailTextures = getArray (_config >> "reticleDetailTextures") apply {[PARSE(_x#0), _x#1, PARSE(_x#2), _x param [3, _x#1]]};

if (BWA3_OpticReticleDetailTextures isEqualTo []) then {
    private _reticleTexture = getText (_config >> "reticleTexture");
    private _reticleTextureSize = getNumber (_config >> "reticleTextureSize");
    private _reticleTextureeNight = getText (_config >> "reticleTextureNight");

    if (_reticleTextureeNight isEqualTo "") then {
        _reticleTextureeNight = _reticleTexture;
    };

    BWA3_OpticReticleDetailTextures = [[0, _reticleTexture, _reticleTextureSize, _reticleTextureeNight]];
};

BWA3_OpticBodyTexture = getText (_config >> "bodyTexture");
BWA3_OpticBodyTextureSize = getNumber (_config >> "bodyTextureSize");
BWA3_OpticBodyTextureNight = getText (_config >> "bodyTextureNight");

if (BWA3_OpticBodyTextureNight isEqualTo "") then {
    BWA3_OpticBodyTextureNight = BWA3_OpticBodyTexture;
};

#ifdef DEBUG_BUILD
"BWA3_debugReticle" cutText ["", "PLAIN"];
if (_optic == "BWA3_optic_debug") then compile preprocessFileLineNumbers "\bwa3_optics\scripts\debug_reticle.sqf";
#endif
