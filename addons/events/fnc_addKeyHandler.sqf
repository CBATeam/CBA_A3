/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandler
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
