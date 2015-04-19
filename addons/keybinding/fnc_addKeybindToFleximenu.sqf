/* ----------------------------------------------------------------------------
Function: CBA_fnc_addKeybindToFleximenu

Description:
 Adds or updates the keybind handler for a defined Fleximenu and creates that Fleximenu.

Parameters:
 _modName			- Name of the registering mod [String]
 _actionName		- Name of the action to register [String]
 _displayName		- Pretty name, or an array of strings for the pretty name and a tool tip [String]
 _fleximenuDef		- Parameter array for CBA_fnc_flexiMenu_Add, but with the keybind set to [] [Array]

Optional:
 _defaultKeybind	- Default keybind [DIK code, [shift?, ctrl?, alt?]] [Array]
 _holdKey           - Will the key fire every frame while down [Bool] (Default: true)
 _holdDelay         - How long after keydown will the key event fire, in seconds. [Float] (Default: 0)
 _overwrite			- Overwrite existing keybind data? [Bool] (Default: False)


Returns:
 Returns the current keybind for the Fleximenu [Array]

Examples:
	(begin example)
 ["Your Mod", "Your_Action_Key", ["Your Action","ToolTip"], ["player", [], -100, "_this call my_menu_code_array"], [15, [true, true, true]]] call cba_fnc_addKeybindToFleximenu;
	(end example)
	(begin example)
 ["Your Mod", "Your_Action_Key", "Your Action", ["player", [], -100, "_this call my_menu_code_array"], [15, [true, true, true]]] call cba_fnc_addKeybindToFleximenu;
	(end example)
Author:
 ViperMaul
---------------------------------------------------------------------------- */
//#define DEBUG_MODE_FULL
#include "\x\cba\addons\keybinding\script_component.hpp"

// Clients only.
if (isDedicated) exitWith {};

_nullKeybind = [-1,[false,false,false]];

PARAMS_4(_modName,_actionId,_displayName,_fleximenuDef);
DEFAULT_PARAM(4,_defaultKeybind,_nullKeybind);
DEFAULT_PARAM(5,_holdKey,true);
DEFAULT_PARAM(6,_holdDelay,0);
DEFAULT_PARAM(7,_overwrite,false);

if (typeName(_fleximenuDef) != "Array") then { WARNING("Fleximenu definition passed is not in Array format") };

// Help the user out by always setting the keycode param of the fleximenu
// def array to []. Give them a warning if it wasn't.
if (count (_fleximenuDef select 1) > 0) then {
	_fleximenuDef set [1, []];
	WARNING("Fleximenu definition passed to CBA_fnc_addKeybindToFleximenu included a keycode. Ignoring it.")
};

// Create the fleximenu.
_fleximenuDef call cba_fnc_flexiMenu_add;

// Create the code to open the fleximenu.
_downCode = compile format ["%1 call cba_fnc_fleximenu_openMenuByDef;", _fleximenuDef];
_upCode = {};

// Pass everything to the new API cba_fnc_addKeybind.
_keybind = [_modName, _actionId, _displayName, _downCode, _upCode, _defaultKeybind, _holdKey, _holdDelay, _overwrite] call cba_fnc_addKeybind;

_keybind;
