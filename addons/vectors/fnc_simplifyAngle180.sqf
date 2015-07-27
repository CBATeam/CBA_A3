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

// Normalize to 0-360
_angle = [_angle] call CBA_fnc_simplifyAngle;

// If within second half of range then move back a phase
if (_angle > 180) then {
    _angle = _angle - 360;
};

_angle
