#include "script_component.hpp"
GVAR(weather) = [overCast, fog, rain];
GVAR(date) = date;

// COMPATIBILITY Feature - Check Override variables before broadcasting the sync. 
if !(GVAR(WeatherSync_Disabled)) then { publicVariable QUOTE(GVAR(weather)) };
if !(GVAR(TimeSync_Disabled)) then { publicVariable QUOTE(GVAR(date)) };
