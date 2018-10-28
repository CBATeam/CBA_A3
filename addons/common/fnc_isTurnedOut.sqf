#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut
Description:
    Checks whether a unit is turned out in a vehicle or not.

Parameters:
    _unit - Unit to check <OBJECT>

Returns:
    true - for turned out <BOOL>
    Turned out means out of a hatch or something similar.

Examples:
    (begin example)
        if ([player] call CBA_fnc_isTurnedOut) then {
            player sideChat "I am turned out of my commander hatch!";
        };
    (end)

Author:
    shukari
---------------------------------------------------------------------------- */
params ["_unit"];

if (isNull objectParent _unit) exitWith {true};
if (isTurnedOut _unit) exitWith {true};

private _vehicle = vehicle _unit;
private _fullCrew = fullCrew _vehicle;
(_fullCrew select (_fullCrew findIf {_unit == _x select 0})) params ["", "_role", "", "_turretPath"];
_role = toLower _role;
private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;
private _hatchAnimation = getText (_turret >> "animationSourceHatch");

if (_role in ["gunner", "turret"]) exitWith {
    _vehicle animationPhase _hatchAnimation > 0 || {animationState _unit == getText (_turret >> "gunnerAction")} // return
};

if (_role isEqualTo "driver") exitWith {
    _vehicle animationPhase "hatchDriver" > 0 // return
};

if (_role isEqualTo "commander") exitWith {
    _vehicle animationPhase _hatchAnimation > 0 // return
};

false