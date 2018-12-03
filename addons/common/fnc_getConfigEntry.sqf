#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getConfigEntry

Description:
    Gets a configuration entry.

    Will check if _cfg exists, and will return either the config value, or
    supplied default value.

Parameters:
    _configEntry - Entry to get value of <CONFIG>
    _entryType - "STRING", "NUMBER" or "ARRAY" <STRING>
    _defaultValue - Value to return if config entry unavailable <ANY>

Returns:
    Value found [String, Number or Array]

Examples:
    (begin example)
        [configFile >> "CfgJellies" >> "Wobbliness", "NUMBER", 0] call CBA_fnc_getConfigEntry
    (end)

Author:
    Sickboy (sb_at_dev-heaven.net)
---------------------------------------------------------------------------- */
SCRIPT(getConfigEntry);

params ["_configEntry", "_entryType", "_defaultValue"];

private _return = _defaultValue;

switch (toUpper _entryType) do {
    case "STRING";
    case "TEXT": {
        if (isText _configEntry) then {
            _return = getText _configEntry;
        };
    };
    case "ARRAY": {
        if (isArray _configEntry) then {
            _return = getArray _configEntry;
        };
    };
    case "NUMBER": {
        if (isNumber _configEntry || {isText _configEntry}) then {
            _return = getNumber _configEntry;
        };
    };
};

_return
