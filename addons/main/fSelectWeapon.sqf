#include "script_component.hpp"
private ["_unit", "_weap", "_cfg", "_muz", "_ar"];
_unit = _this select 0;
_weap = _this select 1;
_cfg = (configFile >> "CfgWeapons" >> _weap >> "muzzles");
if (isArray _cfg) then
{
	_ar = getArray _cfg;
	_muz = _ar select 0;
	if (_muz == "this") then { _muz = _weap };
} else {
	_muz = _weap;
};

sleep 1;
if (player hasWeapon _weap) then { _unit selectWeapon _muz };