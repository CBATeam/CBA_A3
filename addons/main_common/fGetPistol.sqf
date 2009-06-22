#include "script_component.hpp"
// Simple function that will return first found Pistol in unit's weaponList
private ["_r"];
_r = "";

if (_this isKindOf "man") then
{
	{ if ((getNumber (configFile >> "CfgWeapons" >> _x >> "Type")) == 2) exitWith { _r = _x } } forEach (weapons _this);
};

_r