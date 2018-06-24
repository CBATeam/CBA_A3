#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getConfigEntry

Description:
    Gets a configuration entry.

    Will check if _cfg exists, and will return either the config value, or
    supplied default value.

Parameters:
    _configEntry - Entry to get value of [Config]
    _entryType - "text", "number" or "array" [String]
    _defaultValue - Value to return if config entry unavailable [Any]

Returns:
    Value found [String, Number or Array]

Examples:
    (begin example)
        [configFile >> "CfgJellies" >> "Wobbliness", "number", 0] call _f
    (end)

Author:
    Sickboy (sb_at_dev-heaven.net)
---------------------------------------------------------------------------- */
SCRIPT(getConfigEntry);

private ["_r"];
switch (toLower(_this select 1)) do {
    case "text": {
        if (isText (_this select 0)) then {
            _r = getText (_this select 0);
        };
    };
    case "array": {
        if (isArray (_this select 0)) then {
            _r = getArray (_this select 0);
        };
    };
    case "number": {
        if (isNumber (_this select 0)) then {
            _r = getNumber (_this select 0);
        };
    };
};

if (isNil "_r") then { _r = _this select 2 };

_r
