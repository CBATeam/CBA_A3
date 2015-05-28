/* ----------------------------------------------------------------------------
Function: CBA_fnc_getKeybind

Description:
 Checks if a particular mod has already registered a keybind handler for the
 specified action.

Parameters:
 _modName            - Name of the registering mod [String]
 _actionName        - Name of the action to get [String]

Returns:
 Keyboard entry.

Examples:
    (begin example)
 _index = ["your_mod", "openMenu"] call cba_fnc_getKeybind;

 if (_index >= 0) then {
    _handler = cba_keybind_handlers select _index;
 };
    (end example)

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "script_component.hpp"

PARAMS_2(_modName,_actionName);

_modId = (GVAR(handlers) select 0) find _modName;
if(_modId == -1) exitWith {nil};

_modRegistry = (GVAR(handlers) select 1) select _modId;

_actionEntryId = (_modRegistry select 0) find _actionName;
if(_actionEntryId == -1) exitWith {nil};
_actionEntry = (_modRegistry select 1) select _actionEntryId;

_hashDown = format["%1_%2_down", _modName, _actionName];
_entryIndex = (GVAR(defaultKeybinds) select 0) find _hashDown;
if(_entryIndex == -1) exitWith {nil};
_defaultEntry = (GVAR(defaultKeybinds) select 1) select _entryIndex;

_entry = [
    _modName,
    _actionName,
    _actionEntry select 0,
    _defaultEntry select 0,
    _defaultEntry select 1,
    _actionEntry select 1,
    _defaultEntry select 2,
    _defaultEntry select 3
];


// Return the index into the registry.
_entry;