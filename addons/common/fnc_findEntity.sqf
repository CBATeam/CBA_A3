/* ----------------------------------------------------------------------------
Function: CBA_fnc_findEntity

Description:
    A function used to find out the first entity of parsed type in a nearEntitys call

Parameters:
    - Type (Classname, Object)
    - Position (XYZ, Object, Location or Group)

Optional:
    - Radius (Scalar)

Example:
    (begin example)
    _veh = ["LaserTarget", player] call CBA_fnc_findEntity
    (end)

Returns:
    First entity; nil return if nothing

Author:
    Rommel

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(findEntity);

PARAMS_2(_type,_position);
DEFAULT_PARAM(2,_radius,50);

// this function doesn't return the nearest entity, neither did the previous version

_ret = (_position call CBA_fnc_getpos) nearEntities [[_type], _radius];
if (count _ret > 0) exitWith {_ret select 0};
nil
