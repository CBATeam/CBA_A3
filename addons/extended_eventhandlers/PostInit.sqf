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
	if !(SLX_XEH_MACHINE select 8) then { LOG("WARNING: PostInit did not finish in a timely fashion"); if !(isDedicated) then { 4711 cutText ["","PLAIN", 0.01] }; endLoadingScreen };
};

// Still using delayLess.fsm so it errors with 'suspension not allowed in this context', incase someone used a sleep or waitUntil incl error output!
_handle = {
	LOG("XEH: VehicleInit Started");
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
	
	LOG("XEH: VehicleInit Finished, PostInit Started");
} execFSM "extended_eventhandlers\delayless.fsm";
waitUntil {completedFSM _handle};

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

/*
 * Monitor playable units (players and AI) and re-run any XEH init handlers
 * that are configured to be re-run on respawn. (By default, init EH:s are not
 * re-run when a unit respawns.
 */
if (isMultiplayer) then
{
	SLX_XEH_rmon = [] execVM "extended_eventhandlers\RespawnMonitor.sqf";
};

// Loading screen minimal 1s
private["_time2Wait"];
if !(isDedicated) then { _time2Wait = diag_ticktime + 1 };

// Still using delayLess.fsm so it errors with 'suspension not allowed in this context', incase someone used a sleep or waitUntil incl error output!
_handle = {
	// General InitPosts
	{	(_x/"Extended_PostInit_EventHandlers") call SLX_XEH_F_INIT } forEach [configFile, campaignConfigFile, missionConfigFile];

	// we set this BEFORE executing the inits, so that any unit created in another
	// thread still gets their InitPost ran
	SLX_XEH_MACHINE set [7, true];
	{ _x call SLX_XEH_init } forEach SLX_XEH_OBJECTS; // Run InitPosts
} execFSM "extended_eventhandlers\delayless.fsm";
waitUntil {completedFSM _handle};

if (!isDedicated && !isNull player) then { // isNull player check is for Main Menu situation.
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	_lastPlayer = player;
	_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
	_lastPlayer spawn {
		_lastPlayer = _this;
		// TODO: Perhaps this is possible in some event-style fashion, which would add the player events asap, synchronous.
		// (though perhaps not possible like teamswitch, besides, player == _unit is probably false at (preInit)?
		// TODO: Perhaps best run the statements in 'delayLess' FSM (or completely in delaylessLoop), synchronous, unscheduled?
		while {true} do {
			waitUntil {player != _lastPlayer};
			_lastPlayer call SLX_XEH_F_REMOVEPLAYEREVENTS;
			waitUntil {player == player};
			_lastPlayer = player;
			_lastPlayer call SLX_XEH_F_ADDPLAYEREVENTS;
		};
	};
};

// Remove black-screen + loading-screen
if !(isDedicated) then {
	#ifdef DEBUG_MODE_FULL
	diag_log ["Waiting...", _time2Wait, diag_tickTime];
	#endif
	waituntil {diag_ticktime > _time2Wait};
	4711 cutText ["", "PLAIN", 0.01];
};
endLoadingScreen;

SLX_XEH_MACHINE set [8, true];


// XEH for non XEH supported addons
// Only works if there is at least 1 XEH-enabled object on the Map - Perhaps add a XEH logic so that users can always add that?
// Only works until someone uses removeAllEventhandlers on the object
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in all CfgVehicles classes, don't run this XEH handler - might be too much processing.
// TODO: Exclusions (Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.
// TODO: Support objects that only have partial Eventhandlers overriden (e.g init is XEH, but fired isn't, etc)
#define DEFAULT_EH "{_this call _x}forEach((_this select 0)getVariable'Extended_%1EH')"
#define FIRED_EH "_par = +_this;_c=count _par;if(_c<6)then{_par set[_c,nearestObject[_par select 0,_par select 4]];_par set[_c+1,currentMagazine(_par select 0)]}else{_mag=_par select 5;_par set[5,_par select 6];_par set[6,_mag]};{_par call _x}forEach((_par select 0)getVariable'Extended_FiredEH')"

[] spawn {
	private ["_events", "_fnc", "_ar"];
	_events = [XEH_EVENTS];

	_fnc = {
		private ["_cfg", "_init", "_initAr", "_XEH"];
		PARAMS_1(_obj);
		
		// Check 1 - a XEH object variable
		_XEH = _obj getVariable "Extended_FiredEH";
		if !(isNil "_XEH") exitWith { TRACE_1("Has XEH (1)",_obj); PUSH(_ar,_obj) };

		// Check 2 - XEH init EH detected
		_cfg = (configFile >> "CfgVehicles" >> typeOf _obj);
		_init = getText(_cfg >> "EventHandlers" >> "init");
		_initAr = toArray(_init);
		_XEH = false;
		if (count _initAr > 11) then {
			_ar = [];
			for "_i" from 0 to 11 do {
				PUSH(_ar,_initAr select _i);
			};
			if (toString(_ar) == "if(isnil'SLX") then { _XEH = true };
		};
		if (_XEH) exitWith { TRACE_1("Has XEH (2)",_obj); PUSH(_ar,_obj) };

		TRACE_1("Adding XEH",_obj);
		[_obj, "Extended_Init_EventHandlers"] call SLX_XEH_init;
		{ _obj addEventHandler [_x, format[if (_event != "fired") then { DEFAULT_EH } else { FIRED_EH }, _x]] } forEach _events;
		PUSH(_ar,_obj);
	};

	_ar = []; // Used to maintain the list of processed objects
	while {true} do {
		_ar = _ar - [objNull]; // cleanup
		{ [_x] call _fnc } forEach ((vehicles+allUnits) - _ar);
		sleep 3;
	};
};

LOG("XEH: PostInit Finished; " + str(SLX_XEH_MACHINE));

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: PostInit", time];
#endif

nil;
