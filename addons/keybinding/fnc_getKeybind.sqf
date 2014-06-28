/* ----------------------------------------------------------------------------
Function: CBA_fnc_getKeybind

Description:
 Checks if a particular mod has already registered a keybind handler for the
 specified action.

Parameters:
 "modName" Name of the registering mod.
 "actionName" Name of the action to be checked for.

Returns:
 Returns index to (uiNamespace getVariable "cba_keybind_handlers") if 
 found. Returns -1 if not.

Examples:
_index = ["your_mod", "openMenu"] call cba_fnc_getKeybind;

 if (_index >= 0) then {
	_handler = (uiNamespace getVariable "cba_keybind_handlers") select _index;
 };

Author:
 Taosenai
---------------------------------------------------------------------------- */

private ["_modName", "_actionName", "_index"];

_modName = [_this, 0, nil, [""]] call bis_fnc_param;
_actionName = [_this, 1, nil, [""]] call bis_fnc_param;

// Iterate over all entries in the keybinding registry, searching for the mod 
// and action.
_index = -1;
{
	if (_x select 0 == _modName) then {
		if (_x select 1 == _actionName) exitWith {
			_index = _forEachIndex;
		};
	};
} forEach (uiNamespace getVariable QGVAR(handlers));

// Return the index into the registry.
_index;