#include "script_component.hpp"
private ["_key", "_code", "_ar", "_settings", "_entry"];
_key = _this select 0;
_settings = _this select 1;
_code = _this select 2;
#ifdef DEBUG
	[format["addHandler: %1", _this], QUOTE(ADDON)] call CBA_fDebug;
#endif
_ar = GVAR(keys) select _key;
_entry = [_settings, _code];
PUSH(_ar,_entry);
GVAR(keys) set [_key, _ar];