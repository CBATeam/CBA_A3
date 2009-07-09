/*
Function: CBA_fnc_remoteExecute
*/
#include "script_component.hpp"
TRACE_1("",_this);
[QUOTE(GVAR(cmd)), [CALL(id), _this]] call CBA_fnc_globalEvent;
