/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeLogLevelDescriptor

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

SCRIPT(removeLogLevelDescriptor);

params ["_level"];

INITIALIZE_LOGLEVELDESCRIPTORS;

_index = GVAR(logLevelDescriptors) select 0 find _level;

if (_index <= -1) exitWith {};

GVAR(logLevelDescriptors) select 0 deleteAt _index;
GVAR(logLevelDescriptors) select 1 deleteAt _index;

nil
