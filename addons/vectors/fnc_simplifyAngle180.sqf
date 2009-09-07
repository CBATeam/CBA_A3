/* ----------------------------------------------------------------------------
Function: CBA_fnc_simplifyAngle180

Description:
 Returns an equivalent angle to the specified angle in the range -180 to 180.  
 If the inputted angle is in the range -180 to 180, it will be returned unchanged.
	
Parameters:
 _angle the un-adjusted angle.

Returns:
 the equivalent angle in range -180 to 180.

Examples:
	(begin example)

	(end)

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_simplifyAngle180.sqf";

#include "script_component.hpp"
SCRIPT(simplifyAngle180);


 private ["_angle"];

PARAMS_1(_angle);

while {_angle <= -180} do
{
      // Angle is too negative.
      _angle = _angle + 360;
};
while {_angle > 180} do
{
      // Angle is too positive.
      _angle = _angle - 360;
};

// return value
_angle