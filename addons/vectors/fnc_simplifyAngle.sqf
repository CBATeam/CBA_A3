/* ----------------------------------------------------------------------------
Function: CBA_fnc_simplifyAngle

Description:
 Returns an equivalent angle to the specified angle in the range 0 to 360.
 This allows adjustment from negative angles and angles equal or greater to 360.
 If the inputted angle is in the range 0 - 360, it will be returned unchanged.

Parameters:
 _angle the un-adjusted angle.

Returns:
 the equivalent angle in range 0 to 360.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_simplifyAngle.sqf";

#include "script_component.hpp"
SCRIPT(simplifyAngle);

PARAMS_1(_angle);

while {_angle < 0} do {
      // Angle is negative, so convert it to the equivalent positive angle.
      _angle = _angle + 360;
};

// Make sure it is within the range [0,360].
if (_angle > 360) then {
	_angle = _angle mod 360;
};

// return value
_angle;