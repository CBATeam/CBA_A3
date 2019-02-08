class CfgFunctions {
    class CBA {
        class UI {
            class flexiMenu_Add {
                description = "Add a type-based menu source. Result: TBA (WIP)";
                file = QUOTE(PATHTOF(flexiMenu\fnc_add.sqf));
            };
            class flexiMenu_Remove {
                description = "Remove a type-based menu source. Result: TBA (WIP)";
                file = QUOTE(PATHTOF(flexiMenu\fnc_remove.sqf));
            };
            class flexiMenu_setObjectMenuSource {
                description = "Set an object's menu source (variable). Result: TBA (WIP)";
                file = QUOTE(PATHTOF(flexiMenu\fnc_setObjectMenuSource.sqf));
            };
            class flexiMenu_openMenuByDef {
                description = "Open a previously defined menu by passing the exact parameters used with cba_fnc_fleximenu_add. Result: TBA (WIP)";
                file = QUOTE(PATHTOF(flexiMenu\fnc_openMenuByDef.sqf));
            };
            class flexiMenu_keyDown {
                file = QUOTE(PATHTOF(flexiMenu\fnc_keyDown.sqf));
            };
            class flexiMenu_keyUp {
                file = QUOTE(PATHTOF(flexiMenu\fnc_keyUp.sqf));
            };
            class flexiMenu_menu {
                file = QUOTE(PATHTOF(flexiMenu\fnc_menu.sqf));
            };
            class flexiMenu_list {
                file = QUOTE(PATHTOF(flexiMenu\fnc_list.sqf));
            };
            class flexiMenu_getMenuDef {
                file = QUOTE(PATHTOF(flexiMenu\fnc_getMenuDef.sqf));
            };
            class flexiMenu_getMenuOption {
                file = QUOTE(PATHTOF(flexiMenu\fnc_getMenuOption.sqf));
            };
            class flexiMenu_menuShortcut {
                file = QUOTE(PATHTOF(flexiMenu\fnc_menuShortcut.sqf));
            };
            class flexiMenu_mouseButtonDown {
                file = QUOTE(PATHTOF(flexiMenu\fnc_mouseButtonDown.sqf));
            };
            class flexiMenu_highlightCaretKey {
                file = QUOTE(PATHTOF(flexiMenu\fnc_highlightCaretKey.sqf));
            };
            class flexiMenu_execute {
                file = QUOTE(PATHTOF(flexiMenu\fnc_execute.sqf));
            };
            PATHTO_FNC(addPauseMenuOption);
            PATHTO_FNC(progressBar);
            PATHTO_FNC(getFov);
            PATHTO_FNC(getAspectRatio);
            PATHTO_FNC(getUISize);
        };
    };
};
