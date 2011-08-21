// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Compile all necessary scripts and start one vehicle crew initialisation thread
SLX_XEH_DisableLogging = isClass(configFile/"CfgPatches"/"Disable_XEH_Logging");
XEH_LOG("XEH: PreInit Started. v"+getText(configFile >> "CfgPatches" >> "Extended_Eventhandlers" >> "version"));
if (time > 0) then { XEH_LOG("XEH WARNING: Time > 0; This probably means there are no XEH compatible units by default on the map, perhaps add the SLX_XEH_Logic module.") };

private ["_cfgRespawn", "_respawn"];
_cfgRespawn = (missionConfigFile/"respawn");
_respawn = false;
if ( isNumber(_cfgRespawn) ) then
{
	_respawn = !(getNumber(_cfgRespawn) in [0, 1, 4, 5]);
};
if ( isText(_cfgRespawn) ) then
{
	_respawn = !(getText(_cfgRespawn) in ["none", "bird", "group", "side"]);
};

SLX_XEH_MACHINE =
[
	!isDedicated, // 0 - isClient (and thus has player)
	false, // 1 - isJip
	!isServer, // 2 - isDedicatedClient (and thus not a Client-Server)
	isServer, // 3 - isServer
	isDedicated, // 4 - isDedicatedServer (and thus not a Client-Server)
	false, // 5 - Player Check Finished
	!isMultiplayer, // 6 - SP?
	false, // 7 - StartInit Passed
	false, // 8 - Postinit Passed
	isMultiplayer && _respawn      // 9 - Multiplayer && respawn?
];

// Backup
_fnc_compile = uiNamespace getVariable "SLX_XEH_COMPILE";
if (isNil "_fnc_compile") then { call compile preProcessFileLineNumbers 'extended_eventhandlers\init_compile.sqf' };

SLX_XEH_objects = [];
SLX_XEH_INIT_MEN = [];
// All events except the init event
SLX_XEH_OTHER_EVENTS = [XEH_EVENTS,XEH_CUSTOM_EVENTS];

SLX_XEH_LOG = { XEH_LOG(_this); };

// Process each new unit
SLX_XEH_F_INIT = {
	private [
		"_i", "_c", "_entry", "_entryServer", "_entryClient", "_Inits"
	];
	_Inits = [];
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH BEG: Init %1", _this];
	XEH_LOG(_msg);
	#endif

	if (isClass _this) then
	{
		_i = 0;
		_c = count _this;
		while { _i<_c } do
		{
			_entry = _this select _i;
			if (isClass _entry) then
			{
				_entryServer = (_entry/"serverInit");
				_entryClient = (_entry/"clientInit");
				_entry = (_entry/"init");
				if (isText _entry) then
				{
					_Inits set [count _Inits, compile(getText _entry)];
				};
				if (SLX_XEH_MACHINE select 3) then
				{
					if (isText _entryServer) then
					{
						_Inits set [count _Inits, compile(getText _entryServer)];
					};
				};
				if (!isDedicated) then
				{
					if (isText _entryClient) then
					{
						_Inits set [count _Inits, compile(getText _entryClient)];
					};
				};
			} else {
				if (isText _entry) then
				{
					_Inits set [count _Inits, compile(getText _entry)];
				};
			};
			_i = _i+1;
		};
		{
			#ifdef DEBUG_MODE_FULL
				XEH_LOG(_x);
			#endif
			call _x;
		} forEach _Inits;
	};
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH END: Init %1", _this];
	XEH_LOG(_msg);
	#endif
};

// Add / Remove the playerEvents
SLX_XEH_F_ADDPLAYEREVENTS = {
	private ["_event", "_curEvt"];
	if (isNull _this) exitWith {}; // not a valid object
	{ _event = format["Extended_%1EH",_x]; _curEvt = _this getVariable _event; if (isNil "_curEvt") then { _curEvt = [] }; _this setVariable [_event, [if (count _curEvt > 0) then { _curEvt select 0 } else { {} }, compile format["_this call ((_this select 0) getVariable '%1_Player')",_event]]] } forEach SLX_XEH_OTHER_EVENTS;
};
SLX_XEH_F_REMOVEPLAYEREVENTS = {
	private ["_event", "_curEvt"];
	if (isNull _this) exitWith {}; // not a valid object
	{ _event = format["Extended_%1EH",_x]; _curEvt = _this getVariable _event; if (isNil "_curEvt") then { _curEvt = [] }; if (count _curEvt > 0) then { _this setVariable [_event, [_curEvt select 0]] } } forEach SLX_XEH_OTHER_EVENTS;
};

