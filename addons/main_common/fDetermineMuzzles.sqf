#include "script_component.hpp"
#define __cfg configFile >> "CfgWeapons" >> _this

private ["_r"];
_r = [__cfg];
if (isArray(__cfg >> "muzzles")) then
{
	_ar = getArray(__cfg >> "muzzles");
	if (count _ar == 0) exitWith {};
	if ((_ar select 0) == "this") exitWith {};
	_r = _ar;
};
_r