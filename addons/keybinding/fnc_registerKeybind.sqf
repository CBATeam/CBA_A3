/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybind

Description:
 Adds or updates the keybind handler for a specified mod action, and associates
 a function with that keybind being pressed.

Parameters:
 _modName			Name of the registering mod [String]
 _actionId  		Id of the key action. [String]
 _displayName       Pretty name, or an array of the pretty name and a tool tip [String]
 _downCode      	Code for down event, empty string for no code. [Code]
 _upCode            Code for up event, empty string for no code. [Code]
 
 Optional:
 _defaultKeybind	The keybinding data in the format [DIK, [shift, ctrl, alt]] [Array]
 _holdKey           Will the key fire every frame while down [Bool]
 _holdDelay         How long after keydown will the key start firing every frame, in seconds. [Float]
 
Returns:
 Returns the current keybind for the action [Array]

Examples:
 // Register a simple keypress to an action
 // This file should be included for readable DIK codes.
 #include "\a3\editor_f\Data\Scripts\dikCodes.h"
 ["MyMod", "MyKey", ["My Pretty Key Name", "My Pretty Tool Tip"], { _this call mymod_fnc_keyDown }, { _this call mymod_fnc_keyUp }, [DIK_TAB, [false, false, false]]] call cba_fnc_registerKeybind;
 ["MyMod", "MyOtherKey", ["My Other Pretty Key Name", "My Other Pretty Tool Tip"], { _this call mymod_fnc_keyDownOther }, { _this call mymod_fnc_keyUpOther }, [DIK_K, [false, false, false]]] call cba_fnc_registerKeybind;
 


Author:
 Taosenai & Nou
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

_nullKeybind = [-1,[false,false,false]];

PARAMS_5(_modName,_actionId,_displayName,_downCode,_upCode);
DEFAULT_PARAM(5,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(6,_holdKey,false);
DEFAULT_PARAM(7,_holdDelay,0);
DEFAULT_PARAM(8,_overwrite,false);


// Get a local copy of the keybind registry.
_registry = profileNamespace getVariable [QGVAR(registryNew), [[],[]]];
if(!(_modName in GVAR(activeMods))) then {
    GVAR(activeMods) pushBack _modName;
};
GVAR(activeBinds) pushBack (_modName + "_" + _actionId);
_modId = (_registry select 0) find _modName;
if(_modId == -1) then {
    (_registry select 0) pushBack _modName;
    _modId = (_registry select 1) pushBack [[],[]];
};

_modRegistry = (_registry select 1) select _modId;

_actionEntryId = (_modRegistry select 0) find _actionId;
if(_actionEntryId == -1) then {
    (_modRegistry select 0) pushBack _actionId;
    _actionEntryId = (_modRegistry select 1) pushBack [_displayName, _defaultKeybind];
};
_actionEntry = (_modRegistry select 1) select _actionEntryId;
_actionEntry set[0, _displayName];

_hashDown = format["%1_%2_down", _modName, _actionId];
_hashUp = format["%1_%2_up", _modName, _actionId];

_entryIndex = (GVAR(defaultKeybinds) select 0) find _hashDown;
if(_entryIndex == -1) then {
    _entryIndex = (GVAR(defaultKeybinds) select 0) pushBack _hashDown;
    (GVAR(defaultKeybinds) select 1) set[_entryIndex, []];
};
_defaultEntry = (GVAR(defaultKeybinds) select 1) select _entryIndex;

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


GVAR(handlers) = _registry;

// Emit an event that a key has been registered.
["cba_keybinding_registerKeybind", _this] call cba_fnc_localEvent;

_keybind;