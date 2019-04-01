#include "script_component.hpp"

if (!hasInterface) exitWith {};

ADDON = false;

#include "XEH_PREP.sqf"
#include "initSettings.sqf"

GVAR(camera) = objNull;
[QGVAR(camera), {!isNull GVAR(camera)}] call CBA_fnc_registerFeatureCamera;

// scripted optic data cache
GVAR(currentOptic) = "";
GVAR(ReticleAdjust) = [1,1,nil,1,1];
GVAR(HideRedDotMagnification) = 1e+11;
GVAR(FadeReticleInterval) = [0,0,nil,0,0];
GVAR(OpticReticleDetailTextures) = [];
GVAR(OpticBodyTexture) = "";
GVAR(OpticBodyTextureNight) = "";

["weapon", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
}] call CBA_fnc_addPlayerEventHandler;

["loadout", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);

    //_unit call BWA3_fnc_changeCarryHandleOpticClass;
}] call CBA_fnc_addPlayerEventHandler;










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
    [FUNC(restartCamera), [[] call CBA_fnc_currentUnit, true]] call CBA_fnc_execNextFrame;
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
