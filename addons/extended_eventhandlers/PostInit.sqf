/*  PostInit.sqf

	Compile code strings in the Extended_PostInit_EventHandlers class and call
	them. This is done once per mission and after all the extended init event
	handler code is run. An addon maker can put run-once, late initialisation
	code in such a post-init "EH" rather than in a normal XEH init EH which
	 might be called several times.
*/
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH BEG: PostInit", time];
#endif

SLX_XEH_MACHINE set [5, true]; // set player check = complete
// diag_log text format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time];

// Loading screen minimal 1s
private["_time2Wait"];
if !(isDedicated) then { _time2Wait = diag_ticktime + 1 };

// General InitPosts
{	(_x/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT } forEach [configFile, campaignConfigFile, missionConfigFile];

// we set this BEFORE executing the inits, so that any unit created in another
// thread still gets their InitPost ran
SLX_XEH_MACHINE set [7, true];
{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts

if (!isDedicated && !isNull player) then { // isNull player check is for Main Menu situation.
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	[] spawn {
		waitUntil {player getVariable ["SLX_XEH_READY", false]};
		_lastPlayer = player;
		_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
		#ifdef DEBUG_MODE_FULL
			diag_log ["Running Player EH check", _lastPlayer];
		#endif
		// TODO: Perhaps this is possible in some event-style fashion, which would add the player events asap, synchronous.
		// (though perhaps not possible like teamswitch, besides, player == _unit is probably false at (preInit)?
		// TODO: Perhaps best run the statements in 'delayLess' FSM (or completely in delaylessLoop), synchronous, unscheduled?
		// TODO: Evaluate with respawn... 
		while {true} do {
			waitUntil {sleep 1; player != _lastPlayer};
			sleep 1;
			_lastPlayer call SLX_XEH_F_REMOVEPLAYEREVENTS;
			waitUntil {sleep 1; !(isNull player)};
			sleep 1;
			_newPlayer = player;
			#ifdef DEBUG_MODE_FULL
				diag_log ["New Player", _newPlayer, _lastPlayer];
			#endif
			_newPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
			_lastPlayer = _newPlayer;
		};
	};
};

// XEH for non XEH supported addons
execVM "\extended_eventhandlers\supportMonitor.sqf";

SLX_XEH_MACHINE set [8, true];
XEH_LOG("XEH: PostInit Finished; " + str(SLX_XEH_MACHINE));


// Remove black-screen + loading-screen
if !(isDedicated) then {
	/*
	#ifdef DEBUG_MODE_FULL
	diag_log ["Waiting...", _time2Wait, diag_tickTime];
	#endif
	waituntil {diag_ticktime > _time2Wait};
	*/
	4711 cutText ["", "PLAIN", 0.01];
};

// if (isNil "CBA_loadingscreen_disabled") then { if !(isServer && !isNil "BIS_MPA_sendEvent") then { _abort = false; if (isServer && !isNil "BIS_MPA") then { _abort = !(BIS_MPAM getVariable ["initDone", false]) }; if !(_abort) then { endLoadingScreen } } };

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: PostInit", time];
#endif

nil;
