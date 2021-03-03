[
    QGVAR(loadoutValidation),
    "LIST",
    [LLSTRING(LoadoutValidation), LLSTRING(LoadoutValidationTooltip)],
    LSTRING(Component),
    [
        [0, 1, 2],
        [
            [LLSTRING(NeverValidate), LLSTRING(NeverValidateTooltip)],
            [LLSTRING(ValidatePlayableOnly), LLSTRING(ValidatePlayableOnlyTooltip)],
            [LLSTRING(ValidateAll), LLSTRING(ValidateAllTooltip)]
        ],
        0 // Disabled by default
    ],
    1 // Forced on all machines by default
] call CBA_fnc_addSetting;
