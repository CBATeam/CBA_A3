//#define DEBUG_MODE_FULL
#include "script_component.hpp"
LOG(MSG_INIT);
// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

// Use Function that can be called using BIS_fnc_MP so that even non CBA clients will announce
[nil, QGVAR(sendPlayerID),true, true] spawn BIS_fnc_MP;
//TRACE_2("",cba_network_joinN,cba_network_sendPlayerID);

//CBA_logic setVehicleInit QUOTE(if(!isDedicated)then{[]spawn{waitUntil{player == player};GVAR(joinN) = DATA;publicVariable 'GVAR(joinN)'}});
//processInitCommands;

// Announce the completion of the initialization of the script
ADDON = true;