[
    QGVAR(weaponEventMode),
    "LIST",
    [LLSTRING(WeaponEventMode), LLSTRING(WeaponEventModeTooltip)],
    LLSTRING(Category),
    [[0, 1, 2], [
        [LLSTRING(WeaponEventModeOptic), LLSTRING(WeaponEventModeOpticTooltip)], // Exit optic view
        [LLSTRING(WeaponEventModeTriggerRelease), LLSTRING(WeaponEventModeTriggerReleaseTooltip)], // Stop holding trigger
        [LLSTRING(WeaponEventModeTriggerPress), LLSTRING(WeaponEventModeTriggerPressTooltip)] // Click trigger again
    ], 1],
    2
] call CBA_fnc_addSetting;
