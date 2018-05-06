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
        _firstKeybind= _entry select 5; // [DIK code, [shift, ctrl, alt]] (Only the first one)
        _holdKey     = _entry select 6; // Will the key fire every frame while held down? (bool)
        _holdDelay   = _entry select 7; // How long after keydown will the key event fire, in seconds (float)
        _keybinds    = _entry select 8; // All keybinds (array)
    };
    (end example)

Author:
 Taosenai
---------------------------------------------------------------------------- */

#include "script_component.hpp"

params ["_addon", "_addonAction"];
TRACE_2("getKeybind",_addon,_addonAction);

if (!hasInterface) exitWith {nil};

private _action = toLower format ["%1$%2", _addon, _addonAction];
private _actionInfo = GVAR(actions) getVariable _action;

if (isNil "_actionInfo") exitWith {
    TRACE_2("Action not found",_action,_actionInfo);
    nil
};

_actionInfo params ["_displayName", "", "_keybinds", "", "_downCode", "_upCode", "_holdKey", "_holdDelay"];
TRACE_2("",_displayName,_keybinds);

// Select a single keybind (first one) for the 5th element return to keep compatiblity with old code
private _oldKeyBind = _keybinds param [0, [-1, [false, false, false]]];

[_addon, _addonAction, _displayName, _downCode, _upCode, _oldKeyBind, _holdKey, _holdDelay, _keybinds]
