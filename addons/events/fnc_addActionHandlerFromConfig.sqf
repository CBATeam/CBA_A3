/* ----------------------------------------------------------------------------
Function: CBA_fnc_addActionHandlerFromConfig
---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(addActionHandlerFromConfig);

private ["_component", "_action", "_code", "_key"];
_component = _this select 0;
_action = _this select 1;
_code = _this select 2;

_key = [_component, _action] CALL(ReadActionFromConfig);
if (_key select 0 > -1) exitWith
{
	 [_key select 0, _code] CALL(AddHandler);
	 true
};

false