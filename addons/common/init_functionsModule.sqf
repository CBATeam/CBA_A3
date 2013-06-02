// Modified by Spooner for CBA in order to allow function initialisation
// in preinit phase.

#define DEBUG_MODE_FULL
#include "script_component.hpp"
scriptName "CBA\common\init_functionsModule";

// #define DO_NOT_STORE_IN_MISSION_NS

private ["_recompile"];
_recompile = (count _this) > 0;

if (CBA_FUNC_RECOMPILE) then { _recompile = true };



#ifdef DEBUG_MODE_FULL
	_timeStart = diag_tickTime;
	diag_log [diag_frameNo, diag_tickTime, time, "Initializing function module", _this, _recompile, CBA_FUNC_RECOMPILE, BIS_fnc_init];

	GVAR(fncInitTest) = {
		if (isNil "BIS_fnc_areEqual_uiNamespace") then { BIS_fnc_areEqual_uiNamespace = uiNamespace getVariable "BIS_fnc_areEqual"; };
		if (isNil "BIS_fnc_init_uiNamespace") then { BIS_fnc_init_uiNamespace = uiNamespace getVariable "BIS_fnc_init"; }; 
		// It seems that in A3 the missionNamespace copy of BIS_fnc_init and all other funcs are delayed in their inits (not available for the Briefing or XEH PreInit Phase. -VM
		
		if (isNil "CBA_fnc_globalExecute") then { diag_log [diag_frameNo, diag_tickTime, time, "CBA_fnc_globalExecute(missionNamespace) is nil!"]} else { //TRACE_1("",CBA_fnc_globalExecute); };
		
		if (isNil "BIS_fnc_areEqual") then { diag_log [diag_frameNo, diag_tickTime, time,"BIS_fnc_areEqual(missionNamespace) is nil!"]};
		
		if (isNil "BIS_fnc_areEqual_uiNamespace") then { diag_log [diag_frameNo, diag_tickTime, time,"BIS_fnc_areEqual(uiNamespace) is nil!"]};
		if (isNil "BIS_fnc_init") then { diag_log [diag_frameNo, diag_tickTime, time,"BIS_fnc_init(missionNamespace) is nil!"]};
		if (isNil "BIS_fnc_init_uiNamespace") then { diag_log [diag_frameNo, diag_tickTime, time,"BIS_fnc_init(uiNamespace) is nil!"]} else { TRACE_1("",BIS_fnc_init_uiNamespace) };
	};
#endif

#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "Function module starting."];
	// Function Tests
	0 Call GVAR(fncInitTest);
#endif

//--- Functions are already running
if (BIS_fnc_init && {!_recompile}) exitWith {};  // A3 build 0.11.103003 => observing that during the preInit phase, BIS_fnc_init (uiNamespace) is true, however BIS_fnc_init (missionNamespace) is false

LOG("CBA: Initialising the Functions module early.");
// The call is used to convert the code to an array
if {isNil "GVAR(BIS_functions_list)"} then { GVAR(BIS_functions_list) = call (uiNamespace getVariable "BIS_functions_list"); };
if {isNil "GVAR(BIS_functions_listForced)"} then { GVAR(BIS_functions_listForced) = call (uiNamespace getVariable "BIS_functions_listForced"); };


//-----------------------------------------------------------------------------
//--- PREPROCESS --------------------------------------------------------------
//-----------------------------------------------------------------------------

	{
		_xCode = uinamespace getvariable _x;
		
		if (isNil "_x") then {
			diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, format["CBA: Exporting %1 to missionNamespace", _x]];
			missionNamespace setvariable [_x,_xCode];
		};
		
	} foreach GVAR(BIS_functions_list);
	

#ifdef DEBUG_MODE_FULL	
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "CBA: Setting bis_fnc_init"];
#endif
bis_fnc_init = true;

//--------------------------------------------------------------------------------------------------------
//--- INIT COMPLETE --------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------
	
#ifdef DEBUG_MODE_FULL
	diag_log [diag_frameNo, diag_tickTime, time, diag_tickTime - _timeStart, "Function module done!"];
	// Function Tests
	0 Call GVAR(fncInitTest);
#endif
