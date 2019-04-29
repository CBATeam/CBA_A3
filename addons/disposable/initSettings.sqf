[
    QGVAR(dropUsedLauncher),
    "LIST",
    LLSTRING(DropUsedLauncher),
    ELSTRING(common,WeaponsCategory),
    [
        [0,1,2],
        [LLSTRING(DropNever), LLSTRING(DropAIOnly), LLSTRING(DropSelectedAnotherWeapon)],
        2
    ],
    0 // isGlobal
] call EFUNC(settings,init);
