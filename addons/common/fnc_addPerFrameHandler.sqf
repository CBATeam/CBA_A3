/* ----------------------------------------------------------------------------
Function: CBA_fnc_addPerFrameHandler

Description:
    Add a handler that will execute every frame, or every x number of seconds.

Parameters:
    _function - The function you wish to execute. <CODE>
    _delay    - The amount of time in seconds between executions, 0 for every frame. (optional, default: 0) <NUMBER>
    _args     - Parameters passed to the function executing. This will be the same array every execution. (optional) <ANY>

Passed Arguments:
    _this <ARRAY>
        0: _args   - Parameters passed by this function. Same as '_args' above. <ANY>
        1: _handle - A number representing the handle of the function. Same as '_handle' returned by this function. <NUMBER>

Returns:
    _handle - A number representing the handle of the function. Use this to remove the handler. <NUMBER>

Examples:
    (begin example)
        _handle = [{player sideChat format ["every frame! _this: %1", _this];}, 0, ["some","params",1,2,3]] call CBA_fnc_addPerFrameHandler;
    (end)

Author:
    Nou & Jaynus, donated from ACRE project code for use by the community; commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_function", {}, [{}]], ["_delay", 0, [0]], ["_args", []]];

if (_function isEqualTo {}) exitWith {-1};

if (isNil QGVAR(PFHhandles)) then {
    GVAR(PFHhandles) = [];
};

if (count GVAR(PFHhandles) >= 999999) exitWith {
    WARNING("Maximum amount of per frame handlers reached!");
    diag_log _function;
    -1
};

private _handle = GVAR(PFHhandles) pushBack count GVAR(perFrameHandlerArray);

GVAR(perFrameHandlerArray) pushBack [_function, _delay, diag_tickTime, diag_tickTime, _args, _handle];

_handle
