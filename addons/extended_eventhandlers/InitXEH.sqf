//#define DEBUG_MODE_FULL
#include "script_component.hpp"

LOG("XEH: PreInit Started");

// Start one vehicle crew initialisation thread and one respawn monitor
SLX_XEH_objects = [];
// All events except the init event
SLX_XEH_OTHER_EVENTS = [
	"AnimChanged", "AnimStateChanged", "AnimDone", "Dammaged", "Engine",
	"Fired", "FiredNear", "Fuel", "Gear", "GetIn", "GetOut", "Hit",
	"IncomingMissile", "Killed", "LandedTouchDown", "LandedStopped" //,
	//"HandleDamage", "HandleHealing"
];

SLX_XEH_init = compile preProcessFileLineNumbers "extended_eventhandlers\Init.sqf";
SLX_XEH_initPost = compile preProcessFileLineNumbers "extended_eventhandlers\InitPost.sqf";
SLX_XEH_initOthers = compile preProcessFileLineNumbers "extended_eventhandlers\InitOthers.sqf";
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
	0      // 9 - counter used to assign a vehicleVarName to unnamed playable
	       //     units so they can be tracked. See RespawnMonitor.sqf
];
SLX_XEH_F_INIT = {
	private [
		"_i", "_c", "_entry", "_entryServer", "_entryClient", "_Inits"
	];
	_Inits = [];
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH BEG: Init %1", _this];
	LOG(_msg);
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
				if (isServer) then
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
				LOG(_x);
			#endif
			call _x;
		} forEach _Inits;	   
	};
	#ifdef DEBUG_MODE_FULL
	_msg = format["XEH END: Init %1", _this];
	LOG(_msg);
	#endif
};

// Add / Remove the playerEvents
SLX_XEH_F_ADDPLAYEREVENTS = {
	{ _event = format["Extended_%1EH",_x]; _this setVariable [(_this getVariable _event) select 0, compile format["_this call ((_this select 0) getVariable '%1_Player')",_event]] } forEach SLX_XEH_OTHER_EVENTS;
};
SLX_XEH_F_REMOVEPLAYEREVENTS = {
	{ _event = format["Extended_%1EH",_x]; _this setVariable [(_this getVariable _event) select 0] } forEach SLX_XEH_OTHER_EVENTS;
};


// Load and call any "pre-init", run-once event handlers
call compile preprocessFileLineNumbers "extended_eventhandlers\PreInit.sqf";
LOG("XEH: PreInit Finished");

/*
* Process the crews of vehicles. This "thread" will run just
* before the mission init.sqf is processed. The order of execution is
*
*  1) all config.cpp init EHs (including all Extended_Init_Eventhandlers)
*  2) all the init lines in the mission.sqm
*  3) spawn:ed "threads" are started
*  4) the mission's init.sqf/sqs is run
*/
_cinit = [] spawn
{
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
	LOG("XEH: PostInit Started");
	call compile preProcessFileLineNumbers "extended_eventhandlers\PostInit.sqf";
	LOG("XEH: PostInit Finished");
};
