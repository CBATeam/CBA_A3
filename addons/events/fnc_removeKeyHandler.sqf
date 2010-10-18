/* ----------------------------------------------------------------------------
Function: CBA_fnc_removeKeyHandler

Description:
	Removes an action to a keyhandler

Parameters:
	_hashKey 

Returns:

Examples:
	(begin example)
		["cba_somesystem_keyevent"] call CBA_fnc_removeKeyHandler;
	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(removeKeyHandler);
private ["_type", "_hashKey", "_keyData", "_handlers", "_idx", "_myHandlers"];
PARAMS_1(_hashKey);
_type = if (count _this > 1) then { _this select 1 } else { "keydown" };
_type = toLower _type;
if (_type in KEYS_ARRAY_WRONG) then { _type = ("key" + _type) };
if !(_type in KEYS_ARRAY) exitWith { ERROR("Type does not exist") };
_hashKey = toLower _hashKey;
_keyData = [QUOTE(GVAR(keyhandlers)), _hashKey] call CBA_fnc_hashGet;

_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

// Remove existing key.
_idx = _keyData select 0;
if (count _handlers > _idx) then {
	_myHandlers = _handlers select _idx;
	_myHandlers = _myHandlers - [_hashKey]
	_handlers set [_idx, _myHandlers];
};


true;
