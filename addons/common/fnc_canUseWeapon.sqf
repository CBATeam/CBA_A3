#include "script_component.hpp"
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
SCRIPT(canUseWeapon);

params [["_unit", objNull, [objNull]]];

if (isNull objectParent _unit) exitWith {true};

private _config = configFile >> "CfgMovesMaleSdr" >> "States" >> animationState _unit;

isClass _config && {getNumber (_config >> "canPullTrigger") == 1}
