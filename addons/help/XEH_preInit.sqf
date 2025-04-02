//#define DEBUG_MODE_FULL
#include "script_component.hpp"

ADDON = false;

if (!hasInterface) exitWith {
    ADDON = true;
};

// bwc
FUNC(help) = BIS_fnc_help;

ADDON = true;
