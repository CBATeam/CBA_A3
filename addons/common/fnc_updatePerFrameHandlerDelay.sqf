#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_updatePerFrameHandlerDelay

Description:
    Updates the delay of an existing perFrameHandler.

Parameters:
    _handle   - The existing perFrameHandler's handle. <NUMBER>
    _delay    - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0) <NUMBER>
    _updateExecutionTime - <BOOL> When true, adjusts the nextExecution time.

Returns:
    true if successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _wasSuccessful = [_handle, _newDelay] call CBA_fnc_updatePerFrameHandlerDelay;
    (end)

Author:
    Mokka, OverlordZorn
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]], ["_newDelay", 0, [0]], ["_updateExecutionTime", false, [false]]];

[{
    params ["_handle", "_newDelay", "_updateExecutionTime"];

    private _idx = GVAR(PFHhandles) param [_handle];
    if (isNil "_idx") exitWith {false};
    (GVAR(perFrameHandlerArray) select _idx) set [1, _newDelay];

    if (_updateExecutionTime) then {
        // Add code here




    };

    true

}, [_handle, _newDelay, _updateExecutionTime]] call CBA_fnc_directCall;