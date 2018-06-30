#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_realHeight

Description:
    Real z coordinate of an object, for placing stuff on roofs, etc.

Parameters:
    _object - an object <OBJECT>

Returns:
    The z coordinate of the top of that object. <NUMBER>

Examples:
    (begin example)
        _height = _house call CBA_fnc_realHeight;
    (end)

Author:

---------------------------------------------------------------------------- */
SCRIPT(realHeight);

params [["_object", objNull, [objNull]]];

((getPos _object) select 2) + (_object distance (getPos _object))
