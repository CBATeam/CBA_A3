/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVehicleRole

Description:
    A function used to report the soldiers role in his current vehicle.
    Used because assignedVehicleRole reports the role assigned by the group leader instead of the current position.

Parameters:
    _unit - a soldier in a vehicle <OBJECT>

Example:
    (begin example)
        _role = player call CBA_fnc_getVehicleRole
    (end)

Returns:
    Soldiers role in the current vehicle. Can be "driver", "gunner", "commander", "Turret", or "cargo". Empty string if not in vehicle <STRING>

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(getVehicleRole);

params [["_unit", objNull, [objNull]]];

fullCrew vehicle _unit select {(_x select 0) isEqualTo _unit} param [0, [nil, ""]] select 1
