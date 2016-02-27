#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark"};
        version = VERSION;
        author[] = {"Robalo"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

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
            delete UnderBarrelSlot;
        };
    };

    class GM6_base_F: Rifle_Long_Base_F {};

    class srifle_GM6_F : GM6_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete CowsSlot;
        };
    };

    class LRR_base_F: Rifle_Long_Base_F {};

    class srifle_LRR_F : LRR_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete CowsSlot;
        };
    };

    class DMR_01_base_F : Rifle_Long_Base_F {
        class WeaponSlotsInfo;
    };

    class srifle_DMR_01_F : DMR_01_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete UnderBarrelSlot;
        };
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete PointerSlot;
            delete UnderBarrelSlot;
        };
    };

    class LMG_Zafir_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete PointerSlot;
        };
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_MXC_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete MuzzleSlot;
            delete CowsSlot;
            delete PointerSlot;
        };
    };

    class arifle_MXM_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class arifle_MX_SW_F : arifle_MX_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class arifle_Katiba_Base_F : Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_Katiba_C_F : arifle_Katiba_Base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

    class Tavor_base_F: Rifle_Base_F {
        class WeaponSlotsInfo;
    };

    class arifle_TRG20_F : Tavor_base_F {
        class WeaponSlotsInfo : WeaponSlotsInfo {
            delete MuzzleSlot;
        };
    };

};
