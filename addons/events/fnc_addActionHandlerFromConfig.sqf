/* ----------------------------------------------------------------------------
Function: CBA_fnc_addActionHandlerFromConfig

Description:
	Adds an action to an actionHandler, read from config
	
Parameters:
	_component - Classname under "CfgSettings" >> "CBA" >> "events" [String].
	_action - Action classname [String].
	_code - Code to execute upon event [Code].

Returns:

Examples:
	(begin example)
		["cba_sys_nvg", "nvgon", { _this call myAction }] call CBA_fnc_addActionhandlerFromConfig
	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addActionHandlerFromConfig);

private ["_component", "_action", "_code", "_key"];
PARAMS_3(_component,_action,_code);

_key = [_component, _action] call FUNC(readActionFromConfig);
if (_key select 0 > -1) exitWith
{
	 [_key select 0, _code] call FUNC(addHandler);
	 true
};

false
