#include "script_component.hpp"
_unit = _this select 0;
_distance = _this select 1;
_ok = false;
_i = 0;

{
	if ((_unit distance _x) < _distance) exitWith { _ok = true };
} forEach CALLMAIN(fPlayers);

_ok