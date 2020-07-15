#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getObjectConfig

Description:
    A function used to return the config of an object or class name.
    Result is cached in object variable "CBA_config" for quicker access in future.

Parameters:
    _object - Any kind of object or class name <STRING, OBJECT>

Returns:
    _result - Objects config. <CONFIG>

Example:
    (begin example)
        _config = player call CBA_fnc_getObjectConfig;
        typeOf cameraOn call CBA_fnc_getObjectConfig;
        [_projectile] call CBA_fnc_getObjectConfig;
    (end)

Author:
    commy2, kuloodporny
---------------------------------------------------------------------------- */
SCRIPT(getObjectConfig);

params [["_object", "", ["", objNull]]];

private _result = configNull;

if (_object isEqualType objNull) exitWith {
    _result = _object getVariable "CBA_config";

    if (isNil "_result") then {
        _result = typeOf _object call CBA_fnc_getObjectConfig;
        _object setVariable ["CBA_config", _result];
    };

    _result
};

if (_object isEqualTo "") exitWith {_result};

{
    private _config = configFile >> _x >> _object;

    if (isClass _config) exitWith {
        _result = _config;
    };
} forEach ["CfgVehicles", "CfgAmmo", "CfgNonAIVehicles"];

_result