// The actual XEH functions that are called from within the engine eventhandlers.
// This can also be uesd for better debugging
#ifdef DEBUG_MODE_FULL
	#define XEH_FUNC(A) SLX_XEH_EH_##A = { if ('A' in ['Respawn', 'MPRespawn', 'Killed', 'MPKilled', 'Hit', 'MPHit']) then { diag_log ['A',_this, local (_this select 0), typeOf (_this select 0)] }; {_this call _x}forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif
#ifndef DEBUG_MODE_FULL
	#define XEH_FUNC(A) SLX_XEH_EH_##A = { {_this call _x}forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif

XEH_FUNC(Hit);
XEH_FUNC(AnimChanged);
XEH_FUNC(AnimStateChanged);
XEH_FUNC(Dammaged);
XEH_FUNC(Engine);
XEH_FUNC(FiredNear);
XEH_FUNC(Fuel);
XEH_FUNC(Gear);
XEH_FUNC(GetIn);
XEH_FUNC(GetOut);
XEH_FUNC(IncomingMissile);
XEH_FUNC(Hit);
XEH_FUNC(Killed);
XEH_FUNC(LandedTouchDown);
XEH_FUNC(LandedStopped);
XEH_FUNC(Respawn);
XEH_FUNC(MPHit);
XEH_FUNC(MPKilled);
XEH_FUNC(MPRespawn);

SLX_XEH_EH_Init = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init };
SLX_XEH_EH_RespawnInit = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0, "Extended_Init_EventHandlers", true] call SLX_XEH_init };
SLX_XEH_EH_GetInMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetInManEH') };
SLX_XEH_EH_GetOutMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetOutManEH') };
SLX_XEH_EH_Fired =
{
	#ifdef DEBUG_MODE_FULL
		// diag_log ['Fired',_this, local (_this select 0), typeOf (_this select 0)];
	#endif
	_this call SLX_XEH_EH_FiredBis; _feh = ((_this select 0)getVariable'Extended_FiredEH'); if (count _feh > 0) then { _c=count _this;if(_c<6)then{_this set[_c,nearestObject[_this select 0,_this select 4]];_this set[_c+1,currentMagazine(_this select 0)]}else{_this = +_this; _mag=_this select 5;_this set[5,_this select 6];_this set[6,_mag]};{_this call _x}forEach _feh }
};
SLX_XEH_EH_FiredBis = {
	{_this call _x}forEach((_this select 0)getVariable'Extended_FiredBisEH');
};

// XEH init functions
SLX_XEH_initPlayable =
{
	_unit = _this select 0;
	_var = _unit getVariable "SLX_XEH_PLAYABLE";
	if !(isNil "_var") exitWith {}; // Already set
	if (_unit in playableUnits || isPlayer _unit || _unit == player) then
	{
		#ifdef DEBUG_MODE_FULL
			str(['Playable unit!', _unit]) call SLX_XEH_LOG;
		#endif
		if (_unit == player) then {
			_unit setVariable ['SLX_XEH_PLAYABLE', true, true]; // temporary until better solution for players in MP..
		} else {
			// Workaround for JIP players thinking they are respawners :P
			_unit setVariable ['SLX_XEH_PLAYABLE', true];
		};
	};
};

SLX_XEH_init = COMPILE_FILE2(extended_eventhandlers\Init.sqf);
SLX_XEH_initPost = COMPILE_FILE2(extended_eventhandlers\InitPost.sqf);
SLX_XEH_initOthers = COMPILE_FILE2(extended_eventhandlers\InitOthers.sqf);
SLX_XEH_postInit = COMPILE_FILE2(extended_eventhandlers\PostInit.sqf);

