#include "\x\cba\addons\keybinding\script_component.hpp"

disableSerialization;

_return = true;

// Remove every currently registered key handler
{
	_keyConfig = _x; 

	_ehID = _keyConfig select 4;
	_keypressType = _keyConfig select 5;

	[format ["%1", _ehID], _keypressType] call cba_fnc_removeKeyHandler;
} forEach GVAR(handlers);

// Clear the handlers array.
GVAR(handlers) = [];

// Re-register every handler from the backup array.
{
	_keyConfig = _x;

	_modName = _keyConfig select 0;
	_actionName = _keyConfig select 1;
	_oldKeyData = _keyConfig select 2;
	_functionName = _keyConfig select 3;
	//_oldEhID = _keyConfig select 4;
	_keypressType = _keyConfig select 5;

	[_modName, _actionName, _functionName, _oldKeyData, true, _keypressType] call cba_fnc_registerKeybind;
} forEach GVAR(handlersBackup);

_return;