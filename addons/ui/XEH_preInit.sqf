#include "script_component.hpp"

[
    QGVAR(StorePasswords), "LIST",
    [LLSTRING(StoreServerPasswords), LLSTRING(StoreServerPasswordsTooltip)],
    LLSTRING(Category),
    [[1, 0, -1], [
        [LLSTRING(SavePasswords), LLSTRING(SavePasswordsTooltip)],
        [LLSTRING(DoNotSavePasswords), LLSTRING(DoNotSavePasswordsTooltip)],
        [LLSTRING(DeletePasswords), LLSTRING(DeletePasswordsTooltip)]
    ], 0],
    2,
    {
        if (_this isEqualTo -1) then {
            profileNamespace setVariable [QGVAR(ServerPasswords), nil];
        };

        profileNamespace setVariable [QGVAR(StorePasswords), _this];
        saveProfileNamespace;
    }
] call cba_settings_fnc_init;

if (hasInterface) then {
    call COMPILE_FILE(flexiMenu\init);

    // recreate after loading a savegame
    addMissionEventHandler ["Loaded", {
        if (!isNil QGVAR(ProgressBarParams)) then {
            QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
        };
    }];
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
