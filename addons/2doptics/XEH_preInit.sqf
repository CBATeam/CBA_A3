#include "script_component.hpp"

if (!hasInterface) exitWith {};

ADDON = false;

BWA3_optics_camera = objNull;
//["bwa3_camera", {!isNull BWA3_optics_camera}] call CBA_fnc_registerFeatureCamera;

// scripted optic data cache
BWA3_currentOptic = "";
BWA3_ReticleAdjust = [1,1,nil,1,1];
BWA3_HideRedDotMagnification = 1e+11;
BWA3_FadeReticleInterval = [0,0,nil,0,0];
BWA3_OpticReticleDetailTextures = [];
BWA3_OpticBodyTexture = "";
BWA3_OpticBodyTextureScale = "";
BWA3_OpticBodyTextureNight = "";

["weapon", {_this call BWA3_fnc_updateOpticInfo}] call CBA_fnc_addPlayerEventHandler;
["loadout", {
    _this call BWA3_fnc_updateOpticInfo;

    //params ["_unit"];
    //_unit call BWA3_fnc_changeCarryHandleOpticClass;
}] call CBA_fnc_addPlayerEventHandler;

// handle PIP optics setting
[
    "BWA3_usePipOptics",
    "CHECKBOX",
    "STR_BWA3_Setting_UsePIP",
    "STR_BWA3_FactionClassBundeswehrName",
    true
] call cba_settings_fnc_init;

// swap in pip versions
["cameraView", {
    params ["_unit", "_view"];
    if (_view != "GUNNER") exitWith {};

    _unit call BWA3_fnc_changePIPOpticClass;
}] call CBA_fnc_addPlayerEventHandler;

// handle arsenal
BWA3_inArsenal = false;

private _fnc_arsenalOpened = {
    BWA3_inArsenal = true;
    call CBA_fnc_currentUnit call BWA3_fnc_changePIPOpticClass;
    //call CBA_fnc_currentUnit call BWA3_fnc_changeCarryHandleOpticClass;
};

[missionNamespace, "arsenalOpened", _fnc_arsenalOpened] call BIS_fnc_addScriptedEventHandler;
["ace_arsenal_displayOpened", _fnc_arsenalOpened] call CBA_fnc_addEventHandler;

private _fnc_arsenalClosed = {
    BWA3_inArsenal = false;
    //call CBA_fnc_currentUnit call BWA3_fnc_changeCarryHandleOpticClass;
    [BWA3_fnc_restartCamera, [[] call CBA_fnc_currentUnit, true]] call CBA_fnc_execNextFrame;
};

[missionNamespace, "arsenalClosed", _fnc_arsenalClosed] call BIS_fnc_addScriptedEventHandler;
["ace_arsenal_displayClosed", _fnc_arsenalClosed] call CBA_fnc_addEventHandler;

BWA3_PIPOptics = [] call CBA_fnc_createNamespace;
BWA3_NonPIPOptics = [] call CBA_fnc_createNamespace;

{
    private _normalOptic = configName _x;
    private _pipOptic = getText _x;

    BWA3_PIPOptics setVariable [_normalOptic, _pipOptic];

    if (isNil {BWA3_NonPIPOptics getVariable _pipOptic}) then {
        BWA3_NonPIPOptics setVariable [_pipOptic, _normalOptic];
    };
} forEach configProperties [configFile >> "BWA3_CfgPIPItems"];

/*BWA3_CarryHandleOptics = [] call CBA_fnc_createNamespace;
BWA3_NonCarryHandleOptics = [] call CBA_fnc_createNamespace;

{
    private _normalOptic = configName _x;
    private _carryHandleOptic = getText _x;

    BWA3_CarryHandleOptics setVariable [_normalOptic, _carryHandleOptic];

    if (isNil {BWA3_NonCarryHandleOptics getVariable _carryHandleOptic}) then {
        BWA3_NonCarryHandleOptics setVariable [_carryHandleOptic, _normalOptic];
    };
} forEach configProperties [configFile >> "BWA3_CfgCarryHandleOptics"];*/

ADDON = true;
