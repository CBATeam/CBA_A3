#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
    Checks whether a unit is turned out in a vehicle or not.

Parameters:
    _unit - Unit to check <Object>

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
private _role = toLower (_unit call CBA_fnc_vehicleRole);
private _isFFV = fullCrew [_vehicle, "turret"] findIf {_x select 0 == _unit && {_x select 4}} != -1;

// FFVs are allways outside
if (_isFFV) exitWith {true};

// special condition for RHS car windows
if (_vehicle isKindOf "rhsusf_m1025_w" && {_role in ["driver", "turret"]}) then {
    switch (_vehicle getCargoIndex _unit) do {
        case -1: { // not in cargo
            _vehicle doorPhase "ani_window_1" > 0 // return
        };
        case 0: { // cargo position 0
            _vehicle doorPhase "ani_window_2" > 0 // return
        };
        case 1: { // cargo position 1
            _vehicle doorPhase "ani_window_4" > 0 // return
        };
        default { // any other cargo position
            _vehicle doorPhase "ani_window_3" > 0 // return
        };
    };
};

if (_role isEqualTo "driver") exitWith {
    // if _attenuateCargo = [0] the vehicle is all open
    private _attenuateCargo = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "soundAttenuationCargo");

    _vehicle animationPhase "hatchDriver" > 0 || {_attenuateCargo isEqualTo [0]} // return
};

if (_role in ["gunner", "turret"]) exitWith {
    private _turret = [_vehicle, _unit call CBA_fnc_turretPath] call CBA_fnc_getTurret;

    private _gunnerAction = getText (_turret >> "gunnerAction");
    private _hatchAnimation = getText (_turret >> "animationSourceHatch");

    _vehicle animationPhase _hatchAnimation > 0 || {animationState _unit == _gunnerAction} // return
};

if (_role isEqualTo "cargo") exitWith {
    private _attenuateCargo = getArray (configFile >> "CfgVehicles" >> typeOf _vehicle >> "soundAttenuationCargo");

    // if attenuate array has less elements than the current cargo index, use the last value of the array
    private _cargoIndex = (_vehicle getCargoIndex _unit) min (count _attenuateCargo - 1);

    _attenuateCargo param [_cargoIndex, 1] == 0 // return
};

false
