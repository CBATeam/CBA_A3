// Backwards compatibility file

#include "script_component.hpp"

if (isNil 'SLX_XEH_objects') then { call COMPILE_FILE2(extended_eventhandlers\init_pre.sqf) };

PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0);
_this call FUNC(init);
