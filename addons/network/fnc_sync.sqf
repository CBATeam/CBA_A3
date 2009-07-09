/*
Internal Function: CBA_network_fnc_sync
*/
#include "script_component.hpp"
GVAR(weather) = [overCast, fog, rain];
GVAR(date) = date;

// COMPATIBILITY Feature - Check Override variables before broadcasting the sync. 
if !(GVAR(weatherSync_Disabled)) then { publicVariable QUOTE(GVAR(weather)) };
if !(GVAR(timeSync_Disabled)) then { publicVariable QUOTE(GVAR(date)) };
