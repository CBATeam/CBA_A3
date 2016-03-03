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
#include "script_component.hpp"
SCRIPT(realHeight);

params [["_object", objNull, [objNull]]];

((getpos _object) select 2) + (_object distance (getpos _object))
