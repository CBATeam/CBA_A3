/* ----------------------------------------------------------------------------
Function: CBA_fnc_addMagazineVerified

Description:
	Add magazines to the unit, but verify that it was
	successful and doesn't over-burden the recipient. The
	function has to options to fill all available inventory slots with
	the requested magazine type, create excess magazines on the ground
	or do nothing.

Parameters:
	_unit - the unit to add magazine too. [Object]
	_magazine - the magazine type to add. [String]
	_action - 0 (default) do nothing, return false
		- 1 create excess magazines on ground
		- 2 fill all inventory slots

Returns:
	true, if the unit has sufficient inventory space
	for the magazine in question

Examples:
	(begin example)
	[player, "SmokeShell",1] call CBA_fnc_AddMagazineVerified
	(end)

Author:
	Sickboy, Killswitch, Wolffy.Au

---------------------------------------------------------------------------- */

#include "script_component.hpp"

SCRIPT(addMagazineVerified);

#define __pistol 16
#define __rifle 256
#define __ruck 4096

#define __pistolMax 8
#define __rifleMax 12
#define __ruckMax 20

private ["_unit", "_magazine", "_action", "_return", "_cfg", "_type", "_pistol", "_rifle", "_num", "_exit", "_ruck"];
// BWC
if (typeName _this != "ARRAY") then {
	_unit = player;
	PARAMS_1(_magazine);
	_action = 2;
} else {
	PARAMS_2(_unit,_magazine);
	DEFAULT_PARAM(2,_action,0);
};

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
} forEach (magazines _unit);

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

if (_exit && (_action == 0 || _action == 2)) exitWith { diag_log "CBA_fnc_addMagazineVerified: Sorry, can't carry more of these magazines!"; false; };
_return = false;
if ((_k - _j) >= _num)  then
{
        switch (_action) do 
        {
                case 2: {
			for "_i" from 1 to ((_k - _j) / _num) do
			{
                                [_unit,_magazine] call CBA_fnc_addMagazine;
			};
		};
                default {
                        [_unit,_magazine] call CBA_fnc_addMagazine;
                };
        };
        _return = true;
} else {
        if (_action == 1) then {
                private ["_wh"];
                _unit switchMove "ainvpknlmstpslaywrfldnon_1";
		_wh = createVehicle ["WeaponHolder", position _unit, [], 0, "NONE"];
                [_wh, _magazine] call CBA_fnc_AddMagazineCargo;
		_wh setPos ([_wh, 2] call CBA_fnc_randPos);
        };
};

_return;
