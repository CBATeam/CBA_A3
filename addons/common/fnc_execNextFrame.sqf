#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_execNextFrame

Description:
    Executes a code once in non sched environment delayed by n frames.

Parameters:
    _function - The function to run. <CODE>
    _args     - Parameters passed to the function executing. This will be the same array every execution. (optional, default: []) <ANY>
    _frames   - The number of frames the execution will be delayed by. (optional, default: 1) <NUMBER>

Returns:
    Nothing

Examples:
    (begin example)
        [{player sideChat format ["This is frame %1, not %2", diag_frameno, _this select 0];}, [diag_frameno]] call CBA_fnc_execNextFrame;
    (end)

Author:
    esteldunedain and PabstMirror, donated from ACE3
---------------------------------------------------------------------------- */

params [["_function", {}, [{}]], ["_args", []], ["_frames", 1, [0]]];

// Do not allow negative or 0 frame delays
_frames = _frames max 1;

if (_frames > 1) exitWith {
    GVAR(nextFrameNBuffer) pushBack [diag_frameNo + _frames, _args, _function];
    GVAR(nextFrameNBufferIsSorted) = false;
};

if (diag_frameNo != GVAR(nextFrameNo)) then {
    GVAR(nextFrameBufferA) pushBack [_args, _function];
} else {
    GVAR(nextFrameBufferB) pushBack [_args, _function];
};
