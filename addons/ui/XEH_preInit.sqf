#include "script_component.hpp"

ADDON = false;

#include "initSettings.inc.sqf"

if (hasInterface) then {
    call COMPILE_FILE(flexiMenu\init);

    // recreate after loading a savegame
    addMissionEventHandler ["Loaded", {
        if (!isNil QGVAR(ProgressBarParams)) then {
            QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
        };
    }];

    PREP(openItemContextMenu);
};

// legacy function names
FUNC(Add) = CBA_fnc_flexiMenu_Add;
FUNC(Remove) = CBA_fnc_flexiMenu_Remove;
FUNC(setObjectMenuSource) = CBA_fnc_flexiMenu_setObjectMenuSource;
FUNC(openMenuByDef) = CBA_fnc_flexiMenu_openMenuByDef;
FUNC(keyDown) = CBA_fnc_flexiMenu_keyDown;
FUNC(keyUp) = CBA_fnc_flexiMenu_keyUp;
FUNC(menu) = CBA_fnc_flexiMenu_menu;
FUNC(list) = CBA_fnc_flexiMenu_list;
FUNC(getMenuDef) = CBA_fnc_flexiMenu_getMenuDef;
FUNC(getMenuOption) = CBA_fnc_flexiMenu_getMenuOption;
FUNC(menuShortcut) = CBA_fnc_flexiMenu_menuShortcut;
FUNC(mouseButtonDown) = CBA_fnc_flexiMenu_mouseButtonDown;
FUNC(highlightCaretKey) = CBA_fnc_flexiMenu_highlightCaretKey;
FUNC(execute) = CBA_fnc_flexiMenu_execute;

ADDON = true;
