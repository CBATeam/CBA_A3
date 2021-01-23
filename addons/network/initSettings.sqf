[
    QGVAR(enableLoadoutValidation),
    "CHECKBOX",
    [LLSTRING(EnableLoadoutValidation), LLSTRING(EnableLoadoutValidationDescription)],
    LSTRING(Component),
    false ,// default value
    1 // Forced on all machines by default
] call CBA_fnc_addSetting;
