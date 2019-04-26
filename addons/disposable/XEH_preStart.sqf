#include "script_component.hpp"

if (configProperties [configFile >> "CBA_DisposableLaunchers"] isEqualTo []) exitWith {};

#include "XEH_PREP.sqf"

if (!hasInterface) exitWith {};

PREP(initDisplayInventory);
