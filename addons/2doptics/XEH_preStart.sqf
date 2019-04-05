#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (configProperties [configFile >> "CBA_CfgPIPItems"] isEqualTo []) exitWith {};
if (configProperties [configFile >> "CBA_CfgCarryHandleTypes"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"
