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

params ["_configEntry", "_entryType", "_defaultValue"];

private _r = _defaultValue;

switch (toLower _entryType) do {
    case "text": {
        if (isText _configEntry) then {
            _r = getText _configEntry;
        };
    };
    case "array": {
        if (isArray _configEntry) then {
            _r = getArray _configEntry;
        };
    };
    case "number": {
        if (isNumber _configEntry) then {
            _r = getNumber _configEntry;
        };
    };
};

_r
