class CSLA_baseWeapon: Rifle_Base_F {};

class CSLA_OP63_Base: CSLA_baseWeapon {
    magazineWell[] += {"CBA_762x54R_SVD"};
};

class CSLA_rSa61: CSLA_baseWeapon {
    magazineWell[] += {"CBA_32ACP_Vz61"};
};

class CSLA_Sa58_Base: CSLA_baseWeapon {
    magazineWell[] += {"CBA_762x39_AK"};
};

class CSLA_MachinegunBase_5_56: CSLA_baseWeapon {};

class CSLA_MachinegunBase_7_62: CSLA_MachinegunBase_5_56 {};

class CSLA_UK59L: CSLA_MachinegunBase_7_62 {
    magazineWell[] += {"CBA_762x54R_Vz59_LINKS"};
};

class CSLA_PistolBase: Pistol_Base_F {};

class CSLA_Pi52: CSLA_PistolBase {
    magazineWell[] += {"CBA_762x25_TT"};
};

class CSLA_Pi82: CSLA_Pi52 {
    magazineWell[] += {"CBA_9x18_CZ82"};
};

class CSLA_Sa61: CSLA_Pi52 {
    magazineWell[] += {"CBA_32ACP_Vz61"};
};

class CSLA_LauncherBase: Launcher_Base_F {};

class CSLA_RPG7: CSLA_LauncherBase {
    magazineWell[] += {"CBA_RPG7"};
};

class US85_weaponBase: Rifle_Base_F {};

class US85_FAL_BASE: US85_weaponBase {
    magazineWell[] += {"CBA_762x51_FAL", "CBA_762x51_FAL_L"};
};

class US85_M16_base: US85_weaponBase {
    magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
};

class US85_M21_Base: US85_weaponBase {
    magazineWell[] += {"CBA_762x51_M14", "CBA_762x51_M14_L"};
};

class US85_MPV_BASE: US85_weaponBase {
    magazineWell[] += {"CBA_9x19_MP5"};
};

class US85_MachinegunBase_5_56: US85_weaponBase {};

class US85_M249: US85_MachinegunBase_5_56 {
    magazineWell[] += {"CBA_556x45_MINIMI"};
};

class US85_MachinegunBase_7_62: US85_MachinegunBase_5_56 {};

class US85_M60: US85_MachinegunBase_7_62 {
    magazineWell[] += {"CBA_762x51_LINKS"};
};

class US85_pistolBase: Pistol_Base_F {};

class US85_1911 {
    magazineWell[] += {"CBA_45ACP_1911"};
};

class US85_M9: US85_pistolBase {
    magazineWell[] += {"CBA_9x19_M9"};
};

class US85_launcherBase: Launcher_Base_F {};

class US85_MAAWS: US85_launcherBase {
    magazineWell[] += {"CBA_Carl_Gustaf"};
};
