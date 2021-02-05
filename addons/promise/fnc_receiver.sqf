/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_receiver

Description:
    Method that gets called when a sender has a request.
    
    WARNING! Not intended to be called by client-code!

Parameters:
    _id - the promise ID, local to the sender. <ARRAY>
    _method - The method to execute, either string (var name) or code. <STRING, CODE>
    _args - Arguments to pass to the method. <ANY>

Returns:
    Nothing

Example:
    Nothing

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_id", "_method", "_args"];
private _res = if (_method isEqualType "") then {
    _args call (missionNamespace getVariable _method);
} else {
    _args call _method;
};
[_id, _res] remoteExec [QGVAR(requests), remoteExecutedOwner, false];
nil
