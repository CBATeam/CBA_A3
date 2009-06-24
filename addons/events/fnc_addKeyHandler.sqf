/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandler);

private ["_key", "_code", "_ar", "_settings", "_entry"];
PARAMS_3(_key,_settings,_code);
#ifdef DEBUG
	[format["addHandler: %1", _this], QUOTE(ADDON)] call CBA_fnc_Debug;
#endif
_ar = GVAR(keys) select _key;
_entry = [_settings, _code];
PUSH(_ar,_entry);
GVAR(keys) set [_key, _ar];