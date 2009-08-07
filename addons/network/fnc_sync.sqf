/*
Internal Function: CBA_network_fnc_sync
*/
#include "script_component.hpp"
private ["_channel"];
_channel = -1;
if !(isNil "_this") then
{
	if (count _this > 0) then { _channel = _this select 0 };
};

// COMPATIBILITY Feature - Check Override variables before broadcasting the sync. 
if !(GVAR(weatherSync_Disabled)) then { [_channel, {[QUOTE(GVAR(weather)), _this] call CBA_fnc_localEvent}, [overCast, fog, rain]] call CBA_fnc_globalExecute };
if !(GVAR(timeSync_Disabled)) then { [_channel, {[QUOTE(GVAR(date)), _this] call CBA_fnc_localEvent}, date] call CBA_fnc_globalExecute };
