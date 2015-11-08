/* ----------------------------------------------------------------------------
Function: CBA_fnc_addLogLevelDescriptor

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

SCRIPT(addLogLevelDescriptor);

private "_index";

params ["_name", "_level"];

INITIALIZE_LOGLEVELDESCRIPTORS;

_index = GVAR(logLevelDescriptors) select 0 find _level;
if (_index <= -1) exitWith {
    GVAR(logLevelDescriptors) select 0 pushBack _level;
    GVAR(logLevelDescriptors) select 1 pushBack _name;
};

GVAR(logLevelDescriptors) set [_index, _name];

nil
