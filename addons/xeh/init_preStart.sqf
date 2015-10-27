// #define DEBUG_MODE_FULL
#include "script_component.hpp"
SCRIPT(init_preStart);

// No _this in preStart, also fixes call to init_compile
private "_this";
_this = nil;

// Always compile cache function once
call compile preProcessFileLineNumbers 'x\cba\addons\xeh\init_compile.sqf';

PREP(init_once);

with uiNamespace do {
    (configFile/"Extended_PreStart_EventHandlers") call FUNC(init_once);
};

XEH_LOG("XEH: PreStart Finished.");
