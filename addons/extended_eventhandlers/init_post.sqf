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

SLX_XEH_MACHINE set [5, true]; // set player check = complete
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


if (!isDedicated && !isNull player) then { // isNull player check is for Main Menu situation.
	// Doing this before the spawn so we pull this into the PostInit, halted simulation state, for the initial player.
	SLX_XEH_STR spawn {
		private ["_ready"];
		waitUntil {_ready = player getVariable "SLX_XEH_READY"; if (isNil "_ready") then { _ready = false }; _ready};
		_lastPlayer = player;
		_lastPlayer call FUNC(addPlayerEvents);
		#ifdef DEBUG_MODE_FULL
			str(["Running Player EH check", _lastPlayer]) call SLX_XEH_LOG;
		#endif
		// TODO: Perhaps this is possible in some event-style fashion, which would add the player events asap, synchronous.
		// (though perhaps not possible like teamswitch, besides, player == _unit is probably false at (preInit)?
		// TODO: Perhaps best run the statements in 'delayLess' FSM (or completely in delaylessLoop), synchronous, unscheduled?
		// TODO: Evaluate with respawn...
		while {true} do {
			waitUntil {sleep 0.5; player != _lastPlayer};
			_lastPlayer call FUNC(removePlayerEvents);
			waitUntil {sleep 0.5; !(isNull player)};
			_newPlayer = player;
			#ifdef DEBUG_MODE_FULL
				str(["New Player", _newPlayer, _lastPlayer]) call SLX_XEH_LOG;
			#endif
			_newPlayer call FUNC(addPlayerEvents);
			_lastPlayer = _newPlayer;
		};
	};
};

// XEH for non XEH supported addons
SLX_XEH_STR spawn COMPILE_FILE2(\extended_eventhandlers\supportMonitor.sqf);

SLX_XEH_MACHINE set [8, true];

_fnc_prettyXEH = {
	private ["_mpRespawn", "_machineType", "_sessionId", "_str"];
	EXPLODE_9(SLX_XEH_MACHINE,_isClient,_isJip,_isDedClient,_isServer,_isDedServer,_playerCheckDone,_sp,_startInitDone,_postInitDone);
	_mpRespawn = SLX_XEH_MACHINE select 9;
	_machineType = SLX_XEH_MACHINE select 10;
	_sessionId = SLX_XEH_MACHINE SELECT 11;

	_str = (PFORMAT_9("State",_isClient,_isJip,_isDedClient,_isServer,_isDedServer,_playerCheckDone,_sp,_startInitDone,_postInitDone) +
	", _mpRespawn="+str(_mpRespawn)+", _machineType="+str(_machineType)+", _sessionId="+str(_sessionId));

	if !(isNil "CBA_logic") then {
		_str = _str + (", BIS_functions="+str(CBA_logic)+", group="+str(group CBA_logic));
	};

	if (!isDedicated) then { 
		_str = _str + (", player="+str(player)+", _playerType="+str(typeOf player)+", _playerGroup="+str(group player));
		if (!isNull player && vehicle player != player) then { _str = _str + (", _playerVehicle="+str(vehicle player)+", _playerVehicleType="+str(typeOf (vehicle player))) };
	};

	_str;
};

XEH_LOG("XEH: PostInit Finished. " + (call _fnc_prettyXEH));

#ifdef DEBUG_MODE_FULL
	"XEH END: PostInit" call SLX_XEH_LOG;
#endif

nil;
