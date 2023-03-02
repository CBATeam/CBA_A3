[
    QGVAR(epilepsyFriendlyMode),
    "CHECKBOX",
    [LSTRING(EpilepsyFriendlyMode), LSTRING(EpilepsyFriendlyModeTooltip)],
    LLSTRING(Component),
    false,
    2
] call CBA_fnc_addSetting;

// Sounds

[
    QGVAR(soundsHintAll),
    "CHECKBOX",
    [LSTRING(soundsHintAll), LSTRING(soundsHintAllTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    false,
    2
] call CBA_fnc_addSetting;

[
    QGVAR(soundsHintDuration),
    "SLIDER",
    [LSTRING(soundsHintDuration), LSTRING(soundsHintDurationTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [0.5, 3, 1.5, 1],
    2
] call CBA_fnc_addSetting;

// BREATH
[
    QGVAR(soundsBreath),
    "LIST",
    [LSTRING(soundsBreath), LSTRING(soundsBreathingTooltip)],
    [LLSTRING(Component),  "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// BODILY
[
    QGVAR(soundsBodily),
    "LIST",
    [LSTRING(soundsBodily), LSTRING(soundsBodilyTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// PAIN
[
    QGVAR(soundsPain),
    "LIST",
    [LSTRING(soundsPain), LSTRING(soundsPainTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// SCREAM
[
    QGVAR(soundsScream),
    "LIST",
    [LSTRING(soundsScream), LSTRING(soundsScreamTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// FOOD
[
    QGVAR(soundsFood),
    "LIST",
    [LSTRING(soundsFood), LSTRING(soundsFoodTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// EQUIPMENT
[
    QGVAR(soundsEquipment),
    "LIST",
    [LSTRING(soundsEquipment), LSTRING(soundsEquipmentTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;

// REPETITIVE
[
    QGVAR(soundsRepetitive),
    "LIST",
    [LSTRING(soundsRepetitive), LSTRING(soundsRepetitiveTooltip)],
    [LLSTRING(Component), "str_dn_sounds"],
    [[0,1,2], ["str_enabled", LSTRING(EnabledVisualHint), LSTRING(DisabledVisualHint)], 0],
    2
] call CBA_fnc_addSetting;
