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

[
    QGVAR(NotificationSpeed), "LIST",
    LLSTRING(NotificationSpeed),
    [LLSTRING(Category), LLSTRING(NotificationCategory)],
    [[0, 0.2, 0.5, 0.8], ["Instant","Fast","Regular","Slow"], 2]
] call cba_settings_fnc_init;

[
    QGVAR(NotificationLifetime), "SLIDER",
    LLSTRING(NotificationLifetime),
    [LLSTRING(Category), LLSTRING(NotificationCategory)],
    [2, 7, 4, 1]
] call cba_settings_fnc_init;

[
    QGVAR(NotificationMax), "LIST",
    LLSTRING(NotificationMax),
    [LLSTRING(Category), LLSTRING(NotificationCategory)],
    [[1, 2, 3, 4], ["1","2","3","4"], 1]
] call cba_settings_fnc_init;

if (hasInterface) then {
    call COMPILE_FILE(flexiMenu\init);

    // recreate after loading a savegame
    addMissionEventHandler ["Loaded", {
        if (!isNil QGVAR(ProgressBarParams)) then {
            QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
        };
    }];

    GVAR(NotificationCurrentIndex) = 0;
};
