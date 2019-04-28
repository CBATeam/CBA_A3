[
    QGVAR(replaceDisposableLauncher),
    "CHECKBOX",
    [LLSTRING(ReplaceDisposableLauncher), LLSTRING(ReplaceDisposableLauncherTooltip)],
    ELSTRING(common,WeaponsCategory),
    true, // default value
    1 // isGlobal
] call EFUNC(settings,init);

[
    QGVAR(dropUsedLauncher),
    "LIST",
    LLSTRING(DropUsedLauncher),
    ELSTRING(common,WeaponsCategory),
    [
        [0,1,2],
        [
            [LLSTRING(DropNever), LLSTRING(DropNeverTooltip)],
            [LLSTRING(DropAIOnly), LLSTRING(DropAIOnlyTooltip)],
            [LLSTRING(DropSelectedAnotherWeapon), LLSTRING(DropSelectedAnotherWeaponTooltip)]
        ],
        2
    ],
    0 // isGlobal
] call EFUNC(settings,init);
