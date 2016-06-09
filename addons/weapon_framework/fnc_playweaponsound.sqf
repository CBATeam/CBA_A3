#include "script_component.hpp"
private ["_unit","_arg","_sound","_Sound_Location"];
if (typename (_this select 1) == "array") then 
{
	_arg = _this select 1;
	_unit = _arg select 0;
	_sound = _arg select 1;
	_Sound_Location = _arg select 2;
} 
else 
{
	_unit = _this select 0;
	_sound = _this select 1;
	_Sound_Location = _this select 2;
};
if (isnil "_sound" || _sound == "") exitwith {}; // No sound set, don't play anything.
if (isNil "_unit") exitwith {false}; //Rarely happens that _unit stops existing

_rhand = _unit selectionPosition _Sound_Location;
_posStart = _unit modeltoworld _rhand;
_obj = "#particlesource" createVehicleLocal _posStart;
_obj attachto [_unit,_rhand];
_obj say3d _sound;
sleep 10;
deleteVehicle _obj;