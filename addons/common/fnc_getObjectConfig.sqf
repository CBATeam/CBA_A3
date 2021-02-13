#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getObjectConfig

Description:
    A function used to return the config of an object or class name.

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
    commy2
---------------------------------------------------------------------------- */
SCRIPT(getObjectConfig);

params [["_object", "", ["", objNull]]];

if (_object isEqualType objNull) exitWith {
    configOf _object
};

private _result = configNull;

{
    private _config = configFile >> _x >> _object;

    if (isClass _config) exitWith {
        _result = _config;
    };
} forEach ["CfgVehicles", "CfgAmmo", "CfgNonAIVehicles"];

_result
