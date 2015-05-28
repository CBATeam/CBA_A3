/* ----------------------------------------------------------------------------
Function: CBA_fnc_inheritsFrom

Description:
    Checks whether a config entry inherits, directly or indirectly, from another
    one.

    For objects, it is probably simpler to use the *isKindOf* command.

Parameters:
    _config - Class to check if it is a descendent of _baseConfig [Config]
    _baseConfig - Ancestor config class [Config]

Returns:
    true if _config is a decendent of _baseConfig [Boolean]

Examples:
    (begin example)
        _rifle = configFile >> "CfgWeapons" >> "m16a4_acg_gl";
        _baseRifle = configFile >> "CfgWeapons" >> "RifleCore";
        _inherits = [_rifle, _baseRifle] call CBA_fnc_inheritsFrom;
        // => true in this case, since all rifles are descended from RifleCore.
    (end)

Author:
    Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(inheritsFrom);

PARAMS_2(_config,_baseConfig);

private "_valid";
_valid = false;

while { (configName _config) != "" } do {
    _config = inheritsFrom _config;
    if (_config == _baseConfig) exitWith { _valid = true };
};

_valid;
