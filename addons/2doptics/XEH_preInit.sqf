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

// update optic info
["weapon", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
}] call CBA_fnc_addPlayerEventHandler;

["loadout", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
    //_unit call FUNC(changeCarryHandleOpticClass);
}] call CBA_fnc_addPlayerEventHandler;

// switch to pip class
["cameraView", {
    params ["_unit", "_view"];
    if (_view isEqualTo "GUNNER") then {
        _unit call FUNC(changePIPOpticClass);
    };
}] call CBA_fnc_addPlayerEventHandler;

// handle arsenal
GVAR(inArsenal) = false;

private _fnc_arsenalOpened = {
    GVAR(inArsenal) = true;
    private _unit = call CBA_fnc_currentUnit;
    _unit call FUNC(changePIPOpticClass);
    //_unit call FUNC(changeCarryHandleOpticClass);
};

[missionNamespace, "arsenalOpened", _fnc_arsenalOpened] call BIS_fnc_addScriptedEventHandler;
["ace_arsenal_displayOpened", _fnc_arsenalOpened] call CBA_fnc_addEventHandler; // @todo, move to ACE

private _fnc_arsenalClosed = {
    GVAR(inArsenal) = false;
    private _unit = call CBA_fnc_currentUnit;
    //_unit call FUNC(changeCarryHandleOpticClass);
    [FUNC(restartCamera), [_unit, true]] call CBA_fnc_execNextFrame;
};

[missionNamespace, "arsenalClosed", _fnc_arsenalClosed] call BIS_fnc_addScriptedEventHandler;
["ace_arsenal_displayClosed", _fnc_arsenalClosed] call CBA_fnc_addEventHandler; // @todo, move to ACE





// link classes by config
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
