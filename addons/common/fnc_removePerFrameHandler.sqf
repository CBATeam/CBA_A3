/* ----------------------------------------------------------------------------
Function: CBA_fnc_removePerFrameHandler

Description:
    Remove a handler that you have added using CBA_fnc_addPerFrameHandler.

Parameters:
    _handle - The function handle you wish to remove. <NUMBER>

Returns:
    None

Examples:
    (begin example)
        _handle = [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
        sleep 10;
        [_handle] call CBA_fnc_removePerFrameHandler;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_handle", -1, [0]]];

if (_handle < 0 || {_handle >= count GVAR(PFHhandles)}) exitWith {};

[{
    params ["_handle"];
    private _index = GVAR(PFHhandles) select _handle;

    if (isNil "_index") exitWith {};
    GVAR(deletedPFHIndices) pushback _index;

    private _oldData = GVAR(perFrameHandlerArray) select _index;
    _oldData set [5, true];

    GVAR(perFrameHandlerArray) set [_index, _oldData];

    GVAR(PFHhandles) set [_handle, nil];
}, _handle] call CBA_fnc_directCall;

nil
