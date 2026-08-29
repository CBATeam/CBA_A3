#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_removePerFrameHandler

Description:
    Remove a handler that you have added using CBA_fnc_addPerFrameHandler.

Parameters:
    _handle - The function handle you wish to remove. <NUMBER>

Returns:
    true if removed successful, false otherwise <BOOLEAN>

Examples:
    (begin example)
        _handle = [{player sideChat format["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
        sleep 10;
        [_handle] call CBA_fnc_removePerFrameHandler;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */

params [["_handle", -1, [0]]];

[{
    params ["_handle"];

    // a negative handle would index from the end of the array since 2.12, and -1 is the
    // conventional "no handler" sentinel, so reject it rather than act on the wrong entry
    if (_handle < 0) exitWith {false};

    private _index = GVAR(PFHhandles) param [_handle];
    if (isNil "_index") exitWith {false};

    GVAR(PFHhandles) set [_handle, nil];

    if (PFH_IS_EACHFRAME(_index)) exitWith {
        private _realIndex = PFH_EACHFRAME_DECODE(_index);
        (GVAR(eachFrameHandlerArray) select _realIndex) set [0, {}];

        if (GVAR(eachFrameHandlersToRemove) isEqualTo []) then {
            {
                {
                    GVAR(eachFrameHandlerArray) set [_x, objNull];
                } forEach GVAR(eachFrameHandlersToRemove);

                GVAR(eachFrameHandlerArray) = GVAR(eachFrameHandlerArray) - [objNull];
                GVAR(eachFrameHandlersToRemove) = [];

                {
                    _x params ["", "", "", "", "", "_handle"];
                    GVAR(PFHhandles) set [_handle, PFH_EACHFRAME_ENCODE(_forEachIndex)];
                } forEach GVAR(eachFrameHandlerArray);
            } call CBA_fnc_execNextFrame;
        };

        GVAR(eachFrameHandlersToRemove) pushBackUnique _realIndex;
        true
    };

    (GVAR(perFrameHandlerArray) select _index) set [0, {}];

    if (GVAR(perFrameHandlersToRemove) isEqualTo []) then {
        {
            {
                GVAR(perFrameHandlerArray) set [_x, objNull];
            } forEach GVAR(perFrameHandlersToRemove);

            GVAR(perFrameHandlerArray) = GVAR(perFrameHandlerArray) - [objNull];
            GVAR(perFrameHandlersToRemove) = [];

            {
                _x params ["", "", "", "", "", "_handle"];
                GVAR(PFHhandles) set [_handle, _forEachIndex];
            } forEach GVAR(perFrameHandlerArray);
        } call CBA_fnc_execNextFrame;
    };

    GVAR(perFrameHandlersToRemove) pushBackUnique _index;
    true
}, _handle] call CBA_fnc_directCall;
