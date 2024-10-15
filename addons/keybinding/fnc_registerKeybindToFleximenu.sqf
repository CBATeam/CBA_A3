#include "script_component.hpp"
/* ----------------------------------------------------------------------------
Function: CBA_fnc_registerKeybindToFleximenu

This function is deprecated. Please use CBA_fnc_addKeybindToFleximenu.

Description:
 Adds or updates the keybind handler for a defined Fleximenu and creates that Fleximenu.

Parameters:
 _modName            - Name of the registering mod [String]
 _actionName        - Name of the action to register [String]
 _fleximenuDef        - Parameter array for CBA_fnc_flexiMenu_Add, but with the keybind set to [] [Array]
 _defaultKeybind    - Default keybind [DIK code, [shift?, ctrl?, alt?]] [Array]

Optional:
 _overwrite            - Overwrite existing keybind data? [Bool] (Default: False)
 _keypressType        - "keydown" (Default) = keyDown, "keyup" = keyUp [String]

Returns:
 Returns the current keybind for the Fleximenu [Array]

Examples:
    (begin example)
  ["Your Mod", "Your Action", ["player", [], -100, "_this call my_menu_code_array"], [15, [true, true, true]]] call cba_fnc_registerKeybindToFleximenu;
    (end example)

Author:
 Taosenai
---------------------------------------------------------------------------- */

// Clients only.
if (isDedicated) exitWith {};
diag_log text format ["[CBA Keybinding] WARNING: %1=>%2 called CBA_fnc_registerKeybindToFleximenu is no longer a valid function and has been replaced with CBA_fnc_addKeybindToFleximenu. Contact the developer of mod %1 to change the code to use the new function.", _this select 0,_this select 1];

private _nullKeybind = [-1, false, false, false];

params ["_modName", "_actionName", "_fleximenuDef", ["_defaultKeybind", _nullKeybind], ["_overwrite", false], ["_keypressType", "KeyDown"]];

// Help the user out by always setting the keycode param of the fleximenu
// def array to []. Give them a warning if it wasn't.
if (count (_fleximenuDef select 1) > 0) then {
    _fleximenuDef set [1, []];
    WARNING("[CBA Keybinding] Fleximenu definition passed to CBA_fnc_registerKeybindToFleximenu included a keycode. Ignoring it.")
};

// Create the fleximenu.
_fleximenuDef call cba_fnc_flexiMenu_add;

// Create the code to open the fleximenu.
private _code = compile format ["%1 call cba_fnc_fleximenu_openMenuByDef;", _fleximenuDef];

// Pass everything to the real cba_fnc_registerKeybind.
private _keybind = [_modName, _actionName, _code, _defaultKeybind, _overwrite, _keypressType] call CBA_fnc_registerKeybind;

_keybind;
