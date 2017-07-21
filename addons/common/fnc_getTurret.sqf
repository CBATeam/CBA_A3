/* ----------------------------------------------------------------------------
Function: CBA_fnc_getTurret

Description:
    A function used to find out which config turret is turretpath.

Parameters:
    _vehicle    - Vehicle or vehicle class name or vehicle config <STRING, OBJECT, CONFIG>
    _turretPath - Turret path <ARRAY>

Example:
    (begin example)
    _config = [vehicle player, [0]] call CBA_fnc_getTurret
    (end)

Returns:
    Turret Config entry

Author:
    Sickboy, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getTurret);

params [["_config", "", ["", objNull, configNull]], ["_turretPath", [], [[]]]];

if (_config isEqualType objNull) then {
    _config = typeOf _config;
};

if (_config isEqualType "") then {
    _config = configFile >> "CfgVehicles" >> _config;
};

// this is used by BI to indicate "driver turrets"
if (_turretPath isEqualTo [-1]) exitWith {_config};

{
    if (_x < 0) exitWith {
        _config = configNull;
    };

    // config classes ignores inherited classes, just like the engine does with turrets
    _config = ("true" configClasses (_config >> "turrets")) param [_x, configNull];
} forEach _turretPath;

_config
