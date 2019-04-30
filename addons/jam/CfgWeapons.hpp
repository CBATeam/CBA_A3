class CfgWeapons {
    class GrenadeLauncher;
    class Rifle_Base_F;
    class Rifle_Long_Base_F;
    class Launcher_Base_F;
    class Rifle_Short_Base_F;

    class mk20_base_F: Rifle_Base_F {
        magazineWell[] = {"STANAG_556x45", "CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D"};
    };
    class SDAR_base_F: Rifle_Base_F {
        magazineWell[] = {"STANAG_556x45", "CBA_556x45_STANAG"};
    };
    class Tavor_base_F: Rifle_Base_F {
        magazineWell[] = {"STANAG_556x45", "CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D"};
    };
    class arifle_SPAR_01_base_F: Rifle_Base_F {
        magazineWell[] = {"STANAG_556x45", "CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D", "CBA_556x45_STANAG_2D_XL"};
    };
    class arifle_SPAR_02_base_F: Rifle_Base_F {
        magazineWell[] = {"STANAG_556x45_Large", "CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D", "CBA_556x45_STANAG_2D_XL"};
    };

    class UGL_F: GrenadeLauncher {
        magazineWell[] = {"CBA_40mm_M203", "CBA_40mm_EGLM"};
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        magazineWell[] = {"MX_65x39", "MX_65x39_Large", "CBA_65x39_MX"};
        class GL_3GL_F: UGL_F {
            magazineWell[] = {"CBA_40mm_3GL", "CBA_40mm_M203", "CBA_40mm_EGLM"};
        };
    };

    class arifle_Katiba_Base_F: Rifle_Base_F {
        magazineWell[] = {"Katiba_65x39", "CBA_65x39_Katiba"};
    };

    class arifle_ARX_base_F: Rifle_Base_F {
        magazineWell[] = {"Katiba_65x39", "CBA_65x39_Katiba"};
    };

    class EBR_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"M14_762x51", "CBA_762x51_M14"};
    };
    class DMR_03_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"M14_762x51", "CBA_762x51_MkI_EMR"};
    };
    class DMR_06_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"M14_762x51", "CBA_762x51_M14"};
    };
    class arifle_SPAR_03_base_F: Rifle_Base_F {
        magazineWell[] = {"CBA_762x51_HK417", "CBA_762x51_HK417_L", "CBA_762x51_HK417_XL"};
    };

    class DMR_01_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"Rahim_762x54", "CBA_762x54R_SVD"};
    };

    class arifle_CTAR_base_F: Rifle_Base_F {
        magazineWell[] = {"CTAR_580x42", "CTAR_580x42_Large", "CBA_580x42_TYPE95", "CBA_580x42_TYPE95_XL"};
    };
    class arifle_CTARS_base_F: Rifle_Base_F {
        magazineWell[] = {"CTAR_580x42", "CTAR_580x42_Large", "CBA_580x42_TYPE95", "CBA_580x42_TYPE95_XL"};
    };

    class arifle_AK12_base_F: Rifle_Base_F {
        magazineWell[] = {"AK_762x39", "CBA_762x39_AK", "CBA_762x39_RPK"};
    };
    class arifle_AKM_base_F: Rifle_Base_F {
        magazineWell[] = {"AK_762x39", "CBA_762x39_AK", "CBA_762x39_RPK"};
    };

    class arifle_AKS_base_F: Rifle_Base_F {
        magazineWell[] = {"AK_545x39", "CBA_545x39_AK", "CBA_545x39_RPK"};
    };

    class LMG_03_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_556x45_MINIMI"};
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_65x39_Mk200"};
    };

    class LMG_Zafir_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_762x54R_LINKS"};
    };

    class launch_MRAWS_base_F: Launcher_Base_F {
        magazineWell[] = {"CBA_Carl_Gustaf"};
    };

    class launch_RPG7_F: Launcher_Base_F {
        magazineWell[] = {"RPG7", "CBA_RPG7"};
    };

    class MMG_01_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_93x64_LINKS"};
    };

    class MMG_02_base_F: Rifle_Long_Base_F {
        magazineWell[] = {"CBA_338NM_LINKS"};
    };

    class SMG_01_Base: Rifle_Short_Base_F {
        magazineWell[] = {"CBA_45ACP_Glock_Full"};
    };

    class SMG_02_base_F: Rifle_Short_Base_F {
        magazineWell[] = {"CBA_9x19_ScorpionEvo3"};
    };

    class SMG_03_TR_BASE: Rifle_Base_F {
        magazineWell[] = {"CBA_57x28_P90"};
    };

    class SMG_05_base_F: Rifle_Short_Base_F {
        magazineWell[] = {"CBA_9x19_MP5"};
    };

};
