#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
    Checks whether a unit is turned out in a vehicle or not.

Parameters:
    _unit - Unit to check [Object]

Returns:
    "true" for turned out or "false" for not turned out [Boolean]
    Cargo in exposed vehicles are "turned out" if they lack a
    cargoSoundAttenuation matching index. Do NOT assume that because
    this function returns false that the unit is generally exposed.

    For example, ATVs will return false, even though they are "turned
    out".

Examples:
    (begin example)
    if ( [player] call CBA_fnc_isTurnedOut ) then
    {
        player sideChat "I am turned out!";
    };
    (end)

Author:
    Nou, courtesy of ACRE project.
    shukari
---------------------------------------------------------------------------- */
SCRIPT(isTurnedOut);

params ["_unit"];

if (isNull objectParent _unit) exitWith {true};
if (isTurnedOut _unit) exitWith {true};

private _return = false;
private _vehicle = vehicle _unit;
private _role = _unit call CBA_fnc_vehicleRole;

// FFVs are allways outside
if ([_unit] call ace_common_fnc_getTurretIndex in ([_vehicle] call ace_common_fnc_getTurretsFFV)) then {_return = true};

// Spezial condition for RHS car windows
if (_vehicle isKindOf "rhsusf_m1025_w" && {_role in ["driver", "Turret"]}) then {
    private _cargoIndex = (_vehicle getCargoIndex _unit) min 2;
    private _window = ['ani_window_1', 'ani_window_2', 'ani_window_4', 'ani_window_3'] select (_cargoIndex + 1);
    _return = (_vehicle doorPhase _window) > 0;
};
if (_return) exitWith {_return}; // return

if (_role == "driver") exitWith {
    // if _attenuateCargo = [0] the vehicle is all open
    private _attenuateCargo = getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "soundAttenuationCargo");

    (_vehicle animationPhase "hatchDriver") > 0 || {_attenuateCargo isEqualTo [0]}; // return
};

if (_role in ["Turret", "gunner"]) exitWith {
    private _turret = [_vehicle, _unit call CBA_fnc_turretPath] call CBA_fnc_getTurret;

    private _gunnerAction = getText (_turret >> "gunnerAction");
    private _hatchAnimation = getText (_turret >> "animationSourceHatch");
    
    (_vehicle animationPhase _hatchAnimation) > 0 || {animationState player == _gunnerAction}; // return
};

if (_role == "cargo") exitWith {
    private _attenuateCargo = getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "soundAttenuationCargo");
    if !(_attenuateCargo isEqualTo []) then {
        _return = (_attenuateCargo select ((_vehicle getCargoIndex _unit) min (count _attenuateCargo - 1))) == 0;
    };
    
    _return;
};

_return;
