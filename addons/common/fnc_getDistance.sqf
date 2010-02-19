/* ----------------------------------------------------------------------------
Function: CBA_fnc_getDistance

Description:
	A function used to find out the distance between two positions.
Parameters:
	Array containing two of [Marker, Object, Location, Group or Position]
Example:
	_distance = [Player, [0,0,0]] call CBA_fnc_getDistance
Returns:
	Number - Distance in meters
Author:
	Rommel

---------------------------------------------------------------------------- */

#define ARG(X)	(_this select (X))

(ARG(0) call CBA_fnc_getPos) distance (ARG(1) call CBA_fnc_getPos)