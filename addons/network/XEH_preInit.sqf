#include "script_component.hpp"
/* CBA_Network - by Sickboy (sb_at_dev-heaven.net)
 * --------------------------------------------------------------
 * Enables network engine support to execute code over the network
 * or make a global say command
 *
 * Notes:
 * - Each player has a unique 'id', server has always id 0
 * - PublicVariableEventHandlers do not 'fire' on the computer where you PV the variable. As such we execute the functions also on the computer who calls
 *
 * Examples:
 * - If you want a unit1,unit2, unit3 to say something on every computer:
 * [ [unit1, unit2, unit3], "TestSound" ] call cba_network_fSay;
 * unit1, 2 and 3 would say "TestSound" (if it existed :p)
 *
 * - To execute sth on server:
 * [ 0, { superDebugMode = true } ] call cba_network_fSend;
 *
 * - To execute sth on all clients:
 * [ -1, { superDebugMode = true; player sideChat "Woah A.C.E!!" }] call cba_network_fSend;
 *
 * - To execute sth on all clients, unit1, unit2, unit3 write something
 * [ -1, { superDebugMode = true; { _x sideChat "Woah A.C.E!!" } forEach _this }, [unit1, unit2, unit3]] call cba_network_fSend;
 *
 * - To execute sth on all clients and server, use destination -2
 * - To execute sth on all clients and server, EXCEPT the sending node, use destination -3
 *   You can always use if (!isServer) then {  }; in the code or function you execute through the net-engine
*/
#define CHANGETIME 5

LOG(MSG_INIT);

// Announce the initialization of the script
ADDON = false;

#ifdef DEBUG_MODE_FULL
	ISNIL(debug,true);
#else
	ISNIL(debug,false);
#endif


// COMPATIBILITY Feature - Make sure Override variables are initialized appropriately for sync broadcast.
ISNIL(timeSync_Disabled,false); // deprecated
ISNIL(weatherSync_Disabled,false);

PREP(exec);
//PREP(cv);

DEPRECATE(fnc_remoteExecute,fnc_globalExecute);
DEPRECATE(fnc_remoteSay,fnc_globalSay);


#define ADD_PERSISTENT_MARKER { [_this select 0, true] call CBA_fnc_setMarkerPersistent }
OBSOLETE(fnc_addPersistentMarker,ADD_PERSISTENT_MARKER);
#define REMOVE_PERSISTENT_MARKER { [_this select 0, false] call CBA_fnc_setMarkerPersistent }
OBSOLETE(fnc_removePersistentMarker,REMOVE_PERSISTENT_MARKER);

// TODO: Add functions that add to opc/opd, instead of direct handling?

GVAR(init) = false;

if (SLX_XEH_MACHINE select 3) then
{
	ISNIL(MARKERS,[]); // Sync Markers for JIP

	PREP(opc);
	PREP(opd);
	PREP(sync);

	FUNC(id) = { "server" };

	[QUOTE(GVAR(opc)), { _this call FUNC(opc) }] call CBA_fnc_addEventHandler;
	[QUOTE(GVAR(opd)), { _this call FUNC(opd) }] call CBA_fnc_addEventHandler;
	QUOTE(GVAR(joinN)) addPublicVariableEventHandler {
		[QUOTE(GVAR(opc)), _this select 1] call CBA_fnc_localEvent;
	};

	[QUOTE(GVAR(marker_persist)), { _this call CBA_fnc_setMarkerPersistent }] call CBA_fnc_addEventHandler;

	// [QUOTE(GVAR(join)), { [QUOTE(GVAR(opc)), _this] call CBA_fnc_localEvent }] call CBA_fnc_addEventHandler;

	// onPlayerConnected '[_name,_id] call FUNC(opc)';
	// TODO: Handle OPD without actually using opd
	// Disabled for now, either not used, or annoying to mission makers
	// onPlayerDisconnected '[_name,_id] call FUNC(opd)';

	// Looped Weather Sync
	/*
	SLX_XEH_STR spawn
	{
		// Every 60 Seconds weather sync
		while { true } do
		{
			sleep 60;
			call FUNC(sync);
		};
	};
	*/
} else {
	FUNC(id) =
	{
		private ["_id"];
		if (player == player) then
		{
			_id = str(player);
		} else {
			_id = "client";
		};
		_id
	};
};

[QUOTE(GVAR(cmd)), { if (GVAR(init)) then { _this spawn FUNC(exec) } }] call CBA_fnc_addEventHandler;
[QUOTE(GVAR(say)), { private "_say"; _say = _this; { _x say (_say select 1) } forEach (_say select 0) }] call CBA_fnc_addEventHandler;
[QUOTE(GVAR(say3d)), { private "_say"; _say = _this; if (count _this > 2) then { if ((positionCameraToWorld [0,0,0]) distance (_say select 0) <= (_say select 2)) then { (_say select 0) say3d (_say select 1) } } else { (_say select 0) say3d (_say select 1) } }] call CBA_fnc_addEventHandler;
[QUOTE(GVAR(weather)), { private "_weather"; _weather = _this; CHANGETIME setOverCast (_weather select 0); CHANGETIME setRain (_weather select 2); (_weather select 1) spawn { sleep (CHANGETIME + 2); CHANGETIME setFog _this } }] call CBA_fnc_addEventHandler;
[QUOTE(GVAR(date)), { private "_date"; _date = _this; setDate _date }] call CBA_fnc_addEventHandler;

GVAR(init) = true; // Deprecated

// Announce the completion of the initialization of the script
ADDON = true;
