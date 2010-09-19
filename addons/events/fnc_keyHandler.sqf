/* ----------------------------------------------------------------------------
Internal Function: CBA_events_fnc_keyHandler

Description:
	Executes the key's handler

Author:
	Sickboy
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(keyHandler);

private ["_settings", "_code", "_handled", "_result", "_handlers", "_myHandlers", "_idx"];
#ifdef DEBUG_MODE_FULL
	private ["_ar"];
	_ar = [];
#endif

PARAMS_2(_keyData,_type);
_type = toLower _type;

_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

GVAR(keypressed) = time;

_handled = false; // If true, suppress the default handling of the key.
_result = false;

_idx = _keyData select 1;
if (count _handlers > _idx) then
{
	_myHandlers = _handlers select _idx;
	if (isNil "_myHandlers") exitWith {};
	if (typeName _myHandlers != typeName []) exitWith {};
	{
		_settings = _x select 0;
		_code = _x select 1;
		if (true) then
		{
			// Verify if the required modifier keys are present
			_exit = false;
			// Cannot compare booleans, so must use ! && etc.
			for "_i" from 0 to 2 do { if (((_settings select _i) && !(_keyData select (_i + 2))) || (!(_settings select _i) && (_keyData select (_i + 2)))) exitWith { _exit = true } };
			if (_exit) exitWith {};
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
	} forEach _myHandlers;
};
TRACE_2("keyPressed",_this,_ar);

_handled;
