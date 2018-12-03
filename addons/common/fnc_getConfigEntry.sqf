#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getConfigEntry

Description:
    Gets a configuration entry.

    Will check if _cfg exists, and will return either the config value, or
    supplied default value.

Parameters:
    _configEntry  - Entry to get value of <CONFIG>
    _entryType    - "STRING", "NUMBER" or "ARRAY" <STRING>
    _defaultValue - Value to return if config entry unavailable <ANY>

Returns:
    Value found <STRING, NUMBER or ARRAY>

Examples:
    (begin example)
        [configFile >> "CfgJellies" >> "Wobbliness", "NUMBER", 0] call CBA_fnc_getConfigEntry
    (end)

Author:
    Sickboy (sb_at_dev-heaven.net)
---------------------------------------------------------------------------- */
SCRIPT(getConfigEntry);

params ["_configEntry", "_entryType", "_defaultValue"];

if (toUpper _entryType in ["STRING", "TEXT"]) exitWith {
    if (isText _configEntry) then {
        getText _configEntry // return
    } else {
        _defaultValue // return
    };
};

if (_entryType == "ARRAY") exitWith {
    if (isArray _configEntry) then {
        getArray _configEntry // return
    } else {
        _defaultValue // return
    };
};

if (_entryType == "ARRAY") exitWith {
    if (isNumber _configEntry || {isText _configEntry}) then {
        getNumber _configEntry // return
    } else {
        _defaultValue // return
    };
};

_defaultValue
