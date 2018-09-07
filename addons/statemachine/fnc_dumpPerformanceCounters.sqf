#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_statemachine_fnc_dumpPerformanceCounters

Description:
    Dumps the performance counters for each statemachine
    Requires `STATEMACHINE_PERFORMANCE_COUNTERS` in script_component.hpp
    Note that diag_tickTime has very limited precision; results may become more accurate with longer test runtime.

Parameters:
    Nothing

Returns:
    Nothing

Examples:
    (begin example)
        [] call CBA_statemachine_fnc_dumpPerformanceCounters;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

#ifndef STATEMACHINE_PERFORMANCE_COUNTERS
if (true) exitWith {WARNING("Requires `STATEMACHINE_PERFORMANCE_COUNTERS` in script_component.hpp");};
#endif

diag_log text format ["CBA State Machine Results:"];
diag_log text format ["------------------ [Time: %1] -------------------------", CBA_missionTime toFixed 1];

{
    // _x is an array of small individual run times from FUNC(clockwork)
    private _stateMachineID = _forEachIndex;
    private _count = count _x;
    private _sum = 0;
    {
        _sum = _sum + _x;
    } forEach _x;
    private _averageResult = if (_count > 0) then {1000 * _sum / _count} else {0};

    private _status = "*Removed*";
    {
        private _xId = _x getVariable QGVAR(ID);
        if (_stateMachineID == _xId) exitWith {_status = name _x;};
    } forEach GVAR(stateMachines);

    diag_log text format ["%1: [%2] Average: %3 ms [%4s / %5]", _stateMachineID, _status, _averageResult toFixed 3, _sum toFixed 3, _count];
} forEach GVAR(performanceCounters);
