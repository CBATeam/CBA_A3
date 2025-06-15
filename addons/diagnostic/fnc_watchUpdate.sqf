#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_watchStart

Description:
    Updates the currently displayed watch controls with the latest values.

Parameters:
    _index - The index in the watch list

Returns:
    nil

Examples:
    (begin example)
        [1] call CBA_diagnostic_fnc_watchStart;
    (end)

Author:
    Brett Mayson
---------------------------------------------------------------------------- */

{
    if (isNull _x) then { continue };
    private _statement = GVAR(watchStatements) select _forEachIndex;
    if (_statement isEqualTo "") then {
        [_forEachIndex] call CBA_diagnostic_fnc_watchStop;
        continue;
    };
    (allControls _x) params ["", "_ctrlExpression", "_ctrlResult"];
    _ctrlExpression ctrlSetText (_statement select 0);
    _ctrlResult ctrlSetText format ["%1", (0 call (_statement select 1))];
} forEach (GVAR(watchControls));
