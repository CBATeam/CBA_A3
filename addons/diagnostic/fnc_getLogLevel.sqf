/* ----------------------------------------------------------------------------
Function: CBA_fnc_getLogLevel

Description:
    Get log level name.

Parameters:
    _level - Numeric priority level [Number]

Returns:
    Log Level Name [String]
    If no value is stored for _level, _level will be returned [Number]

Author:
    MikeMatrix
---------------------------------------------------------------------------- */
#include "script_component.hpp"

SCRIPT(getLogLevel);

private ["_result"];

params ["_level"];

INITIALIZE_LOGLEVELS;

_result = ([GVAR(logLevels), _level] call CBA_fnc_hashGet);

if (isNil "_result") then {_level} else {_result};
