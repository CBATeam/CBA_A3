/* ----------------------------------------------------------------------------
Function: CBA_fnc_changeKeyHandler

Description:
	Changes an action to a keyhandler

Parameters:
	_hashKey - String
	_key - New key [integer]
	_settings - Array of settings (shift, alt etc)
	_type - Type of keyevent [String] - default keydown

Returns:

Examples:
	(begin example)
		["cba_somesystem_keyevent", 44, [false,false,false]] call CBA_fnc_changeKeyHandler;
	(end)

Author:
	Sickboy

---------------------------------------------------------------------------- */
#include "script_component.hpp"
SCRIPT(changeKeyHandler);
private ["_type", "_keyData", "_handlers", "_idx", "_myHandlers", "_ar"];
PARAMS_3(_hashKey,_key,_settings);
_type = if (count _this > 3) then { _this select 3 } else { "keydown" };
_type = toLower _type;
if (_type in KEYS_ARRAY_WRONG) then { _type = ("key" + _type) };
if !(_type in KEYS_ARRAY) exitWith { ERROR("Type does not exist") };
_hashKey = toLower _hashKey;
_keyData = [GVAR(keyhandlers), _hashKey] call CBA_fnc_hashGet;

_handlers = [GVAR(keyhandler_hash), _type] call CBA_fnc_hashGet;

// Remove existing key.
_idx = _keyData select 0;
if (count _handlers > _idx) then {
	_myHandlers = _handlers select _idx;
	_myHandlers = _myHandlers - [_hashKey]
	_handlers set [_idx, _myHandlers];
};

// Add to new key.
if(_key>(count _handlers))then{_handlers resize(_key+1);};
_ar = _handlers select _key;
if(isNil"_ar")then{_ar=[]};
PUSH(_ar,_hashKey);
_handlers set [_key, _ar];

// Update keydata
_keyData set [0, _key];
_keyData set [1, _settings];

true;
