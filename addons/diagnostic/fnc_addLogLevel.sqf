/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLogLevel

Description:
    Add a system wide named log level.

Parameters:
    _name - Name of the log level [String]
    _level - Numeric priority level [Number]

Returns:
    nil

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(addLogLevel);

params ["_name", "_level"];

INITIALIZE_LOGLEVELS;

[GVAR(logLevels), _level, _name] call CBA_fnc_hashSet;

nil
