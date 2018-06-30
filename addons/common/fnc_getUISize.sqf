#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getUISize

Description:
    Used to determine the UI size of the screen.

Parameters:
    _output - the desired output format, either "NUMBER" or "STRING".

Returns:
    If the desired output format is

    "NUMBER" : an index into ["verysmall","small","normal","large"]
    "STRING" : one of "verysmall", "small", "normal" or "large"

    If an error occurs, the function returns either the number -1 or
    the string "error", depending on the desired output format.

Examples:
    (begin example)
        _uiSize = "STRING" call CBA_fnc_getUISize;
    (end)

Author:
    Written by Deadfast and made CBA compliant by Vigilante
---------------------------------------------------------------------------- */
SCRIPT(getUISize);

#define C_4to3 [1.818, 1.429, 1.176, 1]
#define C_16to9 [2.424, 1.905, 1.569, 1.333]
#define C_16to10 [2.182, 1.714, 1.412, 1.2]
#define C_12to3 [1.821, 1.430, 1.178, 1.001]
#define ERROR {[-1, "error"] select (_output == "STRING")}

params ["_output"];

private _ratio = "STRING" call CBA_fnc_getAspectRatio;
if (_ratio isEqualTo "") exitWith ERROR;

private _aspIndex = ["4:3", "5:4", "16:9", "16:10", "12:3"] find _ratio;
if (_aspIndex == -1) exitWith ERROR;

private _sizes = [C_4to3, C_4to3, C_16to9, C_16to10, C_12to3] select _aspIndex;

private _index = _sizes find ((round (safeZoneW * 1000)) / 1000);

if (_index == -1) exitWith ERROR;

if (_output == "STRING") then {
    ["verysmall", "small", "normal", "large"] select _index;
} else {
    _index;
}