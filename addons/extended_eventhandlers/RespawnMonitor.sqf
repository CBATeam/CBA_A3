/*
	The respawn monitor is only useful for the two respawn types
	"INSTANT" (2) and "BASE" (3) where a completely new player
	unit is created when he or she respawns. For the other respawn
	types (where none is the default unless explicitly specified
	in the description.ext file), we don't need to run this.
*/
#include "script_component.hpp"
private [
	"_cfgRespawn", "_respawn", "_nomonitor", "_initEH", "_name",
	"_playerIsNamed", "_getUnit", "_n", "_vvn"
];

_cfgRespawn = (missionConfigFile/"respawn");

_nomonitor = true;
SLX_XEH_killed={};
if ( isNumber(_cfgRespawn) ) then
{
	_respawn = getNumber(_cfgRespawn);
	_nomonitor = _respawn in [0, 1, 4, 5];
};
if ( isText(_cfgRespawn) ) then
{
	_respawn = getText(_cfgRespawn);
	_nomonitor = { _respawn == _x }count["none", "bird", "group", "side"]>0;
};
if (!_nomonitor) then
{
	{
		// Bug #7432 - tag the playable units so that SLX_XEH_Init can
		//             detect them when they respawn and avoid running
		//             the init EH again
		_x setVariable ["slx_xeh_playable", true];
		
		// Bug #8080 - tag any unnamed playable units with a dynamically
		//             generated name so they can be tracked on respawn.
		_vvn=vehicleVarName _x;
		if (_vvn=="") then
		{
			_n=SLX_XEH_MACHINE select 8;
			SLX_XEH_MACHINE set [8, _n+1];
			_vvn=format["slx_xeh_playable%1", _n];
			_x setVehicleVarName _vvn; 
		};
	} forEach playableUnits;

	// Set up the event handler that takes care of respawning playable units.
	// (This replaces the old RespawnMonitor.sqf "thread")
	if (!isNil"CBA_fnc_addEventHandler") then
	{
		SLX_XEH_F_KILLED = compile preprocessFileLineNumbers "extended_eventhandlers\Killed.sqf";
		SLX_XEH_killed={["slx_xeh_killed",_this]call CBA_fnc_globalEvent};
		["slx_xeh_killed", {_this call SLX_XEH_F_KILLED}] call CBA_fnc_addEventHandler;
		#ifdef DEBUG_MODE_FULL
		diag_log text format["(%1) XEH killed event handler registered.", time];
		#endif
	}
	else
	{
		// CBA not there? What gives? Ok, fall back to another solution...
		
		SLX_XEH_killed={};
		// Track all playable units (players and AI) and when they respawn,
		// re-run the Extended Init EH:s on the units that have a "composite"
		// init EH defined with the "onRespawn" property set to true
		_playerIsNamed=false;
		{
			_name=vehicleVarName _x;
			
			if (_name != "") then
			{
				if (local player && (player == call compile _name)) then
				{
					_playerIsNamed=true;
				};
				_h=_name spawn
				{
					_getUnit=compile _this;
					_unit=call _getUnit;
					#ifdef DEBUG_MODE_FULL
					diag_log text format["XEH RMon: monitoring %1 (%2)",_this, _unit];
					#endif
					while {true} do
					{
						waitUntil {!alive _unit};
						waitUntil {alive (call _getUnit)};
						_unit=call _getUnit;
						#ifdef DEBUG_MODE_FULL
						diag_log text format["XEH RMon: %1 respawned. Re-running SLX_XEH_init", _this];
						#endif
						if (!isNil "_unit" && !isNull _unit) then
						{
							[_unit, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
						};
						sleep 0.5;
					};
				};
			};
		} forEach playableUnits;
		
		// Fallback: playableUnits may contain unnamed units, ie units that
		// have no name set in the mission editor. Such units are not monitored
		// by the threads created above. If the unit the player on this machine 
		// is controlling is not named, fall back to the old XEH way:
		if (!_playerIsNamed) then
		{
			#ifdef DEBUG_MODE_FULL
			diag_log text "XEH: 'legacy' player respawn monitor started";
			#endif
			while { true } do
			{
				waitUntil { !(alive player) };
				waitUntil { player == player };
				waitUntil { alive player };
				[player, "Extended_Init_EventHandlers", true] call SLX_XEH_init;
				sleep 0.5;
			};
		};
	};
};

nil;

