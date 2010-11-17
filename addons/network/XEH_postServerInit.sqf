// #define DEBUG_MODE_FULL
#include "script_component.hpp"

// Using a SVI so that even non CBA clients will announce
#define DATA [player,name player,isClass(configFile>>'CfgPatches'>>'cba_main')]
CBA_logic setVehicleInit QUOTE(if(!isDedicated)then{[]spawn{waitUntil{player == player};GVAR(join) = DATA;publicVariable 'GVAR(join)'}});
processInitCommands;
