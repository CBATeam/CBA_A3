#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_updatePerFrameHandlerDelay

Description:
    Updates the delay of an existing perFrameHandler.

Parameters:
    _handle   - The existing perFrameHandler's handle. <NUMBER>
    _delay    - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0) <NUMBER>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _wasSuccessful = [_handle, _newDelay] call CBA_fnc_updatePerFrameHandlerDelay;
    (end)

Author:
    Mokka, OverlordZorn
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]], ["_newDelay", 0, [0]]];

[{
    params ["_handle", "_newDelay", "_updateExecutionTime"];

    private _index = GVAR(PFHhandles) param [_handle];
    if (isNil "_index") exitWith {false};
    private _entry = GVAR(perFrameHandlerArray) select _index;
    private _prvDelay = _entry#1;
    _entry set [1, _newDelay];

    private _newDelta = _entry#2 - _prvDelay + _newDelay;
    private _tickTime = diag_tickTime;

    // if the next iteration Time with the updated delay would have been in the past, next iteration will be set to "now" so the following iteration will respect the new delay between iterations
    if (_newDelta < _tickTime) then { _newDelta = _tickTime; };
    _entry set [2, _newDelta];

    true

}, [_handle, _newDelay, _updateExecutionTime]] call CBA_fnc_directCall;