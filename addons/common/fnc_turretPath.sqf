/* ----------------------------------------------------------------------------
Function: CBA_fnc_turretPath

Description:
    A function used to report the soldiers turret path in the current vehicle.
    Reverse version of the turretUnit scripting command.

Parameters:
    _unit - a soldier in a vehicle <OBJECT>

Example:
    (begin example)
        _turretPath = player call CBA_fnc_turretPath
    (end)

Returns:
    Soldiers turret path. [] when on foot, driver or in cargo <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(turretPath);

params [["_unit", objNull, [objNull]]];

private _vehicle = vehicle _unit;

(allTurrets [_vehicle, true] select {(_vehicle turretUnit _x) isEqualTo _unit}) param [0, []]
