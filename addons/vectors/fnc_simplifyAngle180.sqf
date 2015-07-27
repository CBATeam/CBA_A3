/* ----------------------------------------------------------------------------
Function: CBA_fnc_simplifyAngle180

Description:
    Returns an equivalent angle to the specified angle in the range -180 to 180.
    If the input angle is in the range -180 to 180, it will be returned unchanged.

Parameters:
    _angle - The unadjusted angle [Number]

Returns:
    Simplified angle [Number]

Examples:
   (begin example)
   _angle = [912] call CBA_fnc_simplifyAngle180;
   (end)

Author:
    SilentSpike 2015-27-07
---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_1(_angle);

// Return simplified value
_angle % 180
