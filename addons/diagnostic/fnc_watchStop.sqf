#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_watchStop

Description:
    Stop watching an input

Parameters:
    _index - The index in the watch list

Returns:
    nil

Examples:
    (begin example)
        [1] call CBA_diagnostic_fnc_watchStop;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

params ["_index"];

private _ctrl = GVAR(watchControls) select _index;
if (!isNull _ctrl) then {
    ctrlDelete _ctrl;
    GVAR(watchControls) set [_index, controlNull];
};
