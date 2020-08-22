[
    QGVAR(repetitionMode),
    "LIST",
    [LLSTRING(RepetitionMode), LLSTRING(RepetitionModeTooltip)],
    ELSTRING(common,WeaponsCategory),
    [
        [0, 1, 2, 3],
        [
            [LLSTRING(RepetitionModeOptic), LLSTRING(RepetitionModeOpticTooltip)], // Exit optic view
            [LLSTRING(RepetitionModeTriggerRelease), LLSTRING(RepetitionModeTriggerReleaseTooltip)], // Stop holding trigger
            [LLSTRING(RepetitionModeTriggerPress), LLSTRING(RepetitionModeTriggerPressTooltip)], // Click trigger again
            [LLSTRING(RepetitionModeAuto), LLSTRING(RepetitionModeAutoTooltip)] // Automatic cycle
        ],
        1
    ],
    2 // client setting
] call CBA_fnc_addSetting;
