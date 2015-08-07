/* ----------------------------------------------------------------------------
Function: CBA_fnc_getKeybind

Description:
 Checks if a particular mod has already registered a keybind handler for the
 specified action.

Parameters:
 _modName           - Name of the registering mod [String]
 _actionName        - Name of the action to get [String]

Returns:
 Keyboard entry - array of parameters of the same form as used for CBA_fnc_addKeybind

Examples:
    (begin example)
    _entry = ["your_mod", "openMenu"] call CBA_fnc_getKeybind;

    if (!isNil "_entry") then {
        _modName     = _entry select 0; // Name of the registering mod ("your_mod")
        _actionName  = _entry select 1; // Id of the key action ("openMenu")
        _displayName = _entry select 2; // Pretty name for the key action or an array with ["pretty name", "tool tip"]
        _downCode    = _entry select 3; // Code to execute on keyDown
        _upCode      = _entry select 4; // Code to execute on keyUp
        _keyBind     = _entry select 5; // [DIK code, [shift, ctrl, alt]]
        _holdKey     = _entry select 6; // Will the key fire every frame while held down? (bool)
        _holdDelay   = _entry select 7; // How long after keydown will the key event fire, in seconds (float)

        ...
        ...
    };
    (end example)

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_modName","_actionName"];

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
