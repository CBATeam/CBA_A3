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

    // a negative handle would index from the end of the array since 2.12, and -1 is the
    // conventional "no handler" sentinel, so reject it rather than act on the wrong entry
    if (_handle < 0) exitWith {-1};

    private _index = GVAR(PFHhandles) param [_handle];
    if (isNil "_index") exitWith {-1};

    // zero delay handlers are held in their own array and have no stored delay to read
    if (PFH_IS_EACHFRAME(_index)) exitWith {0};

    GVAR(perFrameHandlerArray) select _index select 1

}, [_handle]] call CBA_fnc_directCall;
