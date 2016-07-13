/* ----------------------------------------------------------------------------
Function: CBA_fnc_turretPathWeapon

Description:
    Get the turret path belonging to a weapon of given vehicle.

    Reverse version of the weaponsTurret scripting command.

Parameters:
    _vehicle - a vehicle with turrets <OBJECT>
    _weapon  - a weapon in the vehicles turret <STRING>

Example:
    (begin example)
        _turretPath = [cameraOn, "HMG_127_mbt"] call CBA_fnc_turretPathWeapon
    (end)

Returns:
    Weapons turret path. [-1] for driver weapon. [] when weapon not found. <ARRAY>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(turretPathWeapon);

params [["_vehicle", objNull, [objNull]], ["_weapon", "", [""]]];

private _turrets = allTurrets _vehicle;
_turrets pushBack [-1];

(_turrets select {{_x == _weapon} count (_vehicle weaponsTurret _x) > 0}) param [0, []]
