
[
    QGVAR(ConsoleIndentType), "LIST",
    [LLSTRING(ConsoleIndentType), LLSTRING(ConsoleIndentTypeTooltip)],
    [LELSTRING(main,DisplayName), LELSTRING(UI,Category)],
    [
        [-1, 0],
        [localize "STR_A3_OPTIONS_DISABLED", LLSTRING(ConsoleIndentSpaces)],
        0
    ],
    2
] call CBA_fnc_addSetting;

[
    QGVAR(watchInfoRefreshRate), "SLIDER",
    [LLSTRING(WatchInfoRefreshRate), LLSTRING(WatchInfoRefreshRateTooltip)],
    [LELSTRING(main,DisplayName), LELSTRING(UI,Category)],
    [0.2, 60, 0.2, 1],
    1,
    {
        params ["_value"];
        GVAR(watchInfoRefreshRateArray) = [_value - 0.1, _value, _value + 0.1];
    }
] call CBA_fnc_addSetting;
