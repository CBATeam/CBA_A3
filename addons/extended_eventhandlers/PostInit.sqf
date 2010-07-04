/*  PostInit.sqf

	Compile code strings in the Extended_PostInit_EventHandlers class and call
	them. This is done once per mission and after all the extended init event
	handler code is run. An addon maker can put run-once, late initialisation
	code in such a post-init "EH" rather than in a normal XEH init EH which
	 might be called several times.
*/
#include "script_component.hpp"

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH BEG: PostInit", time];
#endif

// On Server + Non JIP Client, we are now after all objects have inited
// and at the briefing, still time == 0
if (isNull player) then
{
	if !(isServer) then
	{
		SLX_XEH_MACHINE set [1, true]; // set JIP
		waitUntil { !(isNull player) };
		waitUntil { local player };
		/*
		// For JIP players only: Usually we are now a few ms/seconds into
		// the game. Test for JIP players
		_i = 0;
		while { _i < 20 } do
		{
			_i = _i + 1;
			sleep 1;
		};
		*/
	};
};

if !(isNull player) then
{
	if (isNull (group player)) then
	{
		// DEBUG TEST: Crashing due to JIP, or when going from briefing
		//			 into game
		waitUntil { !(isNull (group player)) };
	};
};

if !(isDedicated) then
{
	_text = "Post Initialization Processing...";
	if !(isNil "CBA_help_credits") then {
		// Randomly pick 2 addons from cfgPatches to display credits
		_credits = [CBA_help_credits, "CfgPatches"] call CBA_fnc_hashGet;
		_cr = [];
		_tmp = [];
		{ PUSH(_tmp,_x) } forEach ((_credits select 0) select 1);
		_tmp = [_tmp] call CBA_fnc_shuffle;
		for "_i" from 0 to 1 do {
			_key = _tmp select _i;
			_entry = format["%1, by: %2", _key, [[_credits select 0, _key] call CBA_fnc_hashGet, ", "] call CBA_fnc_join];
			PUSH(_cr,_entry);
		};
		_text = [_cr, ". "] call CBA_fnc_join;
	};
	
	startLoadingScreen [_text, "RscDisplayLoadMission"];
	private["_time2Wait"];
	_time2Wait = diag_ticktime + 1;
	waituntil {diag_ticktime > _time2Wait};
	[] spawn
	{
		private["_time2Wait"];
		_time2Wait = diag_ticktime + 10;
		waituntil {diag_ticktime > _time2Wait};
		if !(SLX_XEH_MACHINE select 8) then { LOG("WARNING: PostInit did not finish in a timely fashion"); endLoadingScreen; };
	};
};

/* 
 * Monitor playable units (players and AI) and re-run any XEH init handlers
 * that are configured to be re-run on respawn. (By default, init EH:s are not
 * re-run when a unit respawns.
 */
if (isMultiplayer) then
{
	SLX_XEH_rmon = [] execVM "extended_eventhandlers\RespawnMonitor.sqf";
};

SLX_XEH_MACHINE set [5, true]; // set player check = complete
// diag_log text format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time];

// General InitPosts
{
	(_x/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT;
} forEach [configFile, campaignConfigFile, missionConfigFile];

// Still using delayLess.fsm for this one as this can still increase init speed at briefing?
//_handle = 
//{
	// we set this BEFORE executing the inits, so that any unit created in another
	// thread still gets their InitPost ran
	SLX_XEH_MACHINE set [7, true];
	{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts
//} execFSM "extended_eventhandlers\delayless.fsm";
//waitUntil {completedFSM _handle};

if !(isDedicated) then {
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	_lastPlayer = player;
	_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
	_lastPlayer spawn {
		_lastPlayer = _this;
		// TODO: Perhaps this is possible in some event-style fashion, which would add the player events asap, perhaps synchronous
		// (though perhaps not possible like teamswitch, besides, player == _unit is probably false at (preInit)?
		while {true} do {
			waitUntil {player != _lastPlayer};
			_lastPlayer call SLX_XEH_F_REMOVEPLAYEREVENTS;
			waitUntil {player == player};
			_lastPlayer = player;
			_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;			
		};
	};
};

if !(isDedicated) then {endLoadingScreen};
SLX_XEH_MACHINE set [8, true];

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: PostInit", time];
#endif

nil;
