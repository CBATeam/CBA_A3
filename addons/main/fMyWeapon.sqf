#include "script_component.hpp"
/*
mando_my_weapon.sqf v1.0
By Mandoble

Returns the weapon in hand of the passed unit.
Compile the function first in your init.sqs or init.sqf file:
mando_my_weapon = compile (preprocessFileLineNumbers "mando_my_weapon.sqf");

Usage example:
hint format["%1", [vehicle player] call mando_my_weapon]
*/

private ["_unit", "_weapons", "_myweapons", "_myweapon", "_angv", "_angu", "_dif"];
_unit = _this select 0;
_msg = "weapons:\n";

_angu = (vectorDir _unit select 0) atan2 (vectorDir _unit select 1);
_myweapons = [];
{
   if (((_unit weaponDirection _x) select 2) < 0.88) then {
      _myweapons = _myweapons + [_x];
      _msg = _msg + format["%1\n", _x];
   };
} forEach weapons _unit;

if (count _myweapons > 1) then {
   {
      _angw = ((vectorDir _unit select 0) + ((_unit weaponDirection _x) select 0)) atan2 ((vectorDir _unit select 1) + ((_unit weaponDirection _x) select 1));
      _dif = abs(_angu) - abs(_angw);

// 0.5983, 0.06004, 21.796, 1.4566, 0.3589, 6.3597,
      if ((abs(abs(_dif) - 0.5983) < 0.00009) ||
          (abs(abs(_dif) - 0.6004) < 0.00009) ||
          (abs(abs(_dif) - 21.796) < 0.0009) ||
          (abs(abs(_dif) - 1.4566) < 0.00009) ||
          (abs(abs(_dif) - 0.3589) < 0.00009) ||
          (abs(abs(_dif) - 6.3597) < 0.00009) ||
          _x == "NVGoggles" ||
          _x == "Binocular" ||
					(inheritsFrom(configFile >> "CfgWeapons" >> _x) == (configFile >> "CfgWeapons" >> "ACE_Rucksack") )) then {
          _myweapons = _myweapons - [_x];
      };
   } forEach weapons _unit;
};


if (count _myweapons > 0) then {
   _myweapon = _myweapons select 0;
}
else
{
   _myweapon = "";
};

_myweapon