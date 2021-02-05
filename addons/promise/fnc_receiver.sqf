/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_receiver

Description:
    Method that gets called when a sender has a request.
    
    WARNING! Not intended to be called by client-code!

Parameters:
    _id - the promise ID, local to the sender.
    _mthd - The method to execute, either string (var name) or code.
    _args - Arguments to pass to the method.

Returns:
    Nothing

Example:
    Nothing

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_id", "_mthd", "_args"];
private _res = if (_mthd isEqualType "") then {
    _args call (missionNamespace getVariable _mthd);
} else {
    _args call _mthd;
};
[_id, _res] remoteExec [QGVAR(requests), remoteExecutedOwner, false];
nil
