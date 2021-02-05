/* ----------------------------------------------------------------------------
Function: CBA_fnc_promise_callback

Description:
    Method that gets called when the receiver is done.
    Will in the end execute the promise-code locally.
    
    WARNING! Not intended to be called by client-code!

Parameters:
    _id - The Promise-ID of the now finished promise. <ARRAY>
    _data  - The result data of the now finished promise. <ANY>

Returns:
    Nothing

Example:
    Nothing

Author:
    X39
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params ["_id", "_data"];
private _request = GVAR(requests) select _id;
GVAR(requests) set [_id, 0];
[_request select 0, _data] call (_request select 1);
nil
