/*
Internal Function: CBA_network_fnc_sync
*/
#include "script_component.hpp"

// COMPATIBILITY Feature - Check Override variables before broadcasting the sync.
if !(GVAR(weatherSync_Disabled)) then { [QGVAR(weather), [overCast, fog, rain]] call CBA_fnc_globalEvent };
//if !(GVAR(timeSync_Disabled)) then { [_channel, {[QGVAR(date), _this] call CBA_fnc_localEvent}, date] call CBA_fnc_globalExecute };
