/*
Function: CBA_fnc_remoteSay
*/
// Deprecated, use now globalEvent
#include "script_component.hpp"
TRACE_1("",_this);

[QUOTE(GVAR(say)), _this] call CBA_fnc_globalEvent;
