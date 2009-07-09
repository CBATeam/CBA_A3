/*
Internal Function: CBA_network_fnc_cv
*/
#include "script_component.hpp"
#define __scriptname fnc_cv
private ["_veh", "_pos", "_c", "_dir", "_object", "_varName", "_init", "_valid"];
PARAMS_2(_veh,_pos);
_c = count _this;
if (_c > 2) then { _dir = _this select 2 } else { _dir = 0 };
if (_c > 3) then { _varName = _this select 3 } else { _varName = "" };
if (_c > 4) then { _init = _this select 4 } else { _init = "" };
_object = null;

if !(isServer) then
{
	[0, { _this call FUNC(cv) }, _this] call CBA_fnc_remoteExecute;
	#ifdef DEBUG
	[format["Sending Vehicle Create Request: %1 to server", _this], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
} else {
	_object = _veh createVehicle _pos;
	_valid = !(isNull _object);
	if (_valid) then
	{
		_object setDir _dir;
		if (_varName != "") then
		{
			call compile format["%1 = _object; publicVariable '%1'", _varName];
			//_object setVehicleInit format["this setVehicleVarName '%1'; %1 = this", _varName];
		};
		if (_init != "") then
		{
			_object setVehicleInit _init;
			processInitCommands;
		};
	};
	private ["_idx", "_name", "_sid"];
	// _id value comes from GVAR(fnc_Exec)
	if (isNil "_id") then
	{
		_sid = 0;
		_name = "Server";
	} else {
		_name = _id;
	};
	#ifdef DEBUG
	[format["Received Vehicle Create Request: %1 from %2 (%3), %4: %5", _this, _sid, _name, _object, _valid], QUOTE(GVAR(__scriptname)), DEBUGSETTINGS] call CBA_fnc_Debug;
	#endif
};
