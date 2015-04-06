/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybindToFleximenu

Description:
 Adds or updates the keybind handler for a defined Fleximenu and creates that Fleximenu.

Parameters:
 _modName			Name of the registering mod [String]
 _actionName		Name of the action to register [String]
 _fleximenuDef		Parameter array for CBA_fnc_flexiMenu_Add, but with the
 					keybind set to [] [Array]
 _defaultKeybind	Default keybind [DIK code, [shift?, ctrl?, alt?]] [Array]

Optional:
 _overwrite			Overwrite existing keybind data? [Bool] (Default: False)
 _keypressType		"keydown" (Default) = keyDown, "keyup" = keyUp [String]

Returns:
 Returns the current keybind for the Fleximenu [Array]

Examples:
 ["Your Mod", "Your Action", ["player", [], -100, "_this call my_menu_code_array"], [15, [true, true, true]]] call cba_fnc_registerKeybindToFleximenu;

Author:
 ViperMaul and Nou
---------------------------------------------------------------------------- */

#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

_nullKeybind = [-1,[false,false,false]];

PARAMS_5(_modName,_actionId,_displayName, _fleximenuDef);
DEFAULT_PARAM(5,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(6,_holdKey,true);
DEFAULT_PARAM(7,_holdDelay,0);
DEFAULT_PARAM(8,_overwrite,false);

// Help the user out by always setting the keycode param of the fleximenu
// def array to []. Give them a warning if it wasn't.
if (count (_fleximenuDef select 1) > 0) then {
	_fleximenuDef set [1, []];
	WARNING("Fleximenu definition passed to CBA_fnc_registerKeybindToFleximenu included a keycode. Ignoring it.")
};

// Create the fleximenu.
_fleximenuDef call cba_fnc_flexiMenu_add;

// Create the code to open the fleximenu.
_downCode = compile format ["%1 call cba_fnc_fleximenu_openMenuByDef;", _fleximenuDef];
_upCode = {};

// Pass everything to the new API cba_fnc_addKeybind.
_keybind = [_modName, _actionId, [_displayName,"Tool Tip"], _downCode, _upCode, _defaultKeybind, _holdKey, _holdDelay, _overwrite] call cba_fnc_addKeybind;

_keybind;