SLX_XEH_DELAYED = [];
SLX_XEH_INIT_DELAYED = {
	private ["_unit", "_unitPlayable"];
	_unit = _this select 0;

	
	if (isNull _unit) exitWith {
		#ifdef DEBUG_MODE_FULL
			format["XEH BEG: (Bug #7432) %2 Null Object", time, _unit] call SLX_XEH_LOG;
		#endif
	};

	#ifdef DEBUG_MODE_FULL
		format["XEH BEG: (Bug #7432) %2 is now ready for init", time, _unit] call SLX_XEH_LOG;
	#endif

	_unitPlayable = _unit getVariable "SLX_XEH_PLAYABLE";
	if (isNil "_unitPlayable") then { _unitPlayable = false };

	// If unit already has the variable, it is a respawned unit.
	// Set by InitPost Man-eventhandler.
	if (_unitPlayable) then {
		[_unit, "Extended_Init_EventHandlers", true, true] call SLX_XEH_init; // is respawn
	} else {
		[_unit, "Extended_Init_EventHandlers", false, true] call SLX_XEH_init; // is not respawn
	};
};

// XEH for non XEH supported addons
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.

SLX_XEH_EVENTS_NAT = [XEH_EVENTS];
SLX_XEH_EXCLUDES = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.
SLX_XEH_PROCESSED_OBJECTS = []; // Used to maintain the list of processed objects
SLX_XEH_CLASSES = []; // Used to cache classes that have full XEH setup
SLX_XEH_FULL_CLASSES = []; // Used to cache classes that NEED full XEH setup
SLX_XEH_EXCL_CLASSES = []; // Used for exclusion classes

// Used by SupportMonitor
SLX_XEH_FNC_SUPPORTM = {
	private ["_obj", "_cfg", "_init", "_initAr", "_XEH", "_type", "_excl"];
	_obj = _this select 0;
	_type = typeOf _obj;

	if (_type in SLX_XEH_EXCL_CLASSES) exitWith { TRACE_2("Exclusion, abort (cache hit)",_obj,_type) };

	_excl = getNumber(configFile >> "CfgVehicles" >> _type >> "SLX_XEH_DISABLED") == 1;
	if !(_excl) then { { if (_obj isKindOf _x) exitWith { _excl = true } } forEach SLX_XEH_EXCLUDES };
	if (_excl) exitWith {
		TRACE_2("Exclusion, abort and caching",_obj,_type);
		PUSH(SLX_XEH_EXCL_CLASSES,_type);
	};

	_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

	// No EH class - Needs full XEH
	if !(isClass _cfg) exitWith {
		TRACE_2("Adding XEH Full and caching",_obj,_type);
		PUSH(SLX_XEH_FULL_CLASSES,_type);
		[_obj] call SLX_XEH_EH_Init;
	};

	// Check 2 - XEH init EH detected
	_XEH = false;
	_init = _cfg >> "init";
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

	if (_XEH) then {
		TRACE_2("Has XEH init",_obj,_type)
	} else {
		TRACE_2("Adding XEH init",_obj,_type);
		[_obj] call SLX_XEH_EH_Init;
	};
};

// Used on Init of all objects, not on respawn.
SLX_XEH_FNC_SUPPORTM2 = {
	private ["_obj", "_type", "_cfg", "_partial", "_full"];
	_obj = _this select 0;
	_type = typeOf _obj;

	// No XEH EH entries at all - Needs full XEH
	if (_type in SLX_XEH_FULL_CLASSES) exitWith {
		TRACE_2("Adding XEH Full (cache hit)",_obj,_type);
		{ _obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]] } forEach SLX_XEH_EVENTS_NAT;
	};

	// Already has Full XEH EH entries - Needs nothing!
	if (_type in SLX_XEH_CLASSES) exitWith { TRACE_2("Already XEH (cache hit)",_obj,_type) };

	_cfg = (configFile >> "CfgVehicles" >> _type >> "EventHandlers");

	// Add script-eventhandlers for those events that are not setup properly.
	_partial = false; _full = true;

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
		if !(_XEH) then {
			_partial = true;
			TRACE_3("Adding missing EH",_obj,_type,_x);
			_obj addEventHandler [_x, compile format["_this call SLX_XEH_EH_%1", _x]];
		};
	} forEach SLX_XEH_EVENTS_NAT;

	if !(_partial) then { TRACE_2("Caching",_obj,_type); PUSH(SLX_XEH_CLASSES,_type); };
	if (_full) then { TRACE_2("Caching (full)",_obj,_type); PUSH(SLX_XEH_FULL_CLASSES,_type); };
};

