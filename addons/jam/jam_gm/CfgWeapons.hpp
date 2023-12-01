class CfgWeapons {
    class Rifle_Base_F;

    class gm_rifle_base: Rifle_Base_F {};

    class gm_ak47_base: gm_rifle_base {
        magazineWell[] += {"CBA_762x39_AK","CBA_762x39_RPK"};
    };

    class gm_ak74_base: gm_rifle_base {
        magazineWell[] += {"CBA_545x39_AK","CBA_545x39_RPK"};
    };

    class gm_g3_base: gm_rifle_base {
        magazineWell[] += {"CBA_762x51_G3"};
    };

    class gm_g36_base: gm_rifle_base {
        magazineWell[] += {"CBA_556x45_G36"};
    };

    class gm_m16_base: gm_rifle_base {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class gm_mp2_base: gm_rifle_base {
        magazineWell[] += {"CBA_9x19_UZI"};
    };

    class gm_mp5_base: gm_rifle_base {
        magazineWell[] += {"CBA_9x19_MP5"};
    };

    class gm_pm63_base: gm_rifle_base {
        magazineWell[] += {"CBA_9x18_PM63"};
    };

    class gm_svd_base: gm_rifle_base {
        magazineWell[] += {"CBA_9x18_PM63"};
    };

    class gm_machineGun_base: gm_rifle_base {};

    class gm_mg3_base: gm_machineGun_base {
        magazineWell[] += {"CBA_762x51_LINKS"};
    };

    class gm_pk_base: gm_machineGun_base {
        magazineWell[] += {"CBA_762x54R_LINKS"};
    };

    class Pistol_Base_F;

    class gm_pistol_base: Pistol_Base_F {};

    class gm_p1_base: gm_pistol_base {
        magazineWell[] += {"CBA_9x19_P38"};
    };

    class gm_pm_base: gm_pistol_base {
        magazineWell[] += {"CBA_9x18_PM"};
    };

    class Launcher_Base_F;

    class gm_launcher_base: Launcher_Base_F {};

    class gm_carlgustaf_m2_base: gm_launcher_base {
        magazineWell[] += {"CBA_Carl_Gustaf"};
    };

    class gm_rpg7_base: gm_launcher_base {
        magazineWell[] += {"CBA_RPG7"};
    };
};
