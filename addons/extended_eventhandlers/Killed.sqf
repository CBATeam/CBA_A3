// This function is called via CBA_fnc_globalEvent in missions that have
// respawn set to "BASE" or "INSTANT". See RespawnMonitor.sqf
#include "script_component.hpp"
private ["_u", "_name", "_getUnit", "_unit"];

_u=_this select 0;
_name=vehicleVarName _u;

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH killed: %2 (varName: %3)",time, _this, _name];
#endif

if (_u in playableUnits && _name != "") then
{
	_name spawn
	{
		_getUnit=compile _this;
		
		#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH killed: waiting for %2 (%3) to respawn.",time, _this, call _getUnit];
		#endif
		
		waitUntil {alive (call _getUnit)};
		_unit=call _getUnit;
		#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH Killed: %2 respawned. Re-running SLX_XEH_init", time, _this];
		#endif
		if (!isNil "_unit" && !isNull _unit) then
		{
			[_unit, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
		};
	};
};
nil;

