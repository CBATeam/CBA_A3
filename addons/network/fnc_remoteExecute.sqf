/*
Function: CBA_fnc_remoteExecute
*/
#include "script_component.hpp"
TRACE_1("",_this);
[QUOTE(GVAR(cmd)), [CALL(Id), _this]] CALLMAIN(globalEvent);
