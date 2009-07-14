/* ----------------------------------------------------------------------------
Function: CBA_fnc_inheritsFrom

Description:
	Checks whether a config entry inherits, directly or indirectly, from another
	one.
	
	For objects, it is probably simpler to use the *isKindOf* command.

Parameters:
	_class - Class to check if it is a descendent of _baseClass [Config]
	_baseClass - Ancestor class [Config]
	
Returns:
	true if _class is a decendent of _baseClass [Boolean]
	
Examples:
	(begin example)
		_rifle = configFile >> "CfgWeapons" >> "m16a4_acg_gl";
		_baseRifle = configFile >> "CfgWeapons" >> "RifleCore";
		_inherits = [_rifle, _baseRifle] call CBA_fnc_inheritsFrom;
		// => true in this case, since that rifle is a descendent of RifleCore.
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(inheritsFrom);

PARAMS_2(_class,_baseClass);

private "_valid";
_valid = false;

_class = inheritsFrom _class;
while { _class != "" } do
{
	if (_class == _baseClass) exitWith { _valid = true };
	_class = inheritsFrom _class;
};

_valid
