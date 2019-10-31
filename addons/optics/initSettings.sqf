[
    QGVAR(usePipOptics),
    "CHECKBOX",
    LLSTRING(UsePIP),
    ELSTRING(common,WeaponsCategory),
    true, // default value
    2, // isGlobal
    {
        private _unit = call CBA_fnc_currentUnit;
        [_unit, true] call FUNC(restartCamera);
    }
] call CBA_fnc_addSetting;
