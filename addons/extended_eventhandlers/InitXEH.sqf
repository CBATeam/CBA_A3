// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// UNIQUE Session ID since start of game
private ["_id"];
_id = uiNamespace getVariable "SLX_XEH_ID";
if (isNil "_id") then { _id = 1 } else { INC(_id) };
uiNamespace setVariable ["SLX_XEH_ID", _id];

if (isNil "SLX_XEH_RECOMPILE") then { SLX_XEH_RECOMPILE = CACHE_DIS(xeh) };

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
	isMultiplayer && _respawn,      // 9 - Multiplayer && respawn?
	if (isDedicated) then { 0 } else { if (isServer) then { 1 } else { 2 } }, // Machine type (only 3 possible configurations)
	_id // SESSION_ID
];

// Backup
_fnc_compile = uiNamespace getVariable "SLX_XEH_COMPILE";
if (isNil "_fnc_compile" || SLX_XEH_RECOMPILE) then { nil call compile preProcessFileLineNumbers 'extended_eventhandlers\init_compile.sqf' };

SLX_XEH_objects = [];
SLX_XEH_INIT_MEN = [];
SLX_XEH_OTHER_EVENTS = [XEH_EVENTS,XEH_CUSTOM_EVENTS]; // All events except the init event

SLX_XEH_OTHER_EVENTS_FULL = [];
{ SLX_XEH_OTHER_EVENTS_FULL set [_forEachIndex, format["Extended_%1_EventHandlers", _x]] } forEach SLX_XEH_OTHER_EVENTS;
SLX_XEH_OTHER_EVENTS_XEH = [];
{ SLX_XEH_OTHER_EVENTS_XEH set [_forEachIndex, format["Extended_%1EH", _x]] } forEach SLX_XEH_OTHER_EVENTS;
SLX_XEH_OTHER_EVENTS_XEH_PLAYERS = [];
{ SLX_XEH_OTHER_EVENTS_XEH_PLAYERS set [_forEachIndex, format["Extended_%1EH_Player", _x]] } forEach SLX_XEH_OTHER_EVENTS;
SLX_XEH_OTHER_EVENTS_PLAYERS = [];
{ SLX_XEH_OTHER_EVENTS_PLAYERS set [_forEachIndex, compile format["{ _this call _x } forEach ((_this select 0)getVariable 'Extended_%1EH_Player')", _x]] } forEach SLX_XEH_OTHER_EVENTS;

SLX_XEH_CONFIG_FILES = [configFile, campaignConfigFile, missionConfigFile];
SLX_XEH_CONFIG_FILES_VARIABLE = [campaignConfigFile, missionConfigFile];
SLX_XEH_INIT_TYPES = ["all", "server", "client"];
SLX_XEH_DEF_CLASSES = ["", "All"];

SLX_XEH_LOG = { XEH_LOG(_this); };

PREP(init_once); // Pre and PostInit
PREP(init_delayed);
PREP(addPlayerEvents); // Add / Remove the playerEvents
PREP(removePlayerEvents);
PREP(init_playable);
PREP(support_monitor);
PREP(support_monitor2);

SLX_XEH_init = COMPILE_FILE2(extended_eventhandlers\Init.sqf);
SLX_XEH_initPost = COMPILE_FILE2(extended_eventhandlers\InitPost.sqf);
SLX_XEH_initOthers = COMPILE_FILE2(extended_eventhandlers\InitOthers.sqf);
SLX_XEH_postInit = COMPILE_FILE2(extended_eventhandlers\PostInit.sqf);

PREP(init_enum);
PREP(init_enum_cache);
PREP(init_others_enum);
PREP(init_others_enum_cache);

// The actual XEH functions that are called from within the engine eventhandlers.
// This can also be uesd for better debugging
#ifdef DEBUG_MODE_FULL
	#define XEH_FUNC_NORMAL(A) SLX_XEH_EH_##A = { if ('A' in ['Respawn', 'MPRespawn', 'Killed', 'MPKilled', 'Hit', 'MPHit']) then { diag_log ['A',_this, local (_this select 0), typeOf (_this select 0)] }; { _this call _x }forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif
#ifndef DEBUG_MODE_FULL
	#define XEH_FUNC_NORMAL(A) SLX_XEH_EH_##A = { { _this call _x }forEach((_this select 0)getVariable'Extended_##A##EH') }
#endif

#define XEH_FUNC_PLAYER(A) SLX_XEH_EH_##A##_Player = { { _this call _x }forEach((_this select 0)getVariable'Extended_##A##EH_Player') }

#define XEH_FUNC(A) XEH_FUNC_NORMAL(A); XEH_FUNC_PLAYER(A)

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
XEH_FUNC(FiredBis);

SLX_XEH_EH_Init = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init };
SLX_XEH_EH_RespawnInit = { PUSH(SLX_XEH_PROCESSED_OBJECTS,_this select 0); [_this select 0, "Extended_Init_EventHandlers", true] call SLX_XEH_init };
SLX_XEH_EH_GetInMan = { {[_this select 2, _this select 1, _this select 0] call _x }forEach((_this select 2)getVariable'Extended_GetInManEH') };
SLX_XEH_EH_GetOutMan = { {[_this select 2, _this select 1, _this select 0] call _x }forEach((_this select 2)getVariable'Extended_GetOutManEH') };
SLX_XEH_EH_Fired =
{
	#ifdef DEBUG_MODE_FULL
		// diag_log ['Fired',_this, local (_this select 0), typeOf (_this select 0)];
	#endif
	_this call SLX_XEH_EH_FiredBis;
	_feh = ((_this select 0)getVariable'Extended_FiredEH');
	if (count _feh > 0) then { 
		_c=count _this;
		if(_c<6)then{_this set[_c,nearestObject[_this select 0,_this select 4]];_this set[_c+1,currentMagazine(_this select 0)]}else{_this = +_this; _mag=_this select 5;_this set[5,_this select 6];_this set[6,_mag]};
		{_this call _x } forEach _feh;
	};
};

SLX_XEH_DELAYED = [];

// XEH for non XEH supported addons
// Only works until someone uses removeAllEventhandlers on the object
// Only works if there is at least 1 XEH-enabled object on the Map - Place SLX_XEH_Logic to make sure XEH initializes.
// TODO: Perhaps do a config verification - if no custom eventhandlers detected in _all_ CfgVehicles classes, don't run this XEH handler - might be too much processing.
SLX_XEH_EVENTS_NAT = [XEH_EVENTS];
SLX_XEH_EVENTS_FULL_NAT = [];
{ SLX_XEH_EVENTS_FULL_NAT set [_forEachIndex, format["Extended_%1_EventHandlers", _x]] } forEach SLX_XEH_EVENTS_NAT;

SLX_XEH_EXCLUDES = ["LaserTarget"]; // TODO: Anything else?? - Ammo crates for instance have no XEH by default due to crashes) - however, they don't appear in 'vehicles' list anyway.
SLX_XEH_PROCESSED_OBJECTS = []; // Used to maintain the list of processed objects
SLX_XEH_CLASSES = []; // Used to cache classes that have full XEH setup
SLX_XEH_FULL_CLASSES = []; // Used to cache classes that NEED full XEH setup
SLX_XEH_EXCL_CLASSES = []; // Used for exclusion classes


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
