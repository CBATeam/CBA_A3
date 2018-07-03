#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getAspectRatio

Description:
    Used to determine the Aspect ratio of the screen.

Parameters:
    _output - string with one of ["ARRAY","NUMBER","STRING"]

Returns:
    array, string or number of screenratio i.e. [16,9] or "16:9" or 1.333 ..

Examples:
    (begin example)
        _ratio = "STRING" call CBA_fnc_getAspectRatio;
        _ratio = "ARRAY" call CBA_fnc_getAspectRatio;
        _ratio = "NUMBER" call CBA_fnc_getAspectRatio;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(getAspectRatio);

#define ASPECT_RATIOS ["1.33", "1.25", "1.78", "1.60", "4.00"]
#define ASPECT_RATIOS_NAMES ["4:3", "5:4", "16:9", "16:10", "12:3"]
#define ASPECT_RATIOS_ARRAYS [[4,3], [5,4], [16,9], [16,10], [12,3]]

params [["_returnType", "STRING", [""]]];

private _aspectRatio = getResolution select 4;

if (_returnType == "NUMBER") exitWith {
    _aspectRatio / (4/3) // return
};

_aspectRatio = ASPECT_RATIOS find (_aspectRatio toFixed 2);

if (_returnType == "STRING") exitWith {
    ASPECT_RATIOS_NAMES param [_aspectRatio, "error"] // return
};

if (_returnType == "ARRAY") exitWith {
    ASPECT_RATIOS_ARRAYS param [_aspectRatio, [-1, -1]] // return
};

nil
