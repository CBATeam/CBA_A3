#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_execAfterNFrames

Description:
    Executes the given code after the specified number of frames.

Parameters:
    _function - The function to run. <CODE>
    _args     - Parameters passed to the function executing. This will be the same array every execution. (optional, default: []) <ANY>
    _frames   - The amount of frames the execution of the function should be delayed by. (optional, default: 0) <NUMBER>

Returns:
    Nothing Useful

Examples:
    (begin example)
        [{hint "Done!"}, [], 5] call cba_fnc_execAfterNFrames;
    (end)

Author:
    mharis001, donated from ZEN
---------------------------------------------------------------------------- */

if (canSuspend) exitWith {
    [CBA_fnc_execAfterNFrames, _this] call CBA_fnc_directCall;
};

params [["_function", {}, [{}]], ["_args", []], ["_frames", 0, [0]]];

if (_frames > 0) exitWith {
    [CBA_fnc_execAfterNFrames, [_function, _args, _frames - 1]] call CBA_fnc_execNextFrame;
};

_args call _function;
