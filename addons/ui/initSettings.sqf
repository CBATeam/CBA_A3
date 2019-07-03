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
    QGVAR(notifyLifetime),
    "SLIDER",
    [LLSTRING(NotifyLifetime), LLSTRING(NotifyLifetimeTooltip)],
    LLSTRING(Category),
    [1, 10, 4, 1], // default value
    2 // global
] call CBA_fnc_addSetting;
