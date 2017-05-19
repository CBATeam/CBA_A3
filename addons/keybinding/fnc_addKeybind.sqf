/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeybind

Description:
    Adds or updates the keybind handler for a specified mod action, and associates
    a function with that keybind being pressed.

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
        // This file should be included for readable DIK codes.
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
/*#include "script_component.hpp"

// clients only.
if (!hasInterface) exitWith {};

// prevent race conditions. function could be called from scheduled env.
if (canSuspend) exitWith {
    [CBA_fnc_addKeybind, _this] call CBA_fnc_directCall;
};

params [
    ["_addon", "", [""]],
    ["_action", "", [""]],
    ["_title", "", ["", []]],
    ["_downCode", {}, [{}]],
    ["_upCode", {}, [{}]],
    ["_defaultKeybind", KEYBIND_NULL, [KEYBIND_NULL]],
    ["_holdKey", true, [false]],
    ["_holdDelay", 0, [0]],
    ["_overwrite", false, [false]]
];

_title params [["_displayName", _action, [""]], ["_tooltip", "", [""]]];
_action = toLower _action;

// support old format
if (count _defaultKeybind isEqualTo 4) then {
    _defaultKeybind params [
        ["_key", 0, [0]],
        ["_shift", false, [false]],
        ["_control", false, [false]],
        ["_alt", false, [false]]
    ];

    _defaultKeybind = [_key, [_shift, _control, _alt]];
};

// Make sure modifer is set to true, if base key is a modifier
_defaultKeybind params [["_key", 0, [0]], ["_defaultModifiers", [], [[]]]];
_defaultModifiers params [
    ["_shift", false, [false]],
    ["_control", false, [false]],
    ["_alt", false, [false]]
];

if (_key in [DIK_LSHIFT, DIK_RSHIFT]) then {
    _shift = true;
};

if (_key in [DIK_LCONTROL, DIK_RCONTROL]) then {
    _control = true;
};

if (_key in [DIK_LMENU, DIK_RMENU]) then {
    _alt = true;
};

private _keybind = [_key, [_shift, _control, _alt]];

// data for controls menu
if (isNil QGVAR(actions)) then {
    GVAR(actions) = [] call CBA_fnc_createNamespace;
    //GVAR(keys) = [] call CBA_fnc_createNamespace;
};

GVAR(actions) setVariable [_action, [_addon, _displayName, _tooltip, _keybind]];

// get a local copy of the keybind registry.
private _registry = profileNamespace getVariable [QGVAR(registry_v3), HASH_NULL];
private _registryKeybinds = [_registry, _action] call CBA_fnc_hashGet;

// action doesn't exist in registry yet, create it and store default keybinding
if (isNil "_registryKeybinds") then {
    _registryKeybinds = [_keybind];
    [_registry, _action, _registryKeybinds] call CBA_fnc_hasSet;
};

// add this action to all keybinds
{
    _keybind = _x;
    /*private _keybindActions = GVAR(keys) getVariable str _keybind;

    if (isNil "_keybindActions") then {
        _keybindActions = [];
        GVAR(actions) setVariable [str _keybind, _keybindActions];
    };

    _keybindActions pushBack _action;*/

    // @todo, these only support the latest bind
/*    if !(_downCode isEqualTo {}) then {
        [_keybind select 0, _keybind select 1, _downCode, "keyDown", format ["%1_%2_down", _addon, _action], _holdKey, _holdDelay] call CBA_fnc_addKeyHandler;
    };

    if !(_upCode isEqualTo {}) then {
        [_keybind select 0, _keybind select 1, _upCode, "keyUp", format ["%1_%2_up", _addon, _action]] call CBA_fnc_addKeyHandler;
    };
} forEach _registryKeybinds;

// Emit an event that a key has been registered.
[QGVAR(registerKeybind), _this] call CBA_fnc_localEvent;

_keybind
