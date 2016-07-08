/* ----------------------------------------------------------------------------
Function: CBA_fnc_execNextFrame

Description:
    Executes a code once in non sched environment on the next frame.

Parameters:
    _function - The function to run. <CODE>
    _args     - Parameters passed to the function executing. This will be the same array every execution. [optional] <ANY>

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["This is frame %1, not %2", diag_frameno, _this select 0];}, [diag_frameno]] call CBA_fnc_execNextFrame;
    (end)

Author:
    esteldunedain and PabstMirror, donated from ACE3
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_function", {}, [{}]], ["_args", []]];

if (GVAR(nextFramePreInit) || {diag_frameno != GVAR(nextFrameNo)}) then {
    GVAR(nextFrameBufferA) pushBack [_args, _function];
} else {
    GVAR(nextFrameBufferB) pushBack [_args, _function];
};
