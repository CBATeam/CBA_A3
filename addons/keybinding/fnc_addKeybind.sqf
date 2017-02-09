/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeybind

Description:
 Adds or updates the keybind handler for a specified mod action, and associates
 a function with that keybind being pressed.

Parameters:
 _modName            - Name of the registering mod [String]
 _actionId          - Id of the key action. [String]
 _displayName       - Pretty name, or an array of strings for the pretty name and a tool tip [String]
 _downCode          - Code for down event, empty string for no code. [Code]
 _upCode            - Code for up event, empty string for no code. [Code]

 Optional:
 _defaultKeybind    - The keybinding data in the format [DIK, [shift, ctrl, alt]] [Array]
 _holdKey           - Will the key fire every frame while down [Bool]
 _holdDelay         - How long after keydown will the key event fire, in seconds. [Float]
 _overwrite         - Overwrite any previously stored default keybind [Bool]

Returns:
 Returns the current keybind for the action [Array]

Examples:
    (begin example)
 // Register a simple keypress to an action
 // This file should be included for readable DIK codes.
 #include "\a3\editor_f\Data\Scripts\dikCodes.h"

 ["MyMod", "MyKey", ["My Pretty Key Name", "My Pretty Tool Tip"], { _this call mymod_fnc_keyDown }, { _this call mymod_fnc_keyUp }, [DIK_TAB, [false, false, false]]] call cba_fnc_addKeybind;
    (end example)
    (begin example)
 ["MyMod", "MyOtherKey", "My Other Pretty Key Name", { _this call mymod_fnc_keyDownOther }, { _this call mymod_fnc_keyUpOther }, [DIK_K, [false, false, false]]] call cba_fnc_addKeybind;
    (end example)

Author:
 Taosenai & Nou
---------------------------------------------------------------------------- */
//TODD: Implement the holdkey features - Nou
//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (!hasInterface) exitWith {};

_nullKeybind = [-1, [false,false,false]];

params [
    ["_modName", "", [""]],
    ["_actionId", "", [""]],
    ["_displayName", "", ["", []]],
    "_downCode",
    "_upCode",
    ["_defaultKeybind", _nullKeybind],
    ["_holdKey", true],
    ["_holdDelay", 0],
    ["_overwrite", false]
];

_displayName params [["_name", "", [""]], ["_tooltip", "", [""]]];

if (_tooltip isEqualTo "") then {
    _displayName = _name;
} else {
    _displayName = [_name, _tooltip];
};

if (count _defaultKeybind == 4) then {
    WARNING_2("%1: %2 - Wrong format for the default keybind parameter. Use [DIK, [shift, ctrl, alt]]",_modName,_actionId);
    _modifiers=[_defaultKeybind select 1, _defaultKeybind select 2, _defaultKeybind select 3];
    _defaultKeybind = [_defaultKeybind select 0, _modifiers];
};

// Make sure modifer is set to true, if base key is a modifier
// This can happen with script added keybinds AND from the rebinding code (fnc_onLBDblClick)
_defaultKeybind params ["_keyNumber", "_keyParams"];
if (_keyNumber in [DIK_LSHIFT, DIK_RSHIFT]) then {TRACE_1("setting shift", _keyParams); _keyParams set [0, true];};
if (_keyNumber in [DIK_LCONTROL, DIK_RCONTROL]) then {TRACE_1("setting ctrl", _keyParams); _keyParams set [1, true];};
if (_keyNumber in [DIK_LMENU, DIK_RMENU]) then {TRACE_1("setting alt", _keyParams); _keyParams set [2, true];};

_keybind = nil;

// Get a local copy of the keybind registry.
_registry = profileNamespace getVariable [QGVAR(registryNew), nil];
if(isNil "_registry") then {
    _registry = [[],[]];
    profileNamespace setVariable [QGVAR(registryNew), _registry];
};
if(!(_modName in GVAR(activeMods))) then {
    GVAR(activeMods) pushBack _modName;
};

TRACE_1("",_registry);

GVAR(activeBinds) pushBack (_modName + "_" + _actionId);
_modId = (_registry select 0) find _modName;
TRACE_2("",_modId,_modName);

if(_modId == -1) then {
    (_registry select 0) pushBack _modName;
    _modId = (_registry select 1) pushBack [[],[]];
};

_modRegistry = (_registry select 1) select _modId;

_actionEntryId = (_modRegistry select 0) find _actionId;
TRACE_3("",_actionEntryId,_actionId, _modRegistry);

if(_actionEntryId == -1) then {
    (_modRegistry select 0) pushBack _actionId;
    _actionEntryId = (_modRegistry select 1) pushBack [_displayName, _defaultKeybind];
};
_actionEntry = (_modRegistry select 1) select _actionEntryId;
_actionEntry set[0, _displayName];

_hashDown = format["%1_%2_down", _modName, _actionId];
_hashUp = format["%1_%2_up", _modName, _actionId];

TRACE_3("",_defaultKeybind,_actionEntryId,_hashDown);
TRACE_2("",_actionEntry,_hashUp);

_entryIndex = (GVAR(defaultKeybinds) select 0) find _hashDown;
if(_entryIndex == -1) then {
    _entryIndex = (GVAR(defaultKeybinds) select 0) pushBack _hashDown;
    (GVAR(defaultKeybinds) select 1) set[_entryIndex, []];
};
_defaultEntry = (GVAR(defaultKeybinds) select 1) select _entryIndex;

TRACE_1("",_defaultEntry);

if(_overwrite) then {
    if(IS_CODE(_downCode)) then {
        [_hashDown, "keydown"] call cba_fnc_removeKeyHandler;
    };

    if(IS_CODE(_upCode)) then {
        [_hashUp, "keyup"] call cba_fnc_removeKeyHandler;
    };
    _actionEntry set[1, _defaultKeybind];
};
if(!_overwrite) then {
    _actionEntry set[2, _defaultKeybind];
    _defaultKeybind = _actionEntry select 1;
};

_defaultEntry set[0, _downCode];
_defaultEntry set[1, _upCode];
_defaultEntry set[2, _holdKey];
_defaultEntry set[3, _holdDelay];



if(_defaultKeybind select 0 != -1) then {
    if(IS_CODE(_downCode)) then {
        [_defaultKeybind select 0, _defaultKeybind select 1, _downCode, "keyDown", _hashDown, _holdKey, _holdDelay] call cba_fnc_addKeyHandler;
    };

    if(IS_CODE(_upCode)) then {
        [_defaultKeybind select 0, _defaultKeybind select 1, _upCode, "keyUp", _hashUp] call cba_fnc_addKeyHandler;
    };
};

_keybind = +(_actionEntry select 1); // return a copy
TRACE_1("",_keybind);

GVAR(handlers) = _registry;

// Emit an event that a key has been registered.
["cba_keybinding_registerKeybind", _this] call cba_fnc_localEvent;

_keybind;
