// #define DEBUG_MODE_FULL
#include "script_component.hpp"

XEH_LOG("XEH: PreInit Started. v"+getText(configFile >> "CfgPatches" >> "Extended_Eventhandlers" >> "version"));

// Start one vehicle crew initialisation thread and one respawn monitor
SLX_XEH_objects = [];
// All events except the init event
SLX_XEH_OTHER_EVENTS = [XEH_EVENTS,XEH_CUSTOM_EVENTS];

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
	if (isNull _this) exitWith {}; // not a valid object
	{ _event = format["Extended_%1EH",_x]; _this setVariable [_event, [(_this getVariable _event) select 0, compile format["_this call ((_this select 0) getVariable '%1_Player')",_event]]] } forEach SLX_XEH_OTHER_EVENTS;
};
SLX_XEH_F_REMOVEPLAYEREVENTS = {
	if (isNull _this) exitWith {}; // not a valid object
	{ _event = format["Extended_%1EH",_x]; _this setVariable [_event, [(_this getVariable _event) select 0]] } forEach SLX_XEH_OTHER_EVENTS;
};

SLX_XEH_F_CONVERT_FIRED_EH = {
	_ar = +_this;
	_mag = _ar select 6;
	_ar set [6, _ar select 5];
	_ar set [5, _mag];
	_ar;
};

// The actual XEH functions that are called from within the engine eventhandlers.
// This can also be uesd for better debugging
#define XEH_FUNC(A) SLX_XEH_EH_##A = { {_this call _x}forEach((_this select 0)getVariable'Extended_##A##EH') }

SLX_XEH_EH_Init = { [_this select 0,'Extended_Init_EventHandlers']call SLX_XEH_init; };
SLX_XEH_EH_Fired = { _par = +_this;_c=count _par;if(_c<6)then{_par set[_c,nearestObject[_par select 0,_par select 4]];_par set[_c+1,currentMagazine(_par select 0)]}else{_mag=_par select 5;_par set[5,_par select 6];_par set[6,_mag]};{_par call _x}forEach((_par select 0)getVariable'Extended_FiredEH') };
SLX_XEH_EH_GetInMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetInManEH') };
SLX_XEH_EH_GetOutMan = { {[_this select 2, _this select 1, _this select 0] call _x}forEach((_this select 2)getVariable'Extended_GetOutManEH') };

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
XEH_FUNC(landedStopped);


// Load and call any "pre-init", run-once event handlers
call compile preprocessFileLineNumbers "extended_eventhandlers\PreInit.sqf";
XEH_LOG("XEH: PreInit Finished");

// Loading Screen used during PostInit - terminated in PostInit.sqf
_text = "Post Initialization Processing...";
if !(isDedicated) then
{
	// Black screen behind loading screen
	4711 cutText ["", "BLACK OUT", 0.01];

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
};
startLoadingScreen [_text, "RscDisplayLoadMission"];

/*
* Process the crews of vehicles. This "thread" will run just
* before the mission init.sqf is processed. The order of execution is
*
*  1) all config.cpp init EHs (including all Extended_Init_Eventhandlers)
*  2) all the init lines in the mission.sqm
*  3) spawn:ed "threads" are started
*  4) the mission's init.sqf/sqs is run
*/
_cinit = [] spawn compile preProcessFileLineNumbers "extended_eventhandlers\PostInit.sqf";
