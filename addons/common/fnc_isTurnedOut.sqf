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
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(isTurnedOut);

private ["_turn","_out","_vehicle","_cfg","_forceHideDriver","_phase","_assignedRole","_turretPath","_turret","_canHideGunner",
        "_forceHideGunner","_hatchAnimation","_attenuateCargo","_index"];
_turn = false;
_out = false;
params ["_unit"];
_vehicle = vehicle _unit;

_cfg = configFile >> "CfgVehicles" >> (typeOf _vehicle);
if (_vehicle != _unit) then {
    if (driver _vehicle == _unit) then {
        _forceHideDriver = getNumber(_cfg >> "forceHideDriver");
        _turn = (_forceHideDriver != 1);
        _out = (_vehicle animationPhase "hatchDriver") > 0;
    } else {
        _assignedRole = assignedVehicleRole _unit;
        if (_assignedRole select 0 == "Turret") then {
            _turretPath = _assignedRole select 1;
            _turret = [_vehicle, _turretPath] call CBA_fnc_getTurret;

            _canHideGunner = getNumber(_turret >> "canHideGunner");
            _forceHideGunner = getNumber(_turret >> "forceHideGunner");
            _turn = (_canHideGunner == 1 && _forceHideGunner == 0);

            _hatchAnimation = getText(_turret >> "animationSourceHatch");
            _out = (_vehicle animationPhase _hatchAnimation) > 0;

        } else {
            if ((_assignedRole select 0) == "Cargo") then {
                _attenuateCargo = getArray(_cfg >> "soundAttenuationCargo");
                if ((count _attenuateCargo) > 0) then {
                    _index = (count _attenuateCargo)-1; // wait for command to get cargo index

                    if (_index > -1) then {
                        if(_index > (count _attenuateCargo)-1) then {
                            _index = (count _attenuateCargo)-1;
                        };
                        if((_attenuateCargo select _index) == 0) then {
                            _out = true;
                        };
                    };
                };
            };
        };
    };
} else {
    _out = true;
};
_out;

