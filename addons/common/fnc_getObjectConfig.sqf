#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getObjectConfig

Description:
    A function used to return the config of an object or class name.
    Result is cached in object variable "CBA_config" for quicker access in future.

Parameters:
    _object - Any kind of object or class name <STRING, OBJECT>

Returns:
    _config - Objects config. <CONFIG>

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

private _isObject = _object isEqualType objNull;
private _result = configNull;
if _isObject then {
    _result = _object getVariable ["CBA_config", configNull];
};

// Cached value has been found
if (isClass _result) exitWith {_result};

// Convert object to classname to be found if needed
private _className = _object;
if _isObject then {
    _className = typeOf _object;
};

// Invalid class
if (count _className == 0) exitWith {_result};

{
    private _config = configFile >> _x >> _className;

    if (isClass _config) exitWith {
        _result = _config;
    };
} forEach ["CfgVehicles", "CfgAmmo", "CfgNonAIVehicles"];

// Cache result for future use, if object supports it
if _isObject then {_object setVariable ["CBA_config", _result]};

_result
