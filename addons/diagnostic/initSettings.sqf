
[
    QGVAR(ConsoleIndentType), "LIST",
    [LLSTRING(ConsoleIndentType), LLSTRING(ConsoleIndentTypeTooltip)],
    LELSTRING(Ui,Category),
    [
        [-1, 0],
        [localize "STR_A3_OPTIONS_DISABLED", LLSTRING(ConsoleIndentSpaces)],
        0
    ],
    2
] call CBA_fnc_addSetting;
