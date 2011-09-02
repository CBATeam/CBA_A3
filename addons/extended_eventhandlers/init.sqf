// Backwards compatibility file

#include "script_component.hpp"

if (isNil 'SLX_XEH_objects') then { call COMPILE_FILE2(extended_eventhandlers\init_pre.sqf) };

_this call SLX_XEH_EH_Init;
