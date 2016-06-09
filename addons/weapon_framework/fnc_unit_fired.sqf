#include "script_component.hpp"
private ["_unit","_weapon","_param","_mode"];
_unit = _this select 0;
_weapon = _this select 1;
_mode = _this select 3;
_param = (configFile >> "CfgWeapons" >> _weapon >> "bg_weaponparameters");

if (isClass _param) then
{
	if (isClass (_param >> "onFired_Action")) then
	{
		private ["_HandAction","_Actiondelay","_Sound","_Sound_Location","_hasOptic","_reloadDelay","_weaponConfig","_speed"];
		_HandAction = (_param >> "onFired_Action" >> "HandAction") call BIS_fnc_getCfgData;
		_Actiondelay = (_param >> "onFired_Action" >> "Actiondelay") call BIS_fnc_getCfgData;
		_Sound = (_param >> "onFired_Action" >> "Sound") call BIS_fnc_getCfgData;
		_Sound_Location = (_param >> "onFired_Action" >> "Sound_Location") call BIS_fnc_getCfgData;
		_hasOptic = (_param >> "onFired_Action" >> "hasOptic") call BIS_fnc_getCfgData;
		if (_mode == _weapon) then 
		{
			_weaponConfig = (configFile >> "CfgWeapons" >> _weapon);
			_speed = getnumber (_weaponConfig >> "reloadTime");
			_reloadDelay = _speed + 0.15;
		}
		else
		{
			_weaponConfig = (configFile >> "CfgWeapons" >> _weapon >> _mode);
			_speed = getnumber (_weaponConfig >> "reloadTime");
			_reloadDelay = _speed + 0.15;
		};
		
		
		[_unit,_weapon,_HandAction,_Actiondelay,_Sound,_Sound_Location,_hasOptic,_reloadDelay] spawn FUNC(onFiredAction);
	};
	if (isClass (_param >> "onEmpty")) then
	{
		if (_unit ammo _weapon == 0) then 
		{
			_Sound = (_param >> "onEmpty" >> "Sound") call BIS_fnc_getCfgData;
			_Sound_Location = (_param >> "onEmpty" >> "Sound_Location") call BIS_fnc_getCfgData;
			
			[_unit,_Sound,_Sound_Location] spawn FUNC(playweaponsound);
		};
	};
};