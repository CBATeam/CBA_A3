/* ----------------------------------------------------------------------------
Function: CBA_fnc_getLogLevelDescriptor

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

SCRIPT(getLogLevelDescriptor);

private ["_result", "_index"];

params ["_level"];

INITIALIZE_LOGLEVELDESCRIPTORS;

_index = GVAR(logLevelDescriptors) select 0 find _level;

if (_index <= -1) exitWith {_level};

_result = GVAR(logLevelDescriptors) select 1 select _index;

if (isNil "_result") then {_level} else {_result};
