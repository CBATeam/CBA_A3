/*  PostInit.sqf

	Compile code strings in the Extended_PostInit_EventHandlers class and call
	them. This is done once per mission and after all the extended init event
	handler code is run. An addon maker can put run-once, late initialisation
	code in such a post-init "EH" rather than in a normal XEH init EH which
	might be called several times.
*/
// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// No _this in pre/PostInit, also fixes call to init_compile
private "_this";
_this = nil;

#ifdef DEBUG_MODE_FULL
	"XEH BEG: PostInit" call SLX_XEH_LOG;
	str([player, group player, local player]) call SLX_XEH_LOG;
#endif

XEH_LOG("XEH: PostInit Started");

// format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time] call SLX_XEH_LOG;


// Run General PostInit
{ (_x/SLX_XEH_STR_PostInit) call FUNC(init_once) } forEach SLX_XEH_CONFIG_FILES;

// we set this BEFORE executing the inits, so that any unit created in another
// thread still gets their InitPost ran
SLX_XEH_MACHINE set [7, true];
{ [_x] call FUNC(init_delayed) } forEach SLX_XEH_DELAYED; // Run Delayed inits for man-based units
SLX_XEH_DELAYED = nil;
{ _x call FUNC(init) } forEach SLX_XEH_OBJECTS; // Run InitPosts
SLX_XEH_OBJECTS = nil;


if (!isDedicated && {!isNull player}) then { // isNull player check is for Main Menu situation.
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	SLX_XEH_STR spawn {
		private ["_ready"];
		waitUntil {_ready = player getVariable "SLX_XEH_READY"; (!isNil "_ready" && {_ready})};
		_lastPlayer = player;
		_lastPlayer call FUNC(addPlayerEvents);
		#ifdef DEBUG_MODE_FULL
			str(["Running Player EH check", _lastPlayer]) call SLX_XEH_LOG;
		#endif
		// switched away frmo scheduler loop to PFH system for re-adding additional events.
		_fnc = {
            _params = _this select 0;
            _lastPlayer = _params select 0;
            
			if(player != _lastPlayer) then {
                _lastPlayer call FUNC(removePlayerEvents);
                // set _lastPlayer entry to player, even if null
                _params set[0, player];
            };
            // check if player is not null and not equal to last player (if it was null, then it will be different)
			if(!(isNull player) && player != _lastPlayer) then {
                // set _lastPlayer to guranateed NOT null object, this resets the two cycle check
                _params set[0, player];
                #ifdef DEBUG_MODE_FULL
                    str(["New Player", player, _lastPlayer]) call SLX_XEH_LOG;
                #endif
                player call FUNC(addPlayerEvents);
            };
		};
        [_fnc, 0.1, [player]] call cba_fnc_addPerFrameHandler;
	};
};

// XEH for non XEH supported addons
//SLX_XEH_STR spawn COMPILE_FILE2(\x\cba\addons\xeh\supportMonitor.sqf);

SLX_XEH_MACHINE set [8, true];

_fnc_prettyXEH = {
	private ["_mpRespawn", "_machineType", "_sessionId", "_level", "_timeOut", "_game", "_str"];
	EXPLODE_9(SLX_XEH_MACHINE,_isClient,_isJip,_isDedClient,_isServer,_isDedServer,_playerCheckDone,_sp,_startInitDone,_postInitDone);
	_mpRespawn = SLX_XEH_MACHINE select 9;
	_machineType = SLX_XEH_MACHINE select 10;
	_sessionId = SLX_XEH_MACHINE SELECT 11;
	_level = SLX_XEH_MACHINE SELECT 12;
	_timeOut = SLX_XEH_MACHINE SELECT 13;
	_game = SLX_XEH_MACHINE SELECT 14;

	_str = (PFORMAT_9("State",_isClient,_isJip,_isDedClient,_isServer,_isDedServer,_playerCheckDone,_sp,_startInitDone,_postInitDone) +
	", _mpRespawn="+str(_mpRespawn)+", _machineType="+str(_machineType)+", _sessionId="+str(_sessionId)+", _level="+str(_level)+", _timeOut="+str(_timeOut)+", _game="+str(_game));

	if !(isNil "CBA_logic") then {
		_str = _str + (", BIS_functions="+str(CBA_logic)+", group="+str(group CBA_logic));
	};

	if (!isDedicated) then { 
		_str = _str + (", player="+str(player)+", _playerType="+str(typeOf player)+", _playerGroup="+str(group player));
		if (!isNull player && {vehicle player != player}) then { _str = _str + (", _playerVehicle="+str(vehicle player)+", _playerVehicleType="+str(typeOf (vehicle player))) };
	};

	_str;
};

XEH_LOG("XEH: PostInit Finished. " + (call _fnc_prettyXEH));

#ifdef DEBUG_MODE_FULL
	[] spawn {
		while { true } do {
			_str = str(["XEH DBG: Units, Vehiclse, Groups, AllDead count",
				count allUnits,
				count vehicles,
				count allGroups,
				count allDead]);
			LOG(_str);

			_str = str(["XEH DBG: CBA Cache Keys count",
				count SLX_XEH_CACHE_KEYS,
				count SLX_XEH_CACHE_KEYS2,
				count SLX_XEH_CACHE_KEYS3,
				count CBA_CACHE_KEYS]);
			LOG(_str);
			
			_str = str(["XEH DBG: XEH Monitor count",
				count SLX_XEH_CLASSES,
				count SLX_XEH_FULL_CLASSES,
				count SLX_XEH_EXCL_CLASSES,
				isNil "SLX_XEH_OBJECTS",
				isNil "SLX_XEH_DELAYED",
				isNil "SLX_XEH_INIT_MEN"]);
			LOG(_str);

			sleep 10;
		};
	};
#endif

#ifdef DEBUG_MODE_CACHE
	diag_log ["Calculating mem usage, for keys: ", count SLX_XEH_CACHE_KEYS, count SLX_XEH_CACHE_KEYS2, count SLX_XEH_CACHE_KEYS3, count CBA_CACHE_KEYS];
	_c1 = 0; _c2 = 0; _c3 = 0; _c4 = 0;
	{ _str = uiNamespace getVariable (SLX_XEH_STR_TAG + _x + "Extended_Init_Eventhandlers"); if (isNil "_str") then { diag_log ["Warn1", _x, "doesnt exist"] } else { _str = str(_str); ADD(_c1,count (toArray _str)) } } forEach SLX_XEH_CACHE_KEYS;
	{ _str = uiNamespace getVariable (SLX_XEH_STR_TAG + _x + "Extended_InitPost_Eventhandlers"); if (isNil "_str") then { diag_log ["Warn2", _x, "doesnt exist"] } else { _str = str(_str); ADD(_c2,count (toArray _str)) } } forEach SLX_XEH_CACHE_KEYS2;
	{ _str = uiNamespace getVariable ("SLX_XEH_" + _x); if (isNil "_str") then { diag_log ["Warn3", _x, "doesnt exist"] } else { _str = str(_str); ADD(_c3,count (toArray _str)) } } forEach SLX_XEH_CACHE_KEYS3;
	{ _str = uiNamespace getVariable _x; if (isNil "_str") then { diag_log ["Warn4", _x, "doesnt exist"] } else { _str = str(_str); ADD(_c4,count (toArray _str)) } } forEach CBA_CACHE_KEYS;
	diag_log ["Done calculating mem usage"];
	diag_log ["Usage: ", _c1, _c2, _c3, _c4];
#endif

#ifdef DEBUG_MODE_FULL
	"XEH END: PostInit" call SLX_XEH_LOG;
#endif

nil;
