/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_create

Description:
    Creates and executes a new Promise.

Parameters:
    _receiver - remoteExecCall target. <NUMBER, OBJECT, STRING, SIDE, GROUP, ARRAY>
    _method - either string (methodname) or code to execute on target. <STRING, CODE>
    _methodArgs - custom arguments to pass to the target. <ANY>
    _args - args to pass to the callback (see next param) <ANY>
    _callback - callback for the promise (executed on current machine). <CODE>
          Will receive an array, with index 0 being what is passed include
          _args and index 1 being whatever is returned by the target invokation
          [_args, _mthdResult]

Returns:
    Identifier that allows to check if a promise is yet done. See CBA_fnc_promise_done. <ARRAY>

Example:
    (begin example)
        [
            random_player, "random_method", [],
            [_someLocalVariable], {
                params ["_args", "_result"];
                _args params  ["_someLocalVariable"];
                diag_log _result;
                diag_log _someLocalVariable;
            }
        ] call CBA_fnc_promise_create;
    (end)

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"
params ["_receiver", "_method", "_methodArgs", "_args", "_callback"];
private _stamp = diag_tickTime;
private _index = 0;
isNil {
    _index = GVAR(requests) find 0;
    if (_index == -1) then {
         _index = GVAR(requests) pushBack [_args, _callback, _stamp];
    }
    else {
        GVAR(requests) set [_index, [_args, _callback, _stamp]];
    }
};
[_index, _method, _methodArgs] remoteExec [QGVAR(requests), _receiver, false];
[_index, _stamp]
