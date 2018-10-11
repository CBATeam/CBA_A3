#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_currentUnit

Description:
    Returns the controlled unit. ("player" or remote controlled unit via zeus)

Parameters:
    None

Returns:
    Currently controlled unit <OBJECT>

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(currentUnit);

private _unit = missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player];

private _uav = getConnectedUAV _unit;
if (isNull _uav) exitWith {_unit};

private _temp = UAVControl _uav;
_temp = _temp param [(_temp find _unit) + 1];

if (_temp isEqualTo "DRIVER") exitWith {driver _uav};
if (_temp isEqualTo "GUNNER") exitWith {gunner _uav};
_unit
