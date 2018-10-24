#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
    Checks whether a unit is turned out in a vehicle or not.

Parameters:
    _unit - Unit to check <OBJECT>

Returns:
    "true" for turned out or "false" for not turned out <BOOL>
    Cargo in exposed vehicles are "turned out" if they lack a
    cargoSoundAttenuation matching index. Do NOT assume that because
    this function returns false that the unit is generally exposed.

Examples:
    (begin example)
        if (player call CBA_fnc_isTurnedOut) then {
            player sideChat "I am turned out!";
        };
    (end)

Author:
    shukari
---------------------------------------------------------------------------- */
params ["_unit"];

if (isNull objectParent _unit) exitWith {true};
if (isTurnedOut _unit) exitWith {true};

private _vehicle = vehicle _unit;
private _config = configFile >> "CfgVehicles" >> typeOf _vehicle;
private _attenuationType = getText (_config >> "attenuationEffectType");
if (_attenuationType in ["OpenCarAttenuation", "OpenHeliAttenuation"]) exitWith {true};

private _fullCrew = fullCrew [_vehicle, ""];
(_fullCrew select (_fullCrew findIf {_unit == _x select 0})) params ["", "_role", "_cargoIndex", "_turretPath", "_isFFV"];
_role = toLower _role;

// special condition for RHS car windows
if (_vehicle isKindOf "rhsusf_m1025_w" && {_role in ["driver", "turret"]}) then {
    //will override _isFFV if window is closed
    _isFFV = _vehicle doorPhase (["ani_window_1", "ani_window_2", "ani_window_4"] param [_cargoIndex + 1, "ani_window_3"]) > 0
};

// FFVs are always outside
if (_isFFV) exitWith {true};

if (_role in ["gunner", "turret"]) exitWith {
    private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;

    private _gunnerAction = getText (_turret >> "gunnerAction");
    private _hatchAnimation = getText (_turret >> "animationSourceHatch");

    _vehicle animationPhase _hatchAnimation > 0 || {animationState _unit == _gunnerAction} // return
};

private _attenuateCargo = getArray (_config >> "soundAttenuationCargo");

if (_role isEqualTo "driver") exitWith {
    // if _attenuateCargo = [0] the vehicle is all open
    _vehicle animationPhase "hatchDriver" > 0 || {_attenuateCargo isEqualTo [0]} // return
};

if (_role isEqualTo "cargo") exitWith {
    // if attenuate array has less elements than the current cargo index, use the last value of the array
    private _cargoIndex = _cargoIndex min (count _attenuateCargo - 1);

    _attenuateCargo param [_cargoIndex, 1] == 0 // return
};

false
