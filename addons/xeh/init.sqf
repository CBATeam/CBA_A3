// Backwards compatibility file

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

TRACE_1("",_this);

if (isNil 'SLX_XEH_MACHINE') then { call compile preProcessFileLineNumbers 'x\cba_a3\addons\xeh\init_pre.sqf' };

_this call FUNC(init);
