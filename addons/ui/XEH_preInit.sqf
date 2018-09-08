#include "script_component.hpp"

[
    QGVAR(StorePasswords), "LIST",
    ["STR_CBA_Ui_StoreServerPasswords", "STR_CBA_Ui_StoreServerPasswordsTooltip"],
    "STR_CBA_Ui_Category",
    [[1, 0, -1], [
        ["STR_CBA_Ui_SavePasswords", "STR_CBA_Ui_SavePasswordsTooltip"],
        ["STR_CBA_Ui_DoNotSavePasswords", "STR_CBA_Ui_DoNotSavePasswordsTooltip"],
        ["STR_CBA_Ui_DeletePasswords", "STR_CBA_Ui_DeletePasswordsTooltip"]
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
