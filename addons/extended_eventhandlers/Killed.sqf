// This function is called via CBA_fnc_globalEvent in missions that have
// respawn set to "BASE" or "INSTANT". See RespawnMonitor.sqf
// #define DEBUG_MODE_FULL
#include "script_component.hpp"
private ["_u", "_name", "_getUnit", "_unit", "_playable"];

_u = _this select 0;
_name = vehicleVarName _u;

_playable = _u getVariable "slx_xeh_playable";
if (isNil "_playable") then { _playable = _u in playableUnits; }; // returns without the units at killedEH now...

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH killed: %2 (varName: %3); %4, %5",time, _this, _name, _playable, playableUnits];
#endif

if (_playable && _name != "") then
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
		diag_log text format["(%1) XEH Killed: %2 respawned as %3. Re-running SLX_XEH_init", time, _this, _unit];
		#endif
		if (!isNil "_unit") then
		{
			if !(isNull _unit) then { [_unit, "Extended_Init_EventHandlers", true] call SLX_XEH_init; [_unit, "Extended_InitPost_EventHandlers", true] spawn SLX_XEH_init };
		};
	};
};
nil;

