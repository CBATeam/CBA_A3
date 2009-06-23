/* ----------------------------------------------------------------------------
Function: CBA_fnc_actionHandler
---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(actionHandler);

private ["_code", "_action", "_handled", "_result"];
#ifdef DEBUG
	private ["_ar"];
	_ar = [];
#endif

_action = "moveRight"; // TODO: FindOutActionKey!

_handled = false; // If true, suppress the default handling of the key.

{
	_code = _x select 0;
	#ifdef DEBUG
		PUSH(_ar,_code);
	#endif
	_result = _this call _code;
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
	
	// If any handler says that it has completely _handled_ the keypress,
	// then don't allow other handlers to be tried at all.
	if (_result) exitWith { _handled = true };
	
} forEach (GVAR(actions) getVariable _action);
#ifdef DEBUG
	if (count _ar > 0) then
	{
		[format["ActionPressed: %1, Executing: %2", _this, _ar], QUOTE(ADDON)] call CBA_fDebug;
	} else {
		[format["ActionPressed: %1, No Execution", _this], QUOTE(ADDON)] call CBA_fDebug;
	};
#endif

_handled;
