/* ----------------------------------------------------------------------------
Function: CBA_fnc_canUseWeapon

Description:
    Checks if the unit can currently use a weapon.

Parameters:
    _unit - A unit <OBJECT>

Returns:
    True if the unit is not in a vehicle or in a FFV position <BOOLEAN>

Examples:
    (begin example)
    _result = player call CBA_fnc_canUseWeapon;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(canUseWeapon);

params [["_unit", objNull, [objNull]]];

if (_unit == vehicle _unit) exitWith {true};

private _config = configFile >> "CfgMovesMaleSdr" >> "States" >> animationState _unit;

isClass _config && {getNumber (_config >> "canPullTrigger") == 1}
