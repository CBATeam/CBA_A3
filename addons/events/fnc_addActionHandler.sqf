/* ----------------------------------------------------------------------------
Function: CBA_fnc_addActionHandler

Description:
	Adds an action to an actionHandler
	
Parameters:
	_action - Action to attach action to [String].
	_code - Code to execute upon event [Code].

Returns:

Examples:
	(begin example)
		["NVGon", { _this call myAction }] call CBA_fnc_addActionHandler;
	(end)

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addActionHandler);

private ["_ar", "_entry"];
PARAMS_2(_action,_code);
TRACE_1("",_this);

_ar = GVAR(actions) getVariable _action;
_entry = [_code];
PUSH(_ar,_entry);
GVAR(actions) setVariable [_action, _ar];
