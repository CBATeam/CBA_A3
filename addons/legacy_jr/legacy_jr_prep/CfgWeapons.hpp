class CfgWeapons {
    class Rifle;
    class Rifle_Base_F: Rifle {
        class WeaponSlotsInfo;
    };
    class Rifle_Long_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };
    class arifle_MXC_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };
    class arifle_MX_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };
    class arifle_MX_GL_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };
    class arifle_MX_SW_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };
    class arifle_MXM_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete PointerSlot;
        };
    };

    class arifle_Katiba_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class mk20_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class Tavor_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

//////////
    class arifle_AK12_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;

            // Cannot 'delete' class, because it is inherited by child classes.
            //delete UnderBarrelSlot;
        };
    };
    class arifle_AK12_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete UnderBarrelSlot;
        };
    };
    class arifle_AK12_lush_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete UnderBarrelSlot;
        };
    };
    class arifle_AK12_arid_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete UnderBarrelSlot;
        };
    };

    class arifle_AK12_GL_base_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {};
    };
    class arifle_AK12_GL_F: arifle_AK12_GL_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
        };
    };
    class arifle_AK12_GL_lush_F: arifle_AK12_GL_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
        };
    };
    class arifle_AK12_GL_arid_F: arifle_AK12_GL_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
        };
    };

    class arifle_AK12U_base_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete UnderBarrelSlot;
        };
    };
    class arifle_RPK12_base_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
        };
    };

//////////










    class LMG_Mk200_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class DMR_01_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class EBR_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class DMR_03_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class DMR_06_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };
};
