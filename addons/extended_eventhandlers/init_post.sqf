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
private ["_this"];
_this = nil;

#ifdef DEBUG_MODE_FULL
	"XEH BEG: PostInit" call SLX_XEH_LOG;
	str([player, group player, local player]) call SLX_XEH_LOG;
#endif

XEH_LOG("XEH: PostInit Started");

SLX_XEH_postInit = nil;

SLX_XEH_MACHINE set [5, true]; // set player check = complete
// format["(%2) SLX_XEH_MACHINE: %1", SLX_XEH_MACHINE, time] call SLX_XEH_LOG;


// Run General PostInit
{ (_x/"Extended_PostInit_EventHandlers") call FUNC(init_once) } forEach SLX_XEH_CONFIG_FILES;

// we set this BEFORE executing the inits, so that any unit created in another
// thread still gets their InitPost ran
SLX_XEH_MACHINE set [7, true];
{ [_x] call FUNC(init_delayed) } forEach SLX_XEH_DELAYED; // Run Delayed inits for man-based units
SLX_XEH_DELAYED = [];
{ _x call FUNC(init) } forEach SLX_XEH_OBJECTS; // Run InitPosts
SLX_XEH_OBJECTS = [];


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
XEH_LOG("XEH: PostInit Finished; " + str(SLX_XEH_MACHINE));

#ifdef DEBUG_MODE_FULL
	"XEH END: PostInit" call SLX_XEH_LOG;
#endif

nil;
