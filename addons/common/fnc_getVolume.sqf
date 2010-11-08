/* ----------------------------------------------------------------------------
Function: CBA_fnc_getVolume

Description:
	Return the volume of an object

Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:
	Rommel
---------------------------------------------------------------------------- */

#include <script_component.hpp>

PARAMS_1(_object);

private "_bounds";
_bounds = (boundingBox _object) select 1;

((_bounds select 0) * (_bounds select 1) * (_bounds select 2));