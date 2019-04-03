#include "script_component.hpp"

#include "initSettings.sqf"

if (getNumber (configFile >> "CBA_useScriptedOpticsFramework") != 1) exitWith {};
if (!hasInterface) exitWith {};

ADDON = false;

#include "XEH_PREP.sqf"

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

// Update optic info.
["weapon", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
}] call CBA_fnc_addPlayerEventHandler;

["loadout", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
    _unit call FUNC(changeCarryHandleOpticClass);
}] call CBA_fnc_addPlayerEventHandler;

// Switch to pip class.
["cameraView", {
    params ["_unit", "_view"];
    if (_view isEqualTo "GUNNER") then {
        _unit call FUNC(changePIPOpticClass);
    };
}] call CBA_fnc_addPlayerEventHandler;

["CAManBase", "Fired", FUNC(animateOpticRecoil)] call CBA_fnc_addClassEventHandler;

// Handle Arsenal: Switch back to normal classes.
GVAR(inArsenal) = false;

[QGVAR(arsenalOpened), {
    GVAR(inArsenal) = true;
    private _unit = call CBA_fnc_currentUnit;
    _unit call FUNC(changePIPOpticClass);
    _unit call FUNC(changeCarryHandleOpticClass);
}] call CBA_fnc_addEventHandler;

[missionNamespace, "arsenalOpened", {
    isNil {
        QGVAR(arsenalOpened) call CBA_fnc_localEvent;
    };
}] call BIS_fnc_addScriptedEventHandler;

[QGVAR(arsenalClosed), {
    GVAR(inArsenal) = false;
    private _unit = call CBA_fnc_currentUnit;
    _unit call FUNC(changeCarryHandleOpticClass);
    [FUNC(restartCamera), [_unit, true]] call CBA_fnc_execNextFrame;
}] call CBA_fnc_addEventHandler;

[missionNamespace, "arsenalClosed", {
    isNil {
        QGVAR(arsenalClosed) call CBA_fnc_localEvent;
    };
}] call BIS_fnc_addScriptedEventHandler;

// Link classes by config.
GVAR(PIPOptics) = [] call CBA_fnc_createNamespace;
GVAR(NonPIPOptics) = [] call CBA_fnc_createNamespace;

{
    private _normalOptic = configName _x;
    private _pipOptic = getText _x;

    GVAR(PIPOptics) setVariable [_normalOptic, _pipOptic];

    if (isNil {GVAR(NonPIPOptics) getVariable _pipOptic}) then {
        GVAR(NonPIPOptics) setVariable [_pipOptic, _normalOptic];
    };
} forEach configProperties [configFile >> "CBA_CfgPIPItems"];

GVAR(CarryHandleOptics) = [] call CBA_fnc_createNamespace;
GVAR(NonCarryHandleOptics) = [] call CBA_fnc_createNamespace;

{
    private _normalOptic = configName _x;
    private _carryHandleOptic = getText _x;

    GVAR(CarryHandleOptics) setVariable [_normalOptic, _carryHandleOptic];

    if (isNil {GVAR(NonCarryHandleOptics) getVariable _carryHandleOptic}) then {
        GVAR(NonCarryHandleOptics) setVariable [_carryHandleOptic, _normalOptic];
    };
} forEach configProperties [configFile >> "CBA_CfgCarryHandleOptics"];

ADDON = true;
