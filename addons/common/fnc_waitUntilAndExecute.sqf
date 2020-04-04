#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_waitUntilAndExecute

Description:
    Executes a code once in unscheduled environment after a condition is true.
    It's also possible to add a timeout >= 0, in which case a different code is executed.
    Then it will be waited until _timeout time has elapsed or _condition evaluates to true.

Parameters:
    _condition   - The function to evaluate as condition. <CODE>
    _statement   - The function to run once the condition is true. <CODE>
    _args        - Parameters passed to the functions (statement and condition) executing. (optional) <ANY>
    _timeout     - If >= 0, timeout for the condition in seconds.  If < 0, no timeout.
                   Exactly 0 means timeout immediately on the next iteration.(optional, default -1) <NUMBER>
    _timeoutCode - Will execute instead of _statement if the condition times out. (optional) <CODE>

Passed Arguments:
    _this      - Parameters passed by this function. Same as '_args' above. <ANY>

Returns:
    Nothing

Examples:
    (begin example)
        [{(_this select 0) == vehicle (_this select 0)}, {(_this select 0) setDamage 1;}, [player]] call CBA_fnc_waitUntilAndExecute;
    (end)
    (begin example)
        [{backpackCargo _this isEqualTo []}, {
            deleteVehicle _this;
        }, _holder, 5, {hint backpackCargo _this;}] call CBA_fnc_waitUntilAndExecute;
    (end)

Author:
    joko // Jonas, donated from ACE3
---------------------------------------------------------------------------- */

params [
    ["_condition", {}, [{}]],
    ["_statement", {}, [{}]],
    ["_args", []],
    ["_timeout", -1, [0]],
    ["_timeoutCode", {}, [{}]]
];

if (_timeout < 0) then {
    GVAR(waitUntilAndExecArray) pushBack [_condition, _statement, _args];
} else {
    GVAR(waitUntilAndExecArray) pushBack [{
        params ["_condition", "_statement", "_args", "_timeout", "_timeoutCode", "_startTime"];

        _startTime = [
            floor(_startTime/1e6),
            floor(_startTime/1e3) - floor(_startTime/1e6) * 1e6,
            _startTime - floor(_startTime/1e3) * 1e3 - floor(_startTime/1e6) * 1e6
        ];
        private _timeDiff = CBA_missionTime vectorDiff _startTime;

        if (_timeDiff#0 * 1e6 + _timeDiff#1 * 1e3 + _timeDiff#2 > _timeout) exitWith {
            _args call _timeoutCode;
            true
        };
        if (_args call _condition) exitWith {
            _args call _statement;
            true
        };
        false
    }, {}, [_condition, _statement, _args, _timeout, _timeoutCode, CBA_missionTime]];
};

nil
