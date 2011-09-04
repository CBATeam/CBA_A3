// Backwards compatibility file

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACE_1("",_this);

if (isNil 'SLX_XEH_objects') then { call COMPILE_FILE2(extended_eventhandlers\init_pre.sqf) };

PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0);
[_this select 0, SLX_XEH_STR_INIT_EH] call FUNC(init);
