#include "script_component.hpp"

ADDON = false;

#include "initSettings.sqf"

if (configProperties [configFile >> "CBA_PIPItems"] isEqualTo [] && {
    configProperties [configFile >> "CBA_CarryHandleTypes"] isEqualTo []
}) exitWith {};

#include "XEH_PREP.sqf"

if (!hasInterface) exitWith {};

#include "initKeybinds.sqf"

QGVAR(pauseOpticLayer) cutText ["", "PLAIN"];

GVAR(camera) = objNull;
//[QGVAR(camera), {!isNull GVAR(camera)}] call CBA_fnc_registerFeatureCamera;

// scripted optic data cache
GVAR(currentOptic) = "";
GVAR(IsUsingOptic) = false;
GVAR(magnificationCache) = -1;
GVAR(ReticleAdjust) = [1,1,nil,1,1];
GVAR(HideRedDotMagnification) = 1e+11;
GVAR(FadeReticleInterval) = [0,0,nil,0,0];
GVAR(OpticReticleDetailTextures) = [];
GVAR(OpticBodyTexture) = "";
GVAR(OpticBodyTextureNight) = "";
GVAR(ppEffects) = [];
GVAR(manualReticleNightSwitch) = false;
GVAR(useReticleNight) = false;

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

["vehicle", {
    params ["_unit"];
    _unit call FUNC(updateOpticInfo);
}] call CBA_fnc_addPlayerEventHandler;

[QGVAR(UsingOptic), {
    params ["_display", "_isUsingOptic"];
    if (_isUsingOptic) then {
        // Switch to pip class.
        private _unit = call CBA_fnc_currentUnit;
        _unit call FUNC(changePIPOpticClass);

        // Restore previous magnification.
        if (GVAR(magnificationCache) > 0) then {
            [_unit, GVAR(magnificationCache)] call FUNC(setOpticMagnification);
        };
    };
}] call CBA_fnc_addEventHandler;

["featureCamera", {
    params ["_unit", "_camera"];
    [_unit, _camera isEqualTo ""] call FUNC(restartCamera);
}] call CBA_fnc_addPlayerEventHandler;

["CAManBase", "Fired", FUNC(animateScriptedOpticRecoil)] call CBA_fnc_addClassEventHandler;

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
} forEach configProperties [configFile >> "CBA_PIPItems", "isText _x"];

GVAR(CarryHandleOptics) = [] call CBA_fnc_createNamespace;
GVAR(NonCarryHandleOptics) = [] call CBA_fnc_createNamespace;

{
    private _carryHandleType = configName _x;

    {
        private _normalOptic = configName _x;
        private _carryHandleOptic = getText _x;

        GVAR(CarryHandleOptics) setVariable [format ["%1@%2", _normalOptic, _carryHandleType], _carryHandleOptic];

        if (isNil {GVAR(NonCarryHandleOptics) getVariable _carryHandleOptic}) then {
            GVAR(NonCarryHandleOptics) setVariable [_carryHandleOptic, _normalOptic];
        };
    } forEach configProperties [_x, "isText _x"];
} forEach ("true" configClasses (configFile >> "CBA_CarryHandleTypes"));

ADDON = true;
