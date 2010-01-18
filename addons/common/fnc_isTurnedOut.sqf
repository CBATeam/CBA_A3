/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
	Checks whether a unit is turned out in a vehicle or not.
	
Parameters:
	_unit - Unit to check [Object]

Returns:
	"true" for turned out or "false" for not turned out [Boolean]
	
Examples:
	(begin example)
		if ( [player] call CBA_fnc_isTurnedOut ) then
		{
			player sideChat "I am turned out!";
		};
	(end)

Author:
	(c) rocko 2008, 2009
---------------------------------------------------------------------------- */

#include "script_component.hpp" 
//SCRIPT(isUnitGetOutAnim);
SCRIPT(isTurnedOut);
PARAMS_1(_unit);
private [
    "_animationState",
    "_moves",
    "_actions",
    "_getOutAction",
    "_getOutState" 
];

_animationState = animationState _unit;
_moves = configFile >> getText ( configFile >> "CfgVehicles" >> typeof _unit >> "moves" );
_actions = _moves >> "Actions" >> getText( _moves >> "States" >> _animationState >> "actions" );
_getOutAction = getText( configFile >> "CfgVehicles" >> typeof vehicle _unit >> "getOutAction" );
_getOutState = getText ( _actions >> _getOutAction );
_animationState == _getOutState;
