/* ----------------------------------------------------------------------------
Function: CBA_fnc_northingReversed

Description:
	Checks if the maps northing is reversed (like Chernarus & Utes, or any map pre-OA)
	
Parameters:
	None
	
Returns:
	_reversed - Bool, true if its reversed, false if it is not.
	
Examples:
	(begin example)
		_reversed = [] call CBA_fnc_northingReversed
	(end)
	
Author:
	Nou

---------------------------------------------------------------------------- */

private ["_test", "_reversed"];
_test = getNumber (configFile >> "CfgWorlds" >> worldName >> "Grid" >> "Zoom1" >> "stepY");
_reversed = false;
if(_test > 0) then {
	_reversed = true;
};

_reversed