#include "script_component.hpp"
SCRIPT(test_pid);

// execVM "\x\cba\addons\pid\test_pid.sqf";

private _fnc_arrayAproxEq = {
    params ["_a", "_b"];
    if (count _a != count _b) exitWith { false };
    {
        if (abs (_x - (_b # _forEachIndex)) > 0.001) exitWith { false };
        true
    } forEach _a;
};


////////////////////////////////////////////////////////////////////////////////////////////////////

private _pid = [1, 0.05, 0.2, 5, -100, 100, 5] call CBA_pid_fnc_create;

private _deltas = [];
_deltas pushBack ([_pid, 5, 0] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 4, 1] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 3, 2] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 3] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 4] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 5] call CBA_pid_fnc_update);

private _expected = [0,1.225,2.3,-0.275,-1.825,-1];
private _test = [_deltas,_expected] call _fnc_arrayAproxEq;
TEST_TRUE(_test,"bad PID controller results");

_pid call CBA_pid_fnc_reset;
[_pid, 0.5, nil, 0.8] call CBA_pid_fnc_setGains;
_deltas = [];
_deltas pushBack ([_pid, 5, 0] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 4, 1] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 3, 2] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 3] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 4] call CBA_pid_fnc_update);
_deltas pushBack ([_pid, 6, 5] call CBA_pid_fnc_update);

private _expected = [0,1.325,1.9,2.025,-4.025,-0.5];
private _test = [_deltas,_expected] call _fnc_arrayAproxEq;
TEST_TRUE(_test,"bad PID controller results");
