/* ----------------------------------------------------------------------------
Function: CBA_fnc_simplifyAngle

Description:
    Returns an equivalent angle to the specified angle in the range 0 to 360.

    If the input angle is in the range 0 to 360, it will be returned unchanged.

Parameters:
    _angle - The unadjusted angle [Number]

Returns:
    Simplified angle [Number]

Examples:
   (begin example)
   _angle = [912] call CBA_fnc_simplifyAngle;
   (end)

Author:
    SilentSpike 2015-27-07
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_angle"];

// Return simplified angle
((_angle % 360) + 360) % 360
