#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Internal Function: CBA_diagnostic_fnc_watchStart

Description:
    Start watching an input

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

params ["_index"];

diag_log format ["CBA_diagnostic: Starting watch for input %1", _index];

private _statement = GVAR(watchStatements) select _index;
if (_statement isEqualTo "") exitWith {};

[_index] call CBA_diagnostic_fnc_watchStop;
private _ctrl = findDisplay 46 ctrlCreate [QGVAR(watchedInput), 1000 + IDC_DEBUGCONSOLE_WATCHINPUT_1 + _index];
_ctrl ctrlSetPosition [safeZoneX, (safeZoneH / 3) + (_index * (2.5 * GUI_GRID_H)), 1 / 3 * safeZoneW, 2 * GUI_GRID_H];
_ctrl ctrlCommit 0;
GVAR(watchControls) set [_index, _ctrl];
