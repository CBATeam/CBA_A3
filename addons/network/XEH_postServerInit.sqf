// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Why would we send __SERVER__ to an on PLAYER connected event,
// [["__SERVER__","0",objNull,true]] call CBA_fnc_globalEvent;

// Using a SVI so that even non CBA clients will announce
#define DATA [name player,getPlayerUID player,player,isClass(configFile>>'CfgPatches'>>'cba_main')]
CBA_logic setVehicleInit QUOTE(if(!isDedicated)then{[]spawn{waitUntil{player == player};GVAR(joinN) = DATA;publicVariable 'GVAR(joinN)'}});
processInitCommands;
