private _category = [LELSTRING(main,DisplayName), LLSTRING(Category)];

[
    QGVAR(StorePasswords), "LIST",
    [LLSTRING(StoreServerPasswords), LLSTRING(StoreServerPasswordsTooltip)],
    _category,
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
    _category,
    [1, 10, 4, 1], // default value
    2 // global
] call CBA_fnc_addSetting;

[
    QGVAR(autoExpandOptions),
    "CHECKBOX",
    LLSTRING(AutoExpandOptions),
    _category,
    true,
    2
] call CBA_fnc_addSetting;

[
    QGVAR(hideMissionWorldSuffix),
    "CHECKBOX",
    [LLSTRING(HideMissionWorldSuffix), LLSTRING(HideMissionWorldSuffixTooltip)],
    _category,
    false,
    2,
    {
        if (_this) then {
            profileNamespace setVariable [QGVAR(hideMissionWorldSuffix), _this];
        } else {
            profileNamespace setVariable [QGVAR(hideMissionWorldSuffix), nil];
        };
        saveProfileNamespace;
    }
] call CBA_fnc_addSetting;
