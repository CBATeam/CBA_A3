/* ----------------------------------------------------------------------------
Function: CBA_fnc_addActionHandler
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addActionHandler);

private ["_key", "_code", "_ar", "_entry"];
PARAMS_2(_key,_code);
#ifdef DEBUG_MODE_FULL
	[format["addHandler: %1", _this], QUOTE(ADDON)] call CBA_fnc_Debug;
#endif
_ar = GVAR(actions) select _key;
_entry = [_code];
PUSH(_ar,_entry);
GVAR(actions) setVariable [_key, _ar];
