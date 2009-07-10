/* ----------------------------------------------------------------------------
Function: CBA_fnc_addActionHandler
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addActionHandler);

private ["_ar", "_entry"];
PARAMS_2(_key,_code);
TRACE_1("",_this);

_ar = GVAR(actions) select _key;
_entry = [_code];
PUSH(_ar,_entry);
GVAR(actions) setVariable [_key, _ar];
