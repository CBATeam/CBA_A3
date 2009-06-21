#include "script_component.hpp"
private ["_component", "_action", "_code", "_key"];
_component = _this select 0;
_action = _this select 1;
_code = _this select 2;

_key = [_component, _action] CALLMAIN(fnc_ReadKeyFromConfig);
if (_key select 0 > -1) exitWith
{
	 [_key select 0, _key select 1, _code] CALLMAIN(fnc_AddKeyHandler);
	 true
};

false