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
            PATHTO_FNC(addPauseMenuOption);
            PATHTO_FNC(progressBar);
            PATHTO_FNC(getFov);
            PATHTO_FNC(getAspectRatio);
            PATHTO_FNC(getUISize);
            PATHTO_FNC(openLobbyManager);
        };
    };
};
