class CfgWeapons {
    class Rifle_Base_F;

    class arifle_Galat_base_lxWS: Rifle_Base_F {
        magazineWell[] += {"CBA_762x39_AK"};
    };

    class arifle_Velko_base_lxWS: arifle_Galat_base_lxWS {
        magazineWell[] += {"CBA_556x45_GALIL"};
    };

    class sgun_aa40_base_lxWS: Rifle_Base_F {
        magazineWell[] += {"CBA_12g_AA12", "CBA_12g_AA12_XL"};
    };

    class Rifle_Long_Base_F;

    class LMG_S77_base_lxWS: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x51_LINKS"};
    };

    class arifle_SPAR_01_base_F;

    class arifle_XMS_Base_lxWS: arifle_SPAR_01_base_F {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class arifle_XMS_Shot_lxWS: arifle_XMS_Base_lxWS {
        class UBS_lxWS: Rifle_Base_F {
            magazineWell[] += {"CBA_12g_6rnds", "CBA_12g_5rnds", "CBA_12g_4rnds", "CBA_12g_3rnds", "CBA_12g_2rnds", "CBA_12g_1rnd"};
        };
    };

    class DMR_06_base_F;

    class arifle_SLR_lxWS: DMR_06_base_F {
        magazineWell[] += {"CBA_762x51_FAL", "CBA_762x51_FAL_L"};
    };
};
