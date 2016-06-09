#include "script_component.hpp"
private ["_unit","_weapon","_param","_HandAction","_Actiondelay","_Sound","_Sound_Location","_hasOptic","_acc","_reloadDelay"];
_unit = _this select 0;
_weapon = _this select 1;
_HandAction = _this select 2;
_Actiondelay = _this select 3;
_Sound = _this select 4;
_Sound_Location = _this select 5;
_hasOptic = (_this select 6 == 1);
_acc = _unit weaponAccessories _weapon;
_reloadDelay = _this select 7;

if (_acc select 2 != "") then 
{
	_hasOptic = true;
};


if (!local _unit && _hasOptic) exitwith {};

if (_unit ammo _weapon !=0) then 
{
	if (!isDedicated && _hasOptic && player == _unit) then 
	{
		if (cameraview == "GUNNER") then
		{
			true call FUNC(block_reloadaction);
		};
		while {cameraview == "GUNNER"} do 
		{
			_unit setWeaponReloadingTime [_unit,_weapon,1];
			sleep 0.001;
		};
		sleep _Actiondelay;
		[_unit,_Sound,_Sound_Location] spawn FUNC(playweaponsound);
		GVAR(bg_wep_playsound) = [_unit,_Sound,_Sound_Location];
		publicVariable QGVAR(bg_wep_playsound);
		_unit playAction _HandAction;
		true call FUNC(block_reloadaction);
		sleep _reloadDelay;
		false call FUNC(block_reloadaction);
		
	}
	else
	{
		sleep _Actiondelay;
		[_unit,_Sound,_Sound_Location] spawn FUNC(playweaponsound);
		if (local _unit) then 
		{
			_unit playAction _HandAction;
			if (_unit == player) then
			{
				true call FUNC(block_reloadaction);
				sleep _reloadDelay;
				false call FUNC(block_reloadaction);
			};
		};
	};

};