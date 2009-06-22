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

["Initializing...", QUOTE(ADDON), DEBUG_SETTINGS] call CBA_fDebug;

// Announce the initialization of the script
ADDON = false;

ISNIL(debug,false);

// COMPATIBILITY Feature - Make sure Override variables are initialized appropriately for sync broadcast. 
ISNIL(TimeSync_Disabled,false);
ISNIL(WeatherSync_Disabled,false);

PREPMAIN(fnc_RemoteSay);
PREPMAIN(fnc_RemoteExecute);
PREP(fnc_Exec);
PREP(fnc_CV);

// TODO: Add functions that add to opc/opd, instead of direct handling?

GVAR(INIT) = false;

if (isServer) then
{
	ISNIL(OPC,[]); // OnPlayerConnected Code array to execute after player connected and had small delay
	ISNIL(OPCB,[]); // onPlayerConnected Code Array to execute immediately on player connect
	ISNIL(OPD,[]); // OnPlayerDisConnected Code array to execute after a player is recognized
	ISNIL(MARKERS,[]); // Sync Markers for JIP

	PREP(fnc_Opc);
	PREP(fnc_Opd);
	PREP(fnc_Sync);
	
	GVAR(fnc_Id) = { "server" };
	
	[QUOTE(GVAR(join)), { _this CALL(fnc_Opc) }] CALLMAIN(addEventHandler);

	// onPlayerConnected '[_name,_id] CALL(fnc_Opc)';
	// TODO: Handle OPD without actually using opd
	onPlayerDisconnected '[_name,_id] CALL(fnc_Opd)';

	// Weather and Time Sync
	[] spawn
	{
		// Add Weather / Date sync to OPC
		waitUntil { time > 0 };
		GVAR(OPC) =
		[
			{ [] spawn { sleep 5; CALL(fnc_Sync); { _x setMarkerPos (getMarkerPos _x) } forEach GVAR(MARKERS) } }
		] + GVAR(OPC);

		// Every 60 Seconds date/weather sync
		while { true } do
		{
			sleep 60;
			CALL(fnc_Sync);
		};
	};
} else {
	GVAR(fnc_Id) =
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

[GVAR(cmd), { if (GVAR(init)) then { _this SPAWN(fnc_Exec) } }] CALLMAIN(addEventHandler);

QUOTE(GVAR(say)) addPublicVariableEventHandler { if (!isDedicated) then { private ["_ar"]; _ar = _this select 1; { _x say (_ar select 1) } forEach (_ar select 0) } };
QUOTE(GVAR(weather)) addPublicVariableEventHandler { _weather = _this select 1; CHANGETIME setOverCast (_weather select 0); CHANGETIME setRain (_weather select 2); (_weather select 1) spawn { sleep (CHANGETIME + 2); CHANGETIME setFog _this } };
QUOTE(GVAR(date)) addPublicVariableEventHandler { _date = _this select 1; setDate _date };

GVAR(INIT) = true; // Deprecated

// Announce the completion of the initialization of the script
ADDON = true;