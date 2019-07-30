class asdg_OpticRail1913;
class asdg_FrontSideRail;
class asdg_UnderSlot;
class asdg_MuzzleSlot;
class asdg_MuzzleSlot_65;
class asdg_MuzzleSlot_556;
class asdg_MuzzleSlot_762;

class asdg_MuzzleSlot_762MG: asdg_MuzzleSlot {
    class compatibleItems;
};

class asdg_MuzzleSlot_762R: asdg_MuzzleSlot {
    class compatibleItems;
};

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
            class MuzzleSlot: asdg_MuzzleSlot_65 {
                iconPosition[] = {0,0.45};
                iconScale = 0.2;
            };
            class PointerSlot: asdg_FrontSideRail {
                iconPosition[] = {0.2,0.45};
                iconScale = 0.25;
            };
        };
    };
    class arifle_MXC_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: MuzzleSlot {
                iconPosition[] = {0,0.4};
            };
            class PointerSlot: PointerSlot {
                iconPosition[] = {0.2,0.4};
            };
        };
    };
    class arifle_MXM_F: arifle_MX_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: MuzzleSlot {
                iconPosition[] = {0,0.4};
            };
        };
    };

    class arifle_Katiba_Base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_65 {
                iconPosition[] = {0,0.45};
                iconScale = 0.2;
            };
        };
    };

    class mk20_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_556 {
                iconPosition[] = {0,0.36};
                iconScale = 0.2;
            };
        };
    };

    class Tavor_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_556 {
                iconPosition[] = {0.1,0.36};
                iconScale = 0.2;
            };
        };
    };

    class arifle_AK12_base_F: Rifle_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762R {
                iconPosition[] = {0,0.35};
                iconScale = 0.2;

                class compatibleItems: compatibleItems {
                    muzzle_snds_B = 1;
                    muzzle_snds_B_khk_F = 1;
                    muzzle_snds_B_snd_F = 1;
                    muzzle_snds_B_arid_F = 1;
                    muzzle_snds_B_lush_F = 1;
                };
            };
            class CowsSlot: asdg_OpticRail1913 {
                iconPosition[] = {0.5,0.25};
                iconScale = 0.2;
            };
            // Cannot 'delete' class, because it is inherited by child classes.
            //class UnderBarrelSlot: asdg_UnderSlot {
            //    iconPosition[] = {0.35,0.7};
            //    iconScale = 0.3;
            //};
        };
    };
    class arifle_AK12_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class UnderBarrelSlot: asdg_UnderSlot {
                iconPosition[] = {0.35,0.7};
                iconScale = 0.3;
            };
        };
    };
    class arifle_AK12_lush_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class UnderBarrelSlot: asdg_UnderSlot {
                iconPosition[] = {0.35,0.7};
                iconScale = 0.3;
            };
        };
    };
    class arifle_AK12_arid_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class UnderBarrelSlot: asdg_UnderSlot {
                iconPosition[] = {0.35,0.7};
                iconScale = 0.3;
            };
        };
    };
    class arifle_AK12U_base_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class CowsSlot: CowsSlot {
                iconPosition[] = {0.4,0.25};
            };
            class UnderBarrelSlot: asdg_UnderSlot {
                iconPosition[] = {0.24,0.7};
                iconScale = 0.3;
            };
        };
    };
    class arifle_RPK12_base_F: arifle_AK12_base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class CowsSlot: CowsSlot {
                iconPosition[] = {0.57,0.31};
                iconScale = 0.17;
            };
        };
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762MG {
                iconPosition[] = {0.1,0.5};
                iconScale = 0.2;

                class compatibleItems: compatibleItems {
                    muzzle_snds_h = 1;
                    muzzle_snds_h_khk_F = 1;
                    muzzle_snds_h_snd_F = 1;
                    muzzle_snds_H_SW = 1;
                    muzzle_snds_H_MG = 1;
                    muzzle_snds_H_MG_blk_F = 1;
                    muzzle_snds_H_MG_khk_F = 1;

                };
            };
        };
    };

    class DMR_01_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762 {
                iconPosition[] = {0,0.45};
                iconScale = 0.2;
            };
        };
    };

    class EBR_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762 {
                iconPosition[] = {0.05,0.38};
                iconScale = 0.2;
            };
        };
    };

    class DMR_03_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762 {
                iconPosition[] = {0.12,0.431};
                iconScale = 0.15;
            };
        };
    };

    class DMR_06_base_F: Rifle_Long_Base_F {
        class WeaponSlotsInfo: WeaponSlotsInfo {
            class MuzzleSlot: asdg_MuzzleSlot_762 {
                iconPosition[] = {0.06,0.4};
                iconScale = 0.15;
            };
        };
    };
};
