/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler

Description:
	Adds an action to a keyhandler
	
Parameters:
	_key - Numerical key to attach action to [Integer].
	_settings - Shift, Ctrl, Alt required [Array].
	_code - Code to execute upon event [Code].
	_type - "DOWN" (default) = keyDown,  "UP" = keyUp [String].

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

private ["_ar", "_entry", "_type", "_handlers"];
PARAMS_3(_key,_settings,_code);
_type = if (count _this > 3) then { _this select 3 } else { "DOWN" };

_handlers = if (_type == "UP") then { GVAR(keys_up) } else { GVAR(keys_down) };

_ar = _handlers select _key;
_entry = [_settings, _code];
PUSH(_ar,_entry);
_handlers set [_key, _ar];

true;
