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
private _cfg = configFile >> "CfgVehicles" >> (typeOf _vehicle);

if (driver _vehicle == _unit) then {
    _return = (_vehicle animationPhase "hatchDriver") > 0;
} else {
    (assignedVehicleRole _unit) params [["_position", ""], ["_turretPath", []]];
    
    if (_position == "Turret") then {
        private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;

        private _gunnerAction = getText (_turret >> "gunnerAction");
        private _hatchAnimation = getText (_turret >> "animationSourceHatch");
        
        _return = (_vehicle animationPhase _hatchAnimation) > 0 || animationState player == _gunnerAction;
    } else {
        if (_position == "Cargo") then {
            private _cargoIndex = _vehicle getCargoIndex _unit;
            private _window = ['ani_window_1', 'ani_window_2', 'ani_window_4', 'ani_window_3'] select (_cargoIndex + 1);
            if ((_vehicle doorPhase _window) > 0) exitWith {_out = true};
            
            if ([_unit] call ace_common_fnc_getTurretIndex in ([_vehicle] call ace_common_fnc_getTurretsFFV)) exitWith {_out = true};
            
            private _attenuateCargo = getArray (_cfg >> "soundAttenuationCargo");
            if !(_attenuateCargo isEqualTo []) then {
                private _count = count _attenuateCargo;
                _return = 0 == _attenuateCargo select (if (_cargoIndex >= _count) then {_count - 1} else {_cargoIndex});
            };
        };
    };
};

_return;
