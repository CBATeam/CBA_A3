/* ----------------------------------------------------------------------------
Function: CBA_fnc_isTurnedOut

Description:
	Checks whether a unit is turned out in a vehicle or not.

Parameters:
	_unit - Unit to check [Object]

Returns:
	"true" for turned out or "false" for not turned out [Boolean]

Examples:
	(begin example)
	if ( [player] call CBA_fnc_isTurnedOut ) then
	{
		player sideChat "I am turned out!";
	};
	(end)

Author:
	commy2, BWMod
---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(isTurnedOut);

private ["_fnc_getTurrets", "_fnc_getTurretIndex","_unit", "_vehicle", "_config", "_animation", "_action", "_inAction", "_turretIndex", "_count", "_index"];
PARAMS_1(_unit);

_vehicle = vehicle _unit;
_config = configFile >> "CfgVehicles" >> typeOf _vehicle;
_animation = animationState _unit;

_fnc_getTurrets =
{
	private ["_vehicle", "_config", "_turrets", "_fnc_addTurret"];
	_vehicle = _this select 0;
	_config = configFile >> "CfgVehicles" >> typeOf _vehicle;
	_turrets = [];
	_fnc_addTurret =
	{
		private ["_config", "_path", "_count", "_index"];
		_config = _this select 0;
		_path = _this select 1;
		_config = _config >> "Turrets";
		_count = count _config;
		for "_index" from 0 to (_count - 1) do
		{
			_turrets set [count _turrets, _path + [_index]];
			[_config select _index, [_index]] call _fnc_addTurret;
		};
	};
	[_config, []] call _fnc_addTurret;
	_turrets
};

_fnc_getTurretIndex =
{
	private ["_unit", "_vehicle", "_turrets", "_units", "_index"];
	_unit = _this select 0;
	_vehicle = vehicle _unit;
	_turrets = [_vehicle] call _fnc_getTurrets;
	_units = [];
	{
		_units set [count _units, _vehicle turretUnit _x];
	} forEach _turrets;
	_index = _units find _unit;
	if (_index == -1) exitWith {[]};
	_turrets select _index;
};


if (_unit == driver _vehicle) then
{
	_action = getText (_config >> "driverAction");
	_inAction = getText (_config >> "driverInAction");
}
else
{
	_turretIndex = [_unit] call _fnc_getTurretIndex;
	_count = count _turretIndex;
	for "_index" from 0 to (_count - 1) do
	{
		_config = _config >> "Turrets";
		_config = _config select (_turretIndex select _index);
	};
	_action = getText (_config >> "gunnerAction");
	_inAction = getText (_config >> "gunnerInAction");
};

if (_action == "" || {_inAction == ""} || {_action == _inAction}) exitWith {false};
_animation = toArray _animation;
_animation resize (count toArray _action);
_animation = toString _animation;
_animation == _action

