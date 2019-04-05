#include "script_component.hpp"

if (!hasInterface) exitWith {};
if (configProperties [configFile >> "CBA_PIPItems"] isEqualTo []) exitWith {};
if (configProperties [configFile >> "CBA_CarryHandleTypes"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"
