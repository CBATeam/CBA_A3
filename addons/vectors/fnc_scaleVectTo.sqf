/* ----------------------------------------------------------------------------
Function: CBA_fnc_scaleVectTo

Description:
 scales a vector so that its new Magnitude is equivalent to a specified value.

Parameters:
 _vect the vector to scale.
 _newMagVal the value of the magnitude of the new scaled vector.

Returns:
 a vector which has the same direction and elevation as the original vector, but which has a specified magnitude.

Examples:
	(begin example)

	(end)

*  @[not needed yet]*  @call sct_simplifyAngle.sqf

Author:
	Vigilante, courtesy by -=ACE=- of Simcentric
---------------------------------------------------------------------------- */
scriptName "fnc_scaleVectTo.sqf";

#include "script_component.hpp"
SCRIPT(scaleVectTo);


 private ["_vect", "_newMagn", "_magn", "_scaleFactor", "_outVect"];

PARAMS_2(_vect,_newMagn);

_magn = _vect call CBA_fnc_vectMagn;
_scaleFactor = _newMagn / _magn;
_outVect = [_vect, _scaleFactor] call CBA_fnc_scaleVect;
_outVect;