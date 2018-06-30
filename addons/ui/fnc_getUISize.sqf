#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUISize

Description:
    Used to determine the UI size of the screen.

Parameters:
    _output - the desired output format, either "NUMBER" or "STRING".

Returns:
    If the desired output format is

    "NUMBER": an index into ["verysmall","small","normal","large","verylarge"]
    "STRING": one of "verysmall", "small", "normal", "large" or "verylarge"

    If an error occurs, the function returns either the number -1 or
    the string "error", depending on the desired output format.

Examples:
    (begin example)
        _uiSize = "STRING" call CBA_fnc_getUISize;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(getUISize);

#define UI_SCALES [0.47, 0.55, 0.7, 0.85, 1]
#define UI_SCALES_NAMES ["verysmall", "small", "normal", "large", "verylarge"]

params [["_returnType", "STRING", [""]]];

private _uiScale = getResolution select 5;

if (_returnType == "STRING") exitWith {
    UI_SCALES_NAMES param [UI_SCALES find _uiScale, "error"] // return
};

if (_returnType == "NUMBER") exitWith {
    UI_SCALES find _uiScale // return
};

nil
