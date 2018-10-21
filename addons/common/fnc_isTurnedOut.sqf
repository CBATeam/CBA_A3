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
    private _assignedRole = assignedVehicleRole _unit;
    if (_assignedRole select 0 == "Turret") then {
        private _turretPath = _assignedRole select 1;
        private _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;

        private _gunnerAction = getText (_turret >> "gunnerAction");
        private _hatchAnimation = getText(_turret >> "animationSourceHatch");
        
        _return = (_vehicle animationPhase _hatchAnimation) > 0 || animationState player == _gunnerAction;
    } else {
        if ((_assignedRole select 0) == "Cargo") then {
            private _attenuateCargo = getArray (_cfg >> "soundAttenuationCargo");
            if ((count _attenuateCargo) > 0) then {
                private _index = (count _attenuateCargo) - 1; // wait for command to get cargo index

                if (_index > -1) then {
                    if (_index > (count _attenuateCargo) - 1) then {
                        _index = (count _attenuateCargo) - 1;
                    };
                    if ((_attenuateCargo select _index) == 0) then {
                        _return = true;
                    };
                };
            };
        };
    };
};

_return;
