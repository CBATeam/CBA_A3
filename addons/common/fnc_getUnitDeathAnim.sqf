/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUnitDeathAnim

Description:
    Get death animation for a unit.

Parameters:
    _unit - the unit to get the death animation for. [Object]

Returns:
    _deathAnim - the name of the animation. [String]

Examples:
    (begin example)
    _anim = player call CBA_fnc_getUnitDeathAnim;
    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(getUnitDeathAnim);

params ["_unit"];

private _deathAnim = "";
private _curAnim = (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _unit));

if (isText (_curAnim >> "actions")) then {
    if (vehicle _unit == _unit) then {
        private _deathAnimCfg = (configFile >> "CfgMovesBasic" >> "Actions" >> (getText (_curAnim >> "actions")) >> "die");
        if (isText _deathAnimCfg) then {
            _deathAnim = getText _deathAnimCfg;
        };
    } else {
        private _deathAnimCfg = (configFile >> "CfgMovesMaleSdr" >> "States" >> (animationState _unit));
        if (isArray (_deathAnimCfg >> "interpolateTo")) then {
            _deathAnim = getArray (_deathAnimCfg >> "interpolateTo") select 0;
        };
    };
};

_deathAnim
