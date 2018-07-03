#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_compileFinal

Description:
    Defines a function in mission namespace and prevents it from being overwritten.

Parameters:
    _name     - Function name <STRING>
    _function - A function <CODE>

Returns:
    Nothing

Examples:
    (begin example)
        ["MyFunction", {systemChat str _this}] call CBA_fnc_compileFinal;
    (end)

Author:
    commy2
---------------------------------------------------------------------------- */
SCRIPT(compileFinal);

params [["_name", "", [""]], ["_function", {}, [{}]]];

_function = str _function;
_function = _function select [1, count _function - 2];

missionNamespace setVariable [_name, compileFinal _function];
