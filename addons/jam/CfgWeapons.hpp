class CfgWeapons {
    class GrenadeLauncher;
    class Rifle_Base_F;
    class Rifle_Long_Base_F;
    class Launcher_Base_F;

    class mk20_base_F: Rifle_Base_F {
        magazineWell[] = {"CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D"};
    };
    class SDAR_base_F: Rifle_Base_F {
        magazineWell[] = {"CBA_556x45_STANAG"};
    };
    class Tavor_base_F: Rifle_Base_F {
        magazineWell[] = {"CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D"};
    };
    class arifle_SPAR_01_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D", "CBA_556x45_STANAG_2D_XL"};
    };
    class arifle_SPAR_02_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D", "CBA_556x45_STANAG_2D_XL"};
    };

    class UGL_F : GrenadeLauncher {
        magazineWell[] = {"CBA_40mm_M203", "CBA_40mm_EGLM"};
    };

    class arifle_MX_Base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_65x39_MX", "CBA_65x39_MX_XL"};
        class GL_3GL_F : UGL_F {
            magazineWell[] = {"CBA_40mm_3GL", "CBA_40mm_M203", "CBA_40mm_EGLM"};
        };
    };

    class EBR_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_762x51_M14"};
    };
    class DMR_06_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_762x51_M14"};
    };
    class arifle_SPAR_03_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_762x51_HK417"};
    };

    class DMR_01_base_F : Rifle_Long_Base_F {
        magazineWell[] = {"CBA_762x54R_SVD"};
    };

    class arifle_CTAR_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_580x42_TYPE95"};
    };
    class arifle_CTARS_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_580x42_TYPE95"};
    };

    class arifle_AK12_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_762x39_AK", "CBA_762x39_RPK"};
    };
    class arifle_AKM_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_762x39_AK", "CBA_762x39_RPK"};
    };

    class arifle_AKS_base_F : Rifle_Base_F {
        magazineWell[] = {"CBA_545x39_AK", "CBA_545x39_RPK"};
    };

    class LMG_03_base_F : Rifle_Long_Base_F {
        magazineWell[] = {"CBA_556x45_MINIMI"};
    };

    class launch_RPG7_F : Launcher_Base_F {
        magazineWell[] = {"CBA_RPG7"};
    };
};
