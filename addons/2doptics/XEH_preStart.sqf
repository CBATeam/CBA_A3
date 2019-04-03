#include "script_component.hpp"

if (getNumber (configFile >> "CBA_useScriptedOpticsFramework") != 1) exitWith {};
if (!hasInterface) exitWith {};

#include "XEH_PREP.sqf"
