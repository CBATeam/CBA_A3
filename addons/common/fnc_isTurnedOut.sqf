/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
    Checks whether a unit is turned out in a vehicle or not.
    Turned out means out of a hatch or something similar.

Parameters:
    _unit - Unit to check <OBJECT>

Returns:
    true if turned out, false otherwise <BOOL>

Examples:
    (begin example)
        _isTurnedOut = [player] call CBA_fnc_isTurnedOut;
    (end)

Author:
    shukari
---------------------------------------------------------------------------- */
params ["_unit"];

if (isNull objectParent _unit) exitWith {false};
if (isTurnedOut _unit) exitWith {true};

private _vehicle = vehicle _unit;
private _fullCrew = fullCrew _vehicle;
(_fullCrew select (_fullCrew findIf {_unit isEqualTo (_x param [0, objNull])})) params ["", "_role", "", "_turretPath"];
_role = toLower _role;
private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;
private _hatchAnimation = getText (_turret >> "animationSourceHatch");

if (_role in ["gunner", "turret"]) exitWith {
    _vehicle animationPhase _hatchAnimation > 0 // return
};

if (_role isEqualTo "driver") exitWith {
    _vehicle animationPhase "hatchDriver" > 0 // return
};

if (_role isEqualTo "commander") exitWith {
    _vehicle animationPhase _hatchAnimation > 0 // return
};

false
