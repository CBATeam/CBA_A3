[
    QGVAR(usePipOptics),
    "CHECKBOX",
    LLSTRING(UsePIP),
    [LELSTRING(main,DisplayName), "str_a3_firing1"],
    true, // default value
    2, // isGlobal
    {
        private _unit = call CBA_fnc_currentUnit;
        [_unit, true] call FUNC(restartCamera);
    }
] call CBA_fnc_addSetting;
