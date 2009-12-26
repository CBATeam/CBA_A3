/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandler

Description:
	Executes the key's handler

Author: 
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(keyHandler);

private ["_settings", "_code", "_handled", "_result", "_handlers"];
#ifdef DEBUG_MODE_FULL
	private ["_ar"];
	_ar = [];
#endif

PARAMS_2(_keyData,_type);

_handlers = switch _type do
{
	case 0: { GVAR(keys_down) };
	case 1: { GVAR(keys_up) };
};

GVAR(keypressed) = time;

_handled = false; // If true, suppress the default handling of the key.
_result = false;

{
	_settings = _x select 0;
	_code = _x select 1;
	if (true) then
	{
		if (_settings select 0 && !(_keyData select 2)) exitWith {};
		if (_settings select 1 && !(_keyData select 3)) exitWith {};
		if (_settings select 2 && !(_keyData select 4)) exitWith {};
		if (!(_settings select 0) && _keyData select 2) exitWith {};
		if (!(_settings select 1) && _keyData select 3) exitWith {};
		if (!(_settings select 2) && _keyData select 4) exitWith {};
		#ifdef DEBUG_MODE_FULL
			PUSH(_ar,_code);
		#endif
		_result = _keyData call _code;
		
		if (isNil "_result") then
		{
			WARNING("Nil result from handler.");
			_result = false;
		}
		else{if ((typeName _result) != "BOOL") then
		{
			TRACE_1("WARNING: Non-boolean result from handler.",_result);
			_result = false;
		}; };
	};
	
	// If any handler says that it has completely _handled_ the keypress,
	// then don't allow other handlers to be tried at all.
	if (_result) exitWith { _handled = true };
	
} forEach (_handlers select (_keyData select 1));

TRACE_2("keyPressed",_this,_ar);

_handled;
