[
    QGVAR(usePipOptics),
    "CHECKBOX",
    LSTRING(UsePIP),
    LSTRING(Category),
    true, // default value
    2, // isGlobal
    {
        private _unit = call CBA_fnc_currentUnit;
        [_unit, true] call FUNC(restartCamera);
    }
] call EFUNC(settings,init);
