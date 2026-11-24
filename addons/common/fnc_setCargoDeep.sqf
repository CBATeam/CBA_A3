#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_setCargoDeep
Description:
    Sets the full inventory of a given object.

Parameters:
    _object  - Object to set the inventory of <OBJECT>

Returns:
    TODO

Examples
    (begin example)
        TODO call CBA_fnc_setCargoDeep
    (end)

Author:
    DartRuffian
---------------------------------------------------------------------------- */

params [
    ["_object", objNull, [objNull]]
];
TRACE_1("fnc_setCargoDeep",_object);
