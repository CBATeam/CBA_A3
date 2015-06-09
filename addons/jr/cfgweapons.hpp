class CfgWeapons {

    class Rifle_Base_F;
    
    class Rifle_Long_Base_F : Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class EBR_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_EBR_F : EBR_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_762 {
                iconPosition[] = {0.05, 0.38};
                iconScale = 0.2;
            };
            class CowsSlot : asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.3};
                iconScale = 0.2;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.4};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.3, 0.65};
                iconScale = 0.2;
            };
        };
    };

    class GM6_base_F: Rifle_Long_Base_F {};

    class srifle_GM6_F : GM6_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.55, 0.3};
                iconScale = 0.2;
            };
        };
    };

    class LRR_base_F: Rifle_Long_Base_F {};

    class srifle_LRR_F : LRR_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.6, 0.35};
                iconScale = 0.2;
            };
        };
    };

    class DMR_01_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_01_F : DMR_01_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot : asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.38};
                iconScale = 0.2;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.5};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.4, 0.7};
                iconScale = 0.2;
            };
        };
    };

    class DMR_02_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_02_F : DMR_02_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_338 {
                iconPosition[] = {0, 0.4};
                iconScale = 0.2;
            };
            class CowsSlot : asdg_OpticRail1913_long {
                iconPosition[] = {0.5, 0.36};
                iconScale = 0.2;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.22, 0.42};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.2, 0.8};
                iconScale = 0.3;
            };
        };
    };

    class DMR_03_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_03_F : DMR_03_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_762 {
                iconPosition[] = {0.12, 0.431};
                iconScale = 0.15;
            };
            class CowsSlot : asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.36};
                iconScale = 0.15;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.33, 0.4};
                iconScale = 0.2;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.3, 0.8};
                iconScale = 0.3;
            };
        };
    };

    class DMR_04_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_04_F : DMR_04_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot : asdg_OpticRail1913 {
                iconPosition[] = {0.52, 0.38};
                iconScale = 0.15;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.3, 0.43};
                iconScale = 0.2;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.3, 0.7};
                iconScale = 0.2;
            };
        };
    };

    class DMR_05_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_05_blk_F : DMR_05_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_93x64 {
                iconPosition[] = {0, 0.43};
                iconScale = 0.2;
            };
            class CowsSlot : asdg_OpticRail1913_long {
                iconPosition[] = {0.5, 0.38};
                iconScale = 0.2;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.22, 0.43};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.2, 0.8};
                iconScale = 0.3;
            };
        };
    };

    class DMR_06_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_06_camo_F : DMR_06_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_762 {
                iconPosition[] = {0.06, 0.4};
                iconScale = 0.15;
            };
            class CowsSlot : asdg_OpticRail1913_short {
                iconPosition[] = {0.52, 0.36};
                iconScale = 0.15;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.32, 0.8};
                iconScale = 0.3;
            };
        };
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913_short_MG {
                iconPosition[] = {0.6, 0.45};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.5};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.35, 0.8};
                iconScale = 0.2;
            };
        };
    };

    class LMG_Zafir_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913_short_MG {
                iconPosition[] = {0.6, 0.35};
                iconScale = 0.15;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.4, 0.4};
                iconScale = 0.15;
            };
        };
    };

    class MMG_01_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class MMG_01_hex_F : MMG_01_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_93x64 {
                iconPosition[] = {0.06, 0.4};
                iconScale = 0.15;
            };
            class CowsSlot : asdg_OpticRail1913 {
                iconPosition[] = {0.57, 0.28};
                iconScale = 0.15;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.38, 0.42};
                iconScale = 0.2;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.35, 0.85};
                iconScale = 0.3;
            };
        };
    };

    class MMG_02_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class MMG_02_camo_F : MMG_02_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_338 {
                iconPosition[] = {0.06, 0.42};
                iconScale = 0.15;
            };
            class CowsSlot : asdg_OpticRail1913_short_MG {
                iconPosition[] = {0.62, 0.32};
                iconScale = 0.15;
            };
            class PointerSlot : asdg_FrontSideRail {
                iconPosition[] = {0.38, 0.42};
                iconScale = 0.2;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.35, 0.85};
                iconScale = 0.3;
            };
        };
    };

    class arifle_Katiba_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_Katiba_F : arifle_Katiba_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.28};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.45};
                iconScale = 0.2;
            };
        };
    };

    class arifle_Katiba_C_F : arifle_Katiba_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.28};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.45};
                iconScale = 0.2;
            };
        };
    };

    class arifle_Katiba_GL_F : arifle_Katiba_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.28};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.45};
                iconScale = 0.2;
            };
        };
    };

    class mk20_base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_Mk20_F : mk20_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_556 {
                iconPosition[] = {0, 0.38};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.25};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.35};
                iconScale = 0.25;
            };
        };
    };

    class arifle_Mk20C_F : mk20_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_556 {
                iconPosition[] = {0, 0.38};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.35};
                iconScale = 0.25;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.25};
                iconScale = 0.2;
            };
        };
    };

    class arifle_Mk20_GL_F : mk20_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_556 {
                iconPosition[] = {0, 0.38};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.35, 0.35};
                iconScale = 0.25;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.25};
                iconScale = 0.2;
            };
        };
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_MXC_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.3};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2, 0.4};
                iconScale = 0.25;
            };
        };
    };

    class arifle_MX_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.35};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2, 0.45};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.2, 0.7};
                iconScale = 0.2;
            };
        };
    };

    class arifle_MX_GL_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.35};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2, 0.45};
                iconScale = 0.25;
            };
        };
    };

    class arifle_MX_SW_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.35};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2, 0.45};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.2, 0.7};
                iconScale = 0.2;
            };
        };
    };

    class arifle_MXM_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.35};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2, 0.45};
                iconScale = 0.25;
            };
            class UnderBarrelSlot : asdg_UnderSlot {
                iconPosition[] = {0.2, 0.7};
                iconScale = 0.2;
            };
        };
    };

    class Tavor_base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_TRG21_F : Tavor_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_556 {
                iconPosition[] = {0, 0.4};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913_short {
                iconPosition[] = {0.45, 0.28};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.25, 0.4};
                iconScale = 0.25;
            };
        };
    };

    class arifle_TRG20_F : Tavor_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_556 {
                iconPosition[] = {0.1, 0.4};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913_short {
                iconPosition[] = {0.45, 0.28};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.25, 0.4};
                iconScale = 0.25;
            };
        };
    };

    class SMG_01_Base: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class SMG_01_F : SMG_01_Base {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_45ACP_SMG {
                iconPosition[] = {0.1, 0.4};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.4, 0.3};
                iconScale = 0.2;
            };
        };
    };

    class SMG_02_base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class SMG_02_F : SMG_02_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_9MM_SMG {
                iconPosition[] = {0.08, 0.4};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.45, 0.27};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.28, 0.4};
                iconScale = 0.25;
            };
        };
    };

    class pdw2000_base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class hgun_PDW2000_F : pdw2000_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            class MuzzleSlot : asdg_MuzzleSlot_9MM_SMG {
                iconPosition[] = {0.0, 0.45};
                iconScale = 0.2;
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5, 0.4};
                iconScale = 0.15;
            };
        };
    };

};
