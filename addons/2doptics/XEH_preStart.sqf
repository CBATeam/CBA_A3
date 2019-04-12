#include "script_component.hpp"

if (!hasInterface) exitWith {};

// Do not move this below these checks, or this missing function can be exploited.
PREP(initDisplayInterrupt);

if (configProperties [configFile >> "CBA_PIPItems"] isEqualTo []) exitWith {};
if (configProperties [configFile >> "CBA_CarryHandleTypes"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"
