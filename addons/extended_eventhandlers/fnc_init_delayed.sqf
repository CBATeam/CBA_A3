// Delayed Init per Object

// #define DEBUG_MODE_FULL
#include "script_component.hpp"

private ["_unitPlayable"];
PARAMS_1(_unit);

if (isNull _unit) exitWith {
	#ifdef DEBUG_MODE_FULL
		format["XEH BEG: (Bug #7432) %2 Null Object", time, _unit] call SLX_XEH_LOG;
	#endif
};

#ifdef DEBUG_MODE_FULL
	format["XEH BEG: (Bug #7432) %2 is now ready for init", time, _unit] call SLX_XEH_LOG;
#endif

_unitPlayable = _unit getVariable "SLX_XEH_PLAYABLE";
if (isNil "_unitPlayable") then { _unitPlayable = false };

// If unit already has the variable, it is a respawned unit.
// Set by InitPost Man-eventhandler.
if (_unitPlayable) then {
	[_unit, SLX_XEH_STR_INIT_EH, true, true] call FUNC(init); // is respawn
} else {
	[_unit, SLX_XEH_STR_INIT_EH, false, true] call FUNC(init); // is not respawn
};
