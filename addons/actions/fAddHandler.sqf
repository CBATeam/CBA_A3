#include "script_component.hpp"
private ["_key", "_code", "_ar", "_entry"];
_key = _this select 0;
_code = _this select 1;
#ifdef DEBUG
	[format["addHandler: %1", _this], QUOTE(ADDON)] call CBA_fDebug;
#endif
_ar = GVAR(actions) select _key;
_entry = [_code];
PUSH(_ar,_entry);
GVAR(actions) setVariable [_key, _ar];