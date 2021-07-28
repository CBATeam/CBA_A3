[
    QGVAR(StorePasswords), "LIST",
    [LLSTRING(StoreServerPasswords), LLSTRING(StoreServerPasswordsTooltip)],
    [LELSTRING(main,DisplayName), LLSTRING(Category)],
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
] call CBA_fnc_addSetting;

[
    QGVAR(notifyLifetime),
    "SLIDER",
    [LLSTRING(NotifyLifetime), LLSTRING(NotifyLifetimeTooltip)],
    [LELSTRING(main,DisplayName), LLSTRING(Category)],
    [1, 10, 4, 1], // default value
    2 // global
] call CBA_fnc_addSetting;

[
    QGVAR(contextMenuSelectionMode),
    "LIST",
    [LLSTRING(ContextMenuSelectionMode), LLSTRING(ContextMenuSelectionModeTooltip)],
    [LELSTRING(main,DisplayName), LLSTRING(Category)],
    [[0,1], [
        [LLSTRING(ContextMenuMouseAndKeyboard), LLSTRING(ContextMenuMouseAndKeyboardTooltip)],
        [LLSTRING(ContextMenuMouseOnly), LLSTRING(ContextMenuMouseOnlyTooltip)]
    ], 0],
    2
] call CBA_fnc_addSetting;
