// Modified by Spooner for CBA in order to allow function initialisation
// in preinit phase.

//#define DEBUG_MODE_FULL
#include "script_component.hpp"

scriptName "CBA\common\init_functionsModule";

// #define DO_NOT_STORE_IN_MISSION_NS

private ["_recompile"];
_recompile = (count _this) > 0;

if (CBA_FUNC_RECOMPILE) then { _recompile = true };

//BIS_fnc_init_uiNamespace = uiNamespace getVariable "BIS_fnc_init";  // It seems that in A3 the missionNamespace copy of BIS_fnc_init and all other funcs are delayed in their inits. -VM

#ifdef DEBUG_MODE_FULL
	_timeStart = diag_tickTime;
	diag_log [diag_frameNo, diag_tickTime, time, "Initializing function module", _this, _recompile, CBA_FUNC_RECOMPILE, BIS_fnc_init];

	GVAR(fncInitTest) = {
		if (isNil "BIS_fnc_areEqual") then { diag_log "BIS_fnc_areEqual(missionNamespace) is nil!"};
		BIS_fnc_areEqual_uiNamespace = uiNamespace getVariable "BIS_fnc_areEqual";
		if (isNil "BIS_fnc_areEqual_uiNamespace") then { diag_log "BIS_fnc_areEqual(uiNamespace) is nil!"};
		if (isNil "BIS_fnc_init") then { diag_log "BIS_fnc_init(missionNamespace) is nil!"};
		if (isNil "BIS_fnc_init_uiNamespace") then { diag_log "BIS_fnc_init(uiNamespace) is nil!"} else { TRACE_1("",BIS_fnc_init_uiNamespace) };
	};
	// Pre Function Tests
	0 Call GVAR(fncInitTest);
#endif

#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "Function module starting."];
	// Function Tests
	0 Call GVAR(fncInitTest);
#endif

//--- Functions are already running
if (BIS_fnc_init && {!_recompile}) exitWith {};  // A3 build 0.11.103003 => observing that during the preInit phase, BIS_fnc_init (uiNamespace) is true 
GVAR(BIS_functions_list) = call (uiNamespace getVariable "BIS_functions_list");

//-----------------------------------------------------------------------------
//--- PREPROCESS --------------------------------------------------------------
//-----------------------------------------------------------------------------

// [] call compile preprocessFileLineNumbers "A3\functions_f\initFunctions.sqf";

	
// 	{
// 		_xCode = uinamespace getvariable _x;
// 		missionnamespace setvariable [_x,_xCode];
// 	} foreach GVAR(BIS_functions_list);
	


//--------------------------------------------------------------------------------------------------------
//--- INIT COMPLETE --------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
	
#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "Function module done!"];
	// Function Tests
	0 Call GVAR(fncInitTest);
#endif
