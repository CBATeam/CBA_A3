#include "script_component.hpp"
SCRIPT(XEH_preInit);

if (!hasInterface) exitWith {};

ADDON = false;

// Load DIK to string conversion table.
with uiNamespace do {
    GVAR(keyNames) = [GVAR(keyNamesHash)] call CBA_fnc_deserializeNamespace;
};

GVAR(keyNames) = uiNamespace getVariable QGVAR(keyNames);
GVAR(forbiddenKeys) = uiNamespace getVariable QGVAR(forbiddenKeys);

// Prepare GUI functions and variables.
PREP_SUB(gui,onButtonClick_configure);
PREP_SUB(gui,onButtonClick_delete);
PREP_SUB(gui,onButtonClick_default);
PREP_SUB(gui,onButtonClick_cancel);
PREP_SUB(gui,onComboChanged);
PREP_SUB(gui,onKeyDown);
PREP_SUB(gui,onKeyUp);
//PREP_SUB(gui,onKeyDownNextGen);
//PREP_SUB(gui,onKeyUpNextGen);
PREP_SUB(gui,onLBDblClick);
PREP_SUB(gui,updateGUI);

GVAR(input) = [];
GVAR(frameNoKeyPress) = diag_frameNo;
GVAR(modifiers) = [];
GVAR(firstKey) = [];
GVAR(secondKey) = [];
GVAR(thirdKey) = [];
GVAR(waitingForInput) = false;
GVAR(modPrettyNames) = [[],[]];
GVAR(defaultKeybinds) = [[],[]];
GVAR(activeMods) = [];
GVAR(activeBinds) = [];

/////////////////////////////////////////////////////////////////////////////////

// All keybinds are stored as an array in this format:
// keybind = [DIKcode, shift?, ctrl?, alt?]
//
// example: [15, true, false, false]

// The keybind registry is stored in profileNamespace as "cba_keybinding_registry."
// Permament array that tracks all key configs registered by fnc_registerKeybindHandler.
// Format: Associative array. Access with bis_fnc_getFromPairs.
// [
//   ["modName1", [
//                  ["actionName1", [currentKeybind, defaultKeybind]],
//                  ["actionName2", [currentKeybind, defaultKeybind]],
//                  ["actionName3", [currentKeybind, defaultKeybind]]
//                ],
//   ],
//   ["modName2", [
//                  ["actionName1", [currentKeybind, defaultKeybind]]
//                ],
//   ]
// ]
//
// This clears the keybind registry.
// profileNamespace setVariable ["cba_keybinding_registry", []];

// Temporary array that tracks loaded key handlers for specified keybinds.
// Format: Array of arrays
//      [["modName", "actionName", [keybind], {code}, ehID], ...]
GVAR(handlers) = [[],[]];
GVAR(handlersBackup) = [];

// Counter for indexing added key handlers.
GVAR(ehCounter) = 512;

/////////////////////////////////////////////////////////////////////////////////

// Announce initialization complete
ADDON = true;
