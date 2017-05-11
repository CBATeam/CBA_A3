/* ----------------------------------------------------------------------------
Function: CBA_fnc_localizeKey

Description:
    Translate DIK code and modifier keys to readable keybind.

Parameters:
    _key     - DIK code <NUMBER>
    _shift   - Shift pressed? <BOOL>
    _control - Control pressed? <BOOL>
    _alt     - Alt pressed? <BOOL>

Returns:
    _keyName - Translated key <STRING>

Examples:
    (begin example)
        [0x12, [false, false, false]] call CBA_fnc_localizeKey;
    (end example)

Author:
    commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

params [["_key", 0, [0]], ["_modifier", [], [[], false]]];

if (_modifier isEqualType false) then {
    _modifier = _this select [1, 3];
};

_modifier params [["_shift", false, [false]], ["_ctrl", false, [false]], ["_alt", false, [false]]];

// Try to convert dik code to a human key code.
private _keyName = GVAR(keyNames) getVariable str _key;

if (isNil "_keyName") then {
    _keyName = format [localize LSTRING(unkownKey), _key];
};

// Build the full key combination name.
if (_alt && {!(_key in [DIK_LMENU, DIK_RMENU])}) then {
    _keyName = [localize "str_dik_alt", _keyName] joinString "+";
};

if (_ctrl && {!(_key in [DIK_LCONTROL, DIK_RCONTROL])}) then {
    _keyName = [localize "str_dik_control", _keyName] joinString "+";
};

if (_shift && {!(_key in [DIK_LSHIFT, DIK_RSHIFT])}) then {
    _keyName = [localize "str_dik_shift", _keyName] joinString "+";
};

_keyName
