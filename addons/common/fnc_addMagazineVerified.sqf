/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazineVerified

Description:
	Add a magazine, but verify that it was successful without over-burdening the
	recipient.
	
Parameters:

Returns:

Examples:
	(begin example)

	(end)

Author:

---------------------------------------------------------------------------- */

#include "script_component.hpp"
SCRIPT(addMagazineVerified);

#define __pistol 16
#define __rifle 256
#define __ruck 4096

#define __pistolMax 8
#define __rifleMax 12
#define __ruckMax 20

private ["_magazine", "_cfg", "_type", "_pistol", "_rifle", "_num", "_exit", "_ruck"];
_magazine = _this;
_cfg = (configFile >> "CfgMagazines" >> _magazine);
_type = getNumber (_cfg >> "type");

_pistol = 0;
_rifle = 0;
_ruck = 0;
{
	private ["_cfg", "_type"];
	_cfg = (configFile >> "CfgMagazines" >> _x);
	_type = getNumber (_cfg >> "type");
	switch _type do
	{
		case __pistol:
		{
			_pistol = _pistol + 1;
		};
		case __rifle:
		{
			_rifle = _rifle + 1;
		};
		case __ruck:
		{
			_ruck = _ruck + 1;
		};
		default
		{
			if (_type > (__rifle * __rifleMax)) exitWith {};
			_num = _type / __rifle;
			if (_num == (round _num)) then
			{
				_rifle = _rifle + _num;
			} else {
				if (_type > (__pistol * __pistolMax)) exitWith {};

				_num = _type / __pistol;
				if (_num == (round _num)) then
				{
					_pistol = _pistol + _num;
				};
			};
		};
	};
} forEach (magazines player);

private ["_j", "_k"];
_exit = false;
switch _type do
{
	case __pistol:
	{
		_num = 1;
		_j = _pistol;
		_k = __pistolMax;
	};
	case __rifle:
	{
		_num = 1;
		_j = _rifle;
		_k = __rifleMax;
	};
	case __ruck:
	{
		_num = 1;
		_j = _ruck;
		_k = __ruckMax;
	};
	default
	{
		if (_type > (__rifle * __rifleMax)) exitWith { _exit = true };
		_num = _type / __rifle;
		if (_num == (round _num)) then
		{
			_j = _rifle;
			_k = __rifleMax;
		} else {
			if (_type > (__pistol * __pistolMax)) exitWith { _exit = true };
			_num = _type / __pistol;
			if (_num == (round _num)) then
			{
				_j = _pistol;
				_k = __pistolMax;
			};
		};
	};
};
if (_exit) exitWith { hint "Sorry, can't carry more of these magazines, please first make space!" };
if ((_k - _j) >= _num)  then
{
	for "_i" from 1 to ((_k - _j) / _num) do
	{
		_action = [player,_magazine] call CBA_fAddMagazine;
	};
};

