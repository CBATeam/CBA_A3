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
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.

[] spawn {
	private ["_events", "_fnc", "_processedObjects"];
	_events = [XEH_EVENTS];
	_excludes = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.

	_fnc = {
		private ["_cfg", "_init", "_initAr", "_XEH", "_type"];
		PARAMS_1(_obj);
		
		_type = typeOf _obj;

		PUSH(_processedObjects,_obj);

		// Already has Full XEH EH entries - Needs nothing!
		if (_type in _xehClasses) exitWith { TRACE_2("Already XEH (cache hit)",_obj,_type) };

		// No XEH EH entries at all - Needs full XEH
		if (_type in _fullClasses) exitWith {
			TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
			[_obj, "Extended_Init_EventHandlers"] call SLX_XEH_init;
			{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach _events;
		};
		
		if (_type in _exclClasses) exitWith { TRACE_2("Exclusion, abort (cache hit)",_obj,_type) };

		_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");
		// No EH class - Needs full XEH
		if !(isClass _cfg) exitWith {
			TRACE_2("Adding XEH Full (No EH)",_obj,_type);
			[_obj, "Extended_Init_EventHandlers"] call SLX_XEH_init;
			{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach _events;
			TRACE_2("Caching (full)",_obj,_type); PUSH(_fullClasses,_type);
		};
		
		_excl = false;
		{ if (_obj isKindOf _x) exitWith { _excl = true } } forEach _excludes;
		if (_excl) exitWith {
			TRACE_2("Exclusion, abort",_obj,_type);
			PUSH(_exclClasses,_type);
		};

		// Check 1 - a XEH object variable
		// Cannot use anymore because we want to do deeper verifications
		//_XEH = _obj getVariable "Extended_FiredEH";
		//if !(isNil "_XEH") exitWith { TRACE_2("Has XEH (1)",_obj,_type) };

		// Check 2 - XEH init EH detected
		_init = _cfg >> "init";

		_XEH = false;
		if (isText _init) then {
			_initAr = toArray(getText(_init));
			if (count _initAr > 11) then {
				_ar = [];
				for "_i" from 0 to 11 do {
					PUSH(_ar,_initAr select _i);
				};
				if (toString(_ar) == "if(isnil'SLX") then { _XEH = true };
			};
		};
		
		_full = false; // Used for caching objects that need ALL eventhandlers assigned, incl init.
		if (_XEH) then {
			TRACE_2("Has XEH init",_obj,_type)
		} else {
			TRACE_2("Adding XEH init",_obj,_type);
			[_obj, "Extended_Init_EventHandlers"] call SLX_XEH_init;
			_full = true;
		};
		
		// Add script-eventhandlers for those events that are not setup properly.
		_partial = false;
		{
			_event = (_cfg >> _x);
			_XEH = false;

			if (isText _event) then {
				_eventAr = toArray(getText(_event));
				if (count _eventAr > 13) then {
					_ar = [];
					for "_i" from 0 to 13 do {
						PUSH(_ar,_eventAr select _i);
					};
					if (toString(_ar) == "_this call SLX") then { _full = false; _XEH = true };
				};
			};
			if !(_XEH) then { _partial = true; TRACE_3("Adding missing EH",_obj,_type,_x); _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] };
		} forEach _events;
		if !(_partial) then { TRACE_2("Caching",_obj,_type); PUSH(_xehClasses,_type); };
		if (_full) then { TRACE_2("Caching (full)",_obj,_type); PUSH(_fullClasses,_type); };
	};

	_processedObjects = []; // Used to maintain the list of processed objects
	_xehClasses = []; // Used to cache classes that have full XEH setup
	_fullClasses = []; // Used to cache classes that NEED full XEH setup
	_exclClasses = []; // Used for exclusion classes

	while {true} do {
		_processedObjects = _processedObjects - [objNull]; // cleanup
		{ [_x] call _fnc } forEach ((vehicles+allUnits) - _processedObjects); // TODO: Does this need an isNull check?
		sleep 2;
	};
};

LOG("XEH: PostInit Finished; " + str(SLX_XEH_MACHINE));

#ifdef DEBUG_MODE_FULL
diag_log text format["(%1) XEH END: PostInit", time];
#endif

nil;
