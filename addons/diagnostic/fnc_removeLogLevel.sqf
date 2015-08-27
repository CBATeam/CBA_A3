/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLogLevel

Description:
    Remove a system wide named log level.

Parameters:
    _level - Numeric priority level [Number]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(removeLogLevel);

params ["_level"];

INITIALIZE_LOGLEVELS;

[GVAR(logLevels), _level] call CBA_fnc_hashRem;

nil
