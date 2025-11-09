class CfgWeapons {
    class Pistol_Base_F;

    class hgun_DEagle_RF: Pistol_Base_F {
        magazineWell[] += {"CBA_50AE_DEagle"};
    };

    class hgun_Glock19_RF: Pistol_Base_F {
        magazineWell[] += {"CBA_9x19_Glock_Cpct", "CBA_9x19_Glock_Full"};
    };

    class Rifle_Base_F;

    class arifle_ash12_base_RF : Rifle_Base_F {
        magazineWell[] += {"CBA_9x19_Glock_Cpct", "CBA_9x19_Glock_Full"};
    };

    class Rifle_Long_Base_F;

    class srifle_h6_base_rf : Rifle_Long_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG", "CBA_556x45_STANAG_L", "CBA_556x45_STANAG_XL", "CBA_556x45_STANAG_2D", "CBA_556x45_STANAG_2D_XL"};
    };
};
