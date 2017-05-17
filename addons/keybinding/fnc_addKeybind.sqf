/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeybind

Description:
    Adds or updates the keybind handler for a specified mod action, and associates
    a function with that keybind being pressed.

    This file should be included for readable DIK codes:
        #include "\a3\editor_f\Data\Scripts\dikCodes.h"

    Additional DIK codes usable with this function:
        0xF0: Left mouse button
        0xF1: Right mouse button
        0xF2: Middle mouse button
        0xF3: Mouse #4
        0xF4: Mouse #5
        0xF5: Mouse #6
        0xF6: Mouse #7
        0xF7: Mouse #8
        0xF8: Mouse wheel up
        0xF9: Mouse wheel down

Parameters:
    _addon          - Name of the registering mod <STRING>
    _action         - Id of the key action. <STRING>
    _title          - Pretty name, or an array of pretty name and tooltip <STRING>
    _downCode       - Code for down event, empty string for no code. <CODE>
    _upCode         - Code for up event, empty string for no code. <CODE>

Optional:
    _defaultKeybind - The keybinding data in the format [DIK, [shift, ctrl, alt]] <ARRAY>
    _holdKey        - Will the key fire every frame while down <BOOLEAN>
    _holdDelay      - How long after keydown will the key event fire, in seconds. <NUMBER>
    _overwrite      - Overwrite any previously stored default keybind <BOOLEAN>

Returns:
    Returns the current keybind for the action <ARRAY>

Examples:
    (begin example)
        // Register a simple keypress to an action
        #include "\a3\editor_f\Data\Scripts\dikCodes.h"

        ["MyMod", "MyKey", ["My Pretty Key Name", "My Pretty Tool Tip"], {
            _this call mymod_fnc_keyDown
        }, {
            _this call mymod_fnc_keyUp
        }, [DIK_TAB, [false, false, false]]] call CBA_fnc_addKeybind;

        ["MyMod", "MyOtherKey", "My Other Pretty Key Name", {
            _this call mymod_fnc_keyDownOther
        }, {
            _this call mymod_fnc_keyUpOther
        }, [DIK_K, [false, false, false]]] call CBA_fnc_addKeybind;
    (end example)

Author:
    Taosenai & Nou, commy2
---------------------------------------------------------------------------- */
#include "script_component.hpp"

// clients only.
if (!hasInterface) exitWith {};

// prevent race conditions. function could be called from scheduled env.
if (canSuspend) exitWith {
    [CBA_fnc_addKeybind, _this] call CBA_fnc_directCall;
};

params [
    ["_addon", "", [""]],
    ["_addonAction", "", [""]],
    ["_title", "", ["", []]],
    ["_downCode", {}, [{}]],
    ["_upCode", {}, [{}]],
    ["_defaultKeybind", KEYBIND_NULL, [KEYBIND_NULL]],
    ["_holdKey", false, [false]],
    ["_holdDelay", 0, [0]],
    ["_overwrite", false, [false]]
];

_title params [["_displayName", _addonAction, [""]], ["_tooltip", "", [""]]];
private _action = toLower format ["%1$%2", _addon, _addonAction];

// support old format
if (_defaultKeybind isEqualTypeParams [0, false, false, false]) then {
    _defaultKeybind params ["_defaultKey", "_defaultShift", "_defaultControl", "_defaultAlt"];
    _defaultKeybind = [_defaultKey, [_defaultShift, _defaultControl, _defaultAlt]];
};

// Make sure modifer is set to true, if base key is a modifier
_defaultKeybind params [["_defaultKey", 0, [0]], ["_defaultModifiers", [], [[]]]];
_defaultModifiers params [["_defaultShift", false, [false]], ["_defaultControl", false, [false]], ["_defaultAlt", false, [false]]];

_defaultKey = _defaultKey max 0;

if (_defaultKey in [DIK_LSHIFT, DIK_RSHIFT]) then {
    _defaultShift = true;
};

if (_defaultKey in [DIK_LCONTROL, DIK_RCONTROL]) then {
    _defaultControl = true;
};

if (_defaultKey in [DIK_LMENU, DIK_RMENU]) then {
    _defaultAlt = true;
};

private _keybind = [_defaultKey, [_defaultShift, _defaultControl, _defaultAlt]];

// get a local copy of the keybind registry
private _registry = profileNamespace getVariable QGVAR(registry_v3);

if (isNil "_registry") then {
    _registry = HASH_NULL;
    profileNamespace setVariable [QGVAR(registry_v3), _registry];
};

private _keybinds = [_registry, _action] call CBA_fnc_hashGet;

// action doesn't exist in registry yet, create it and store default keybinding
if (isNil "_keybinds" || {_overwrite}) then {
    _keybinds = [_keybind];
    [_registry, _action, _keybinds] call CBA_fnc_hashSet;
};

// filter out null binds
_keybinds = _keybinds select {_x select 0 > DIK_ESCAPE};

// make list of active mods and keybinds for gui
if (isNil QGVAR(addons)) then {
    GVAR(addons) = [] call CBA_fnc_createNamespace;
    GVAR(actions) = [] call CBA_fnc_createNamespace;
};

private _addonInfo = GVAR(addons) getVariable _addon;

if (isNil "_addonInfo") then {
    _addonInfo = [_addon, []];
    GVAR(addons) setVariable [_addon, _addonInfo];
};

(_addonInfo select 1) pushBackUnique toLower _addonAction;

GVAR(actions) setVariable [_action, [_displayName, _tooltip, _keybinds, _defaultKeybind, _downCode, _upCode, _holdKey, _holdDelay]];

// add this action to all keybinds
{
    _keybind = _x;

    if !(_downCode isEqualTo {}) then {
        [_keybind select 0, _keybind select 1, _downCode, "keyDown", format ["%1_down_%2", _action, _forEachIndex], _holdKey, _holdDelay] call CBA_fnc_addKeyHandler;
    };

    if !(_upCode isEqualTo {}) then {
        [_keybind select 0, _keybind select 1, _upCode, "keyUp", format ["%1_up_%2", _action, _forEachIndex]] call CBA_fnc_addKeyHandler;
    };
} forEach _keybinds;

// Emit an event that a key has been registered.
[QGVAR(registerKeybind), _this] call CBA_fnc_localEvent;

_keybind // only return the last keybind for bwc