/*
* Process the crews of vehicles. This "thread" will run just
* before PostInit and the mission init.sqf is processed. The order of execution is
*
*  1) all config.cpp init EHs (including all Extended_Init_Eventhandlers)
*  2) all the init lines in the mission.sqm
*  3) spawn:ed "threads" are started
*  4) the mission's init.sqf/sqs is run
*/

GVAR(init_obj) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj) addEventHandler ["killed", {
	XEH_LOG("XEH: VehicleCrewInit: "+str(count vehicles));
	{
		_sim = getText(configFile/"CfgVehicles"/(typeOf _x)/"simulation");
		_crew = crew _x;
		/*
		* If it's a vehicle then start event handlers for the crew.
		* (Vehicles have crew and are neither humanoids nor game logics)
		*/
		if ((count _crew>0)&&{ _sim == _x }count["soldier", "invisible"] == 0) then
		{
			{ if !(_x in SLX_XEH_INIT_MEN) then { [_x] call SLX_XEH_EH_Init } } forEach _crew;
		};
	} forEach vehicles;
	SLX_XEH_INIT_MEN = nil;
	
	deleteVehicle GVAR(init_obj);GVAR(init_obj) = nil
}];

GVAR(init_obj) setDamage 1; // Schedule to run itsy bitsy later

// Prepare postInit
GVAR(init_obj2) = "HeliHEmpty" createVehicleLocal [0, 0, 0];
GVAR(init_obj2) addEventHandler ["killed", {
	call SLX_XEH_postInit;
	deleteVehicle GVAR(init_obj2);GVAR(init_obj2) = nil;
}];

// Schedule PostInit
[] spawn {
	// Warn if PostInit takes longer than 10 tickTime seconds
	[] spawn
	{
		private["_time2Wait"];
		_time2Wait = diag_ticktime + 10;
		waituntil {diag_ticktime > _time2Wait};
		if !(SLX_XEH_MACHINE select 8) then { XEH_LOG("WARNING: PostInit did not finish in a timely fashion"); };
	};

	// On Server + Non JIP Client, we are now after all objects have inited
	// and at the briefing, still time == 0
	if (isNull player) then
	{
		#ifdef DEBUG_MODE_FULL
		"NULL PLAYER" call SLX_XEH_LOG;
		#endif
		if !((SLX_XEH_MACHINE select 4) || (SLX_XEH_MACHINE select 6)) then // only if MultiPlayer and not dedicated
		{
			#ifdef DEBUG_MODE_FULL
			"JIP" call SLX_XEH_LOG;
			#endif
	
			SLX_XEH_MACHINE set [1, true]; // set JIP
			// TEST for weird jip-is-server-issue :S
			if (!(SLX_XEH_MACHINE select 2) || SLX_XEH_MACHINE select 3 || SLX_XEH_MACHINE select 4) then {
				str(["WARNING: JIP Client, yet wrong detection", SLX_XEH_MACHINE]) call SLX_XEH_LOG;
				SLX_XEH_MACHINE set [2, true]; // set Dedicated client
				SLX_XEH_MACHINE set [3, false]; // set server
				SLX_XEH_MACHINE set [4, false]; // set dedicatedserver
			};
			waitUntil { !(isNull player) };
		};
	};
	
	if !(isNull player) then
	{
		if (isNull (group player) && player isKindOf "CAManBase") then
		{
			// DEBUG TEST: Crashing due to JIP, or when going from briefing
			//			 into game
			#ifdef DEBUG_MODE_FULL
			"NULLGROUP" call SLX_XEH_LOG;
			#endif
			waitUntil { !(isNull (group player)) };
		};
		waitUntil { local player };
	};

	GVAR(init_obj2) setDamage 1; // Schedule to run itsy bitsy later
};


// Load and call any "pre-init", run-once event handlers
call COMPILE_FILE2(extended_eventhandlers\PreInit.sqf);
XEH_LOG("XEH: PreInit Finished");
