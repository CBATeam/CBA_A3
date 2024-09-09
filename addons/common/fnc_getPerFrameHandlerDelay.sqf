#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getPerFrameHandlerDelay 

Description:
    Returns the current delay of an existing perFrameHandler.

Parameters:
    _handle   - The existing perFrameHandler's handle. <NUMBER>

Returns:
    _return current Delay of perFrameHandler. Will return -1 if failed. <Number>

Examples:
    (begin example)
        _currentDelay = [_handle] call CBA_fnc_getPerFrameHandlerDelay;
    (end)

Author:
    Mokka, OverlordZorn
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]]];

[{
    params ["_handle"];

    private _index = GVAR(PFHhandles) param [_handle];
    if (isNil "_index") exitWith {-1};
    private _entry = GVAR(perFrameHandlerArray) select _index;
    _entry#1

}, [_handle]] call CBA_fnc_directCall;