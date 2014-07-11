/*
Internal Function: CBA_network_fnc_cv
*/
#define DEBUG_MODE_FULL
#include "script_component.hpp"
#define __scriptname fnc_cv
private ["_veh", "_pos", "_c", "_dir", "_object", "_varName", "_init", "_valid"];
PARAMS_2(_veh,_pos);
_c = count _this;
if (_c > 2) then { _dir = _this select 2 } else { _dir = 0 };
if (_c > 3) then { _varName = _this select 3 } else { _varName = "" };
if (_c > 4) then { _init = _this select 4 } else { _init = "" };
_object = null;

if !(SLX_XEH_MACHINE select 3) then
{
	[0, { _this call FUNC(cv) }, _this] call CBA_fnc_globalExecute;
	TRACE_1("Sending vehicle create request",_this);
} else {
	_object = _veh createVehicle _pos;
	_valid = !(isNull _object);
	if (_valid) then
	{
		_object setDir _dir;
		if (_varName != "") then
		{
			missionNamespace setVariable[format["%1",_varName],_object, true]; 
		};
		if (_init != "") then
		{
			GVAR(state) = {_init}; publicVariable QGVAR(state);
			[nil, QGVAR(state), _object, true] spawn BIS_fnc_MP;
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
	TRACE_5("Received Vehicle Create Request",_this,_sid,_name,_object,_valid);
};
