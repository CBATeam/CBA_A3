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

// Warn if PostInit takes longer than 10 tickTime seconds
// Remove black-screen + loading-screen on timeOut
[] spawn
{
	private["_time2Wait"];
	_time2Wait = diag_ticktime + 10;
	waituntil {diag_ticktime > _time2Wait};
	if !(SLX_XEH_MACHINE select 8) then { XEH_LOG("WARNING: PostInit did not finish in a timely fashion"); if !(isDedicated) then { 4711 cutText ["","PLAIN", 0.01] }; endLoadingScreen };
};

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	XEH_LOG("XEH: VehicleInit Started");
	{
		_sim = getText(configFile/"CfgVehicles"/(typeOf _x)/"simulation");
		_crew = crew _x;
		/*
		* If it's a vehicle then start event handlers for the crew.
		* (Vehicles have crew and are neither humanoids nor game logics)
		*/
		if ((count _crew>0)&&{ _sim == _x }count["soldier", "invisible"] == 0) then
		{
			{ [_x, "Extended_Init_Eventhandlers"] call SLX_XEH_init } forEach _crew;
		};
	} forEach vehicles;

	XEH_LOG("XEH: VehicleInit Finished, PostInit Started");
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];
GVAR(init_obj) setDamage 1;
waitUntil {isNil QUOTE(GVAR(init_obj))};


// On Server + Non JIP Client, we are now after all objects have inited
// and at the briefing, still time == 0
if (isNull player) then
{
	if (!isDedicated && !(SLX_XEH_MACHINE select 6)) then // only if MultiPlayer and not dedicated
	{
		#ifdef DEBUG_MODE_FULL
		diag_log text "JIP";
		#endif

		SLX_XEH_MACHINE set [1, true]; // set JIP
		// TEST for weird jip-is-server-issue :S
		if (!(SLX_XEH_MACHINE select 2) || SLX_XEH_MACHINE select 3 || SLX_XEH_MACHINE select 4) then {
			diag_log ["WARNING: JIP Client, yet wrong detection", SLX_XEH_MACHINE];
			SLX_XEH_MACHINE set [2, true]; // set Dedicated client
			SLX_XEH_MACHINE set [3, false]; // set server
			SLX_XEH_MACHINE set [4, false]; // set dedicatedserver
		};
		waitUntil { !(isNull player) };
		waitUntil { local player };
	};
};

if !(isNull player) then
{
	if (isNull (group player)) then
	{
		// DEBUG TEST: Crashing due to JIP, or when going from briefing
		//			 into game
		#ifdef DEBUG_MODE_FULL
		diag_log text "NULLGROUP";
		#endif
		waitUntil { !(isNull (group player)) };
	};
};

SLX_XEH_MACHINE set [5, true]; // set player check = complete
// diag_log text format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time];

// Loading screen minimal 1s
private["_time2Wait"];
if !(isDedicated) then { _time2Wait = diag_ticktime + 1 };

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	// General InitPosts
	{	(_x/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT } forEach [configFile, campaignConfigFile, missionConfigFile];

	// we set this BEFORE executing the inits, so that any unit created in another
	// thread still gets their InitPost ran
	SLX_XEH_MACHINE set [7, true];
	{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];
GVAR(init_obj) setDamage 1;
waitUntil {isNil QUOTE(GVAR(init_obj))};

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
