/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler

Description:
	Adds an action to a keyhandler
	
Parameters:
	_key - Numerical key to attach action to [Integer].
	_settings - Shift, Ctrl, Alt required [Array].
	_code - Code to execute upon event [Code].

Returns:

Examples:
	(begin example)
		[47, [true, false, false], { _this call myAction }] call CBA_fnc_addKeyHandler;
	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandler);

private ["_ar", "_entry"];
PARAMS_3(_key,_settings,_code);
TRACE_1("",_this);

_ar = GVAR(keys) select _key;
_entry = [_settings, _code];
PUSH(_ar,_entry);
GVAR(keys) set [_key, _ar];

true;
