#include "script_component.hpp"

ADDON = false;

#include "initSettings.sqf"

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

// reserved slots
["CBA_loadingScreenDone", {
    private _storedUID = profileNamespace getVariable [QGVAR(SteamUID), ""];
    private _currentUID = getPlayerUID player;

    if (_storedUID != _currentUID) then {
        // Store UID in profile for reserved slots framework.
        if !(_currentUID in ["", "_SP_AI_", "_SP_PLAYER_"]) then {
            profileNamespace setVariable [QGVAR(SteamUID), _currentUID];
            saveProfileNamespace;

            // End the mission if the UID has been modified.
            if (_storedUID != "") then {
                ERROR_2("Mismatching UID in profile. Profile: %1, Unit: %2", _storedUID, _currentUID);
                uiNamespace getVariable "RscDisplayMission" closeDisplay 0;
            };
        };
    };
}] call CBA_fnc_addEventHandler;

ADDON = true;
