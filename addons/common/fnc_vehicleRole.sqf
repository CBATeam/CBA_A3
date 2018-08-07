#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_vehicleRole

Description:
    Get a unit's role in its current vehicle.

    Used because assignedVehicleRole reports the role assigned by the group leader instead of the current position.

Parameters:
    _unit - a soldier in a vehicle <OBJECT>

Example:
    (begin example)
        _role = player call CBA_fnc_vehicleRole
    (end)

Returns:
    Soldiers role in the current vehicle. Can be "driver", "gunner", "commander", "Turret", or "cargo". Empty string if not in vehicle <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(vehicleRole);

params [["_unit", objNull, [objNull]]];

fullCrew vehicle _unit select {(_x select 0) isEqualTo _unit} param [0, [nil, ""]] select 1
