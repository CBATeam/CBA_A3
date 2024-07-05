#include "script_component.hpp"

// Do not move this below these checks, or this missing function can be exploited.
PREP(initDisplayInventory);

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

#include "XEH_PREP.hpp"
