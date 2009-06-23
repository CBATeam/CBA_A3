/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeyHandlerFromConfig
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addKeyHandlerFromConfig);

private ["_component", "_action", "_code", "_key"];
_component = _this select 0;
_action = _this select 1;
_code = _this select 2;

_key = [_component, _action] CALLMAIN(ReadKeyFromConfig);
if (_key select 0 > -1) exitWith
{
	 [_key select 0, _key select 1, _code] CALLMAIN(AddKeyHandler);
	 true
};

false