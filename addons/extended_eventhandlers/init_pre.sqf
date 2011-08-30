// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// No _this in pre/PostInit, also fixes call to init_compile
private "_this";
_this = nil;

private ["_id", "_cfgRespawn", "_respawn"];

// UNIQUE Session ID since start of game
_id = uiNamespace getVariable "SLX_XEH_ID";
if (isNil "_id") then { _id = 1 } else { INC(_id) };
uiNamespace setVariable ["SLX_XEH_ID", _id];

if (isNil "SLX_XEH_RECOMPILE") then { SLX_XEH_RECOMPILE = CACHE_DIS(xeh) };

// Compile all necessary scripts and start one vehicle crew initialisation thread
SLX_XEH_DisableLogging = isClass(configFile/"CfgPatches"/"Disable_XEH_Logging");
XEH_LOG("XEH: PreInit Started. v"+getText(configFile >> "CfgPatches" >> "Extended_Eventhandlers" >> "version"));
if (time > 0) then { XEH_LOG("XEH WARNING: Time > 0; This probably means there are no XEH compatible units by default on the map, perhaps add the SLX_XEH_Logic module.") };

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

SLX_XEH_STR = ""; // Empty string
SLX_XEH_STR_INIT_EH = "Extended_Init_EventHandlers";
SLX_XEH_STR_INIT_POST_EH = "Extended_InitPost_EventHandlers";
SLX_XEH_STR_PreInit = "Extended_PreInit_EventHandlers";
SLX_XEH_STR_PostInit = "Extended_PostInit_EventHandlers";
SLX_XEH_STR_DEH = "DefaultEventhandlers";
SLX_XEH_STR_TAG = "SLX_XEH_";

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
{ SLX_XEH_OTHER_EVENTS_PLAYERS set [_forEachIndex, compile format["{ _this call _x } forEach ((_this select 0)getVariable SLX_XEH_STR_%1_Player)", _x]] } forEach SLX_XEH_OTHER_EVENTS;

SLX_XEH_CONFIG_FILES = [configFile, campaignConfigFile, missionConfigFile];
SLX_XEH_CONFIG_FILES_VARIABLE = [campaignConfigFile, missionConfigFile];

SLX_XEH_DEF_CLASSES = [SLX_XEH_STR, "All"];

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


// Function Compilation

// Backup
_fnc_compile = uiNamespace getVariable "SLX_XEH_COMPILE";
if (isNil "_fnc_compile" || SLX_XEH_RECOMPILE) then { call compile preProcessFileLineNumbers 'extended_eventhandlers\init_compile.sqf' };

SLX_XEH_LOG = { XEH_LOG(_this); };

PREP(init_once); // Pre and PostInits

PREP(init_delayed);
PREP(init_playable);

// Inits and InitPosts
PREP(init);
PREP(init_enum);
PREP(init_enum_cache);
PREP(init_post);

// Init Others
PREP(init_others);
PREP(init_others_enum);
PREP(init_others_enum_cache);

PREP(addPlayerEvents); // Add / Remove the playerEvents
PREP(removePlayerEvents);
PREP(support_monitor);
PREP(support_monitor2);

call COMPILE_FILE(init_eh); // All XEH Event functions


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
	call COMPILE_FILE(init_post);
	deleteVehicle GVAR(init_obj2);GVAR(init_obj2) = nil;
}];

// Schedule PostInit
SLX_XEH_STR spawn {
	// Warn if PostInit takes longer than 10 tickTime seconds
	SLX_XEH_STR spawn
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
/*
	Compile code strings in the Extended_PreInit_EventHandlers class and call
	them. This is done once per mission and before any extended init event
	handler code is run. An addon maker can put run-once initialisation code
	in such a pre-init "EH" rather than in a normal XEH init EH which might be
	called several times.
*/
{ (_x/SLX_XEH_STR_PreInit) call FUNC(init_once) } forEach SLX_XEH_CONFIG_FILES;


XEH_LOG("XEH: PreInit Finished");
