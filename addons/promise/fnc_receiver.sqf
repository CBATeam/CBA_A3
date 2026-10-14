/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_receiver

Description:
    Function that gets called when a sender has a request.
    
    WARNING! Not intended to be called by client-code!

Parameters:
    _id - the promise ID, local to the sender. <ARRAY>
    _function - The function to execute, either string (var name) or code. <STRING, CODE>
    _args - Arguments to pass to the function. <ANY>

Returns:
    Nothing

Example:
    Nothing

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_id", "_function", "_args"];
private _res = if (_function isEqualType "") then {
    _args call (missionNamespace getVariable _function);
} else {
    _args call _function;
};
[_id, _res] remoteExec [QGVAR(requests), remoteExecutedOwner, false];
nil
