#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_updatePerFrameHandlerDelay

Description:
    Updates the delay of an existing perFrameHandler.

Parameters:
    _handle   - The existing perFrameHandler's handle. <NUMBER>
    _delay    - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0) <NUMBER>
    _updateExecutionTime - When true, adjusts the nextExecution time. (optional, default: true) <BOOL>

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _wasSuccessful = [_handle, _newDelay] call CBA_fnc_updatePerFrameHandlerDelay;
    (end)

Author:
    Mokka, OverlordZorn
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]], ["_newDelay", 0, [0]], ["_updateExecutionTime", true, [false]]];

[{
    params ["_handle", "_newDelay", "_updateExecutionTime"];

    private _index = GVAR(PFHhandles) param [_handle];
    if (isNil "_index") exitWith {false};
    private _entry = GVAR(perFrameHandlerArray) select _index;
    private _prvDelay = _entry#1;
    _entry set [1, _newDelay];

    if (_updateExecutionTime) then {
        _newDelta = _entry#2 - _prvDelay + _newDelay;
        
        private _tickTime = diag_tickTime;

        if (_newDelta < _tickTime) then { _newDelta = _tickTime; };

        _prvDelta = _entry#2;
        _entry set [2, _newDelta];
        
        diag_log format ['[CVO](debug)(fnc_updatePerFrameHandlerDelay) _prvDelay: %1 - _newDelay: %2 - _prvDelta: %5 - _newDelta: %3 - _tickTime: %4', _prvDelay , _newDelay , _newDelta , _tickTime, _prvDelta];
    };
    true

}, [_handle, _newDelay, _updateExecutionTime]] call CBA_fnc_directCall;