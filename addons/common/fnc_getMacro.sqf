#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_getMacro

Description:
    Gets the value of special macros

Parameters:
    0: Macro Name <STRING>

Returns:
    None

Examples:
    (begin example)
        "__DATE_ARR__" call CBA_fnc_getMacro;
    (end)

Author:
    PabstMirror
---------------------------------------------------------------------------- */

params ["_macro"];

_macro call compileScript [QPATHTOF(fnc_getMacro.inc.sqf)]
