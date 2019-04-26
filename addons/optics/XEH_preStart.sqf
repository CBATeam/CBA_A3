#include "script_component.hpp"

// Do not move this below these checks, or this missing function can be exploited.
PREP(initDisplayInterrupt);

if (configProperties [configFile >> "CBA_PIPItems"] isEqualTo [] && {
    configProperties [configFile >> "CBA_CarryHandleTypes"] isEqualTo []
}) exitWith {};

#include "XEH_PREP.sqf"
