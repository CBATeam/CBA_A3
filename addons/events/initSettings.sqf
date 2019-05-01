[
    QGVAR(repetitionMode),
    "LIST",
    [LLSTRING(RepetitionMode), LLSTRING(RepetitionModeTooltip)],
    ELSTRING(common,WeaponsCategory),
    [
        [0, 1, 2],
        [
            [LLSTRING(RepetitionModeOptic), LLSTRING(RepetitionModeOpticTooltip)], // Exit optic view
            [LLSTRING(RepetitionModeTriggerRelease), LLSTRING(RepetitionModeTriggerReleaseTooltip)], // Stop holding trigger
            [LLSTRING(RepetitionModeTriggerPress), LLSTRING(RepetitionModeTriggerPressTooltip)] // Click trigger again
        ],
        1
    ],
    2 // client setting
] call CBA_fnc_addSetting;
