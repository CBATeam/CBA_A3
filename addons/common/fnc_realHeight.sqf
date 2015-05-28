/* ----------------------------------------------------------------------------
Function: CBA_fnc_realHeight

Description:
    Real z coordinate of an object, for placing stuff on roofs, etc.

Parameters:
    _obj: an object [Object]

Returns:
    The z coordinate of the top of that object. [Number]

Examples:
    (begin example)
    _height = _house call CBA_fnc_realHeight;
    (end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(realHeight);

private "_obj";
PARAMS_1(_obj);

((getpos _obj) select 2) + (_obj distance (getpos _obj))
