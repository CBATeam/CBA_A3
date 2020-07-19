
[
    QGVAR(ConsoleIndentType), "LIST",
    [LLSTRING(ConsoleIndentType), LLSTRING(ConsoleIndentTypeTooltip)],
    LELSTRING(Ui,Category),
    [
        [-1, 0, 1],
        [localize "STR_A3_OPTIONS_DISABLED", LLSTRING(ConsoleIndentSpaces), LLSTRING(ConsoleIndentTab)],
        0
    ],
    2
] call CBA_fnc_addSetting;
