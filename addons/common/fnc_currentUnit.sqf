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
#include "script_component.hpp"
SCRIPT(currentUnit);

missionNamespace getVariable ["bis_fnc_moduleRemoteControl_unit", player]
