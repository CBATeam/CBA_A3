// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Generic twice-a-second loop instantiator(?)
GVAR(d) = [];
FUNC(addTriggerHandler) = {
        private ["_c"];
	// #include "script_component.hpp"
	// #define DEBUG_MODE_FULL
	// [[_param1, _param2], { _param1 = _this select 0; _param2 = _this select 1; /* do stuff */}] call cba_fnc_addTriggerHandler;
	_c = count GVAR(d);
	GVAR(d) set [_c, _this];

	// Create the trigger, only on first use
	if (isNil QGVAR(d_trigger)) then {
		GVAR(d_trigger) = createTrigger["EmptyDetector", [0,0]];
		GVAR(d_trigger) setTriggerActivation ["ANY", "PRESENT", true];
		GVAR(d_trigger) setTriggerStatements["{ if (count _x == 2) then { (_x select 0) call (_x select 1) } } forEach cba_common_d", "", ""];
	};
	_c; // return index, so can either change array parameter count, or empty?
};
// TODO: Cleanup functions?

// Specific twice-a-second loop
// TODO: Should be a function that creates a trigger per loop, and uses onAct, onDeact, and removes the trigger on finish?

