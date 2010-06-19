#define DEBUG_MODE_FULL
#include "script_component.hpp"

// Generic twice-a-second loop instantiator(?)
// _code = [[_param1, _param2], { _param1 = _this select 0; _param2 = _this select 1; /* do stuff */}]
// PUSH(GVAR(d),_code);
// TODO: Add cleanup procedure
GVAR(d) = [];
GVAR(d_trigger) = createTrigger["EmptyDetector", [0,0]];
GVAR(d_trigger) setTriggerStatements["{ (_x select 0) call (_x select 1) } forEach " + QUOTE(GVAR(d)), "", ""];



// Specific twice-a-second loop
// TODO: Should be a function that creates a trigger per loop, and uses onAct, onDeact, and removes the trigger on finish?
