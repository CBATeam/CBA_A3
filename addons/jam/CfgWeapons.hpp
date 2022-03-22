class CfgWeapons {
    class Rifle_Base_F;
    class mk20_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG"};
    };

    class SDAR_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG"};
    };

    class Tavor_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D"};
    };

    class arifle_SPAR_01_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class arifle_SPAR_02_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class GrenadeLauncher;
    class UGL_F: GrenadeLauncher {
        magazineWell[] += {"CBA_40mm_M203","CBA_40mm_EGLM"};
    };

    class arifle_MX_Base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_65x39_MX","CBA_65x39_MX_XL"};
    };

    class arifle_Katiba_Base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_65x39_Katiba"};
    };

    class arifle_ARX_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_65x39_Katiba"};
    };

    class Rifle_Long_Base_F;
    class EBR_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x51_M14"};
    };

    class DMR_03_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x51_MkI_EMR"};
    };

    class DMR_06_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x51_M14"};
    };

    class arifle_SPAR_03_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_762x51_HK417","CBA_762x51_HK417_L","CBA_762x51_HK417_XL"}; // empty in vanilla
    };

    class DMR_01_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x54R_SVD"};
    };

    class arifle_CTAR_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_580x42_TYPE95","CBA_580x42_TYPE95_XL"};
    };

    class arifle_CTARS_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_580x42_TYPE95","CBA_580x42_TYPE95_XL"};
    };

    class arifle_AK12_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_762x39_AK","CBA_762x39_RPK"};
    };

    class arifle_AKM_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_762x39_AK","CBA_762x39_RPK"};
    };

    class arifle_AKS_base_F: Rifle_Base_F {
        magazineWell[] += {"CBA_545x39_AK","CBA_545x39_RPK"};
    };

    class LMG_03_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_556x45_MINIMI"}; // empty in vanilla
    };

    class LMG_Mk200_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_65x39_Mk200"}; // empty in vanilla
    };

    class LMG_Zafir_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_762x54R_LINKS"}; // empty in vanilla
    };

    class Launcher_Base_F;
    class launch_MRAWS_base_F: Launcher_Base_F {
        magazineWell[] += {"CBA_Carl_Gustaf"}; // empty in vanilla
    };

    class launch_RPG7_F: Launcher_Base_F {
        magazineWell[] += {"CBA_RPG7"};
    };

    class MMG_01_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_93x64_LINKS"}; // empty in vanilla
    };

    class MMG_02_base_F: Rifle_Long_Base_F {
        magazineWell[] += {"CBA_338NM_LINKS"}; // empty in vanilla
    };

    class Rifle_Short_Base_F;
    class SMG_01_Base: Rifle_Short_Base_F {
        magazineWell[] += {"CBA_45ACP_Glock_Full"}; // empty in vanilla
    };

    class SMG_02_base_F: Rifle_Short_Base_F {
        magazineWell[] += {"CBA_9x19_ScorpionEvo3"}; // empty in vanilla
    };

    class SMG_03_TR_BASE: Rifle_Base_F {
        magazineWell[] += {"CBA_57x28_P90"}; // empty in vanilla
    };

    class SMG_05_base_F: Rifle_Short_Base_F {
        magazineWell[] += {"CBA_9x19_MP5"}; // empty in vanilla
    };

    class Pistol_Base_F;
    class hgun_ACPC2_F: Pistol_Base_F {
        magazineWell[] += {"CBA_45ACP_1911"};
    };

    // VN
    class vn_rifle: Rifle_Base_F {};

    class vn_m16: vn_rifle {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class vn_rifle762: vn_rifle {};

    class vn_m1carbine: vn_rifle762 {
        magazineWell[] += {"CBA_30Carbine_M1Carbine"};
    };

    class vn_m14: vn_rifle762 {
        magazineWell[] += {"CBA_762x51_M14", "CBA_762x51_M14_L", "CBA_762x51_M14_XL"};
    };

    class vn_sks: vn_rifle762 {
        magazineWell[] += {"CBA_762x39_SKS"};
    };

    class vn_type56: vn_rifle762 {
        magazineWell[] += {"CBA_762x39_AK","CBA_762x39_RPK"};
    };

    class vn_rifle_boltaction_base: vn_rifle762 {};

    class m40a1: vn_rifle_boltaction_base {
        magazineWell[] += {"CBA_762x51_5rnds"};
    };

    class vn_rifle_boltaction_clip_base: vn_rifle_boltaction_base {};

    class vn_m38: vn_rifle_boltaction_clip_base {
        magazineWell[] += {"CBA_762x54R_Mosin"};
    };

    class vn_lmg: vn_rifle {};

    class vn_dp28: vn_lmg {
        magazineWell[] += {"CBA_762x54R_DPM"};
    };

    class vn_m60: vn_lmg {
        magazineWell[] += {"CBA_762x51_LINKS"};
    };

    class vn_pk: vn_lmg {
        magazineWell[] += {"CBA_762x54R_LINKS"};
    };

    class vn_smg: vn_rifle {};

    class vn_m1a1_tommy: vn_smg {
        magazineWell[] += {"CBA_45ACP_Thompson_Stick"};
    };

    class vn_m1928_tommy: vn_m1a1_tommy {
        magazineWell[] += {"CBA_45ACP_Thompson_Drum", "CBA_45ACP_Thompson_Stick"};
    };

    class vn_m3a1: vn_smg {
        magazineWell[] += {"CBA_45ACP_Grease"};
    };

    class vn_mp40: vn_smg {
        magazineWell[] += {"CBA_9x19_MP40"};
    };

    class vn_pps52: vn_smg {
        magazineWell[] += {"CBA_762x25_PPS"};
    };

    class vn_ppsh41: vn_smg {
        magazineWell[] += {"CBA_762x25_PPSh_Drum", "CBA_762x25_PPSh_Stick"};
    };

    class vn_sten: vn_smg {
        magazineWell[] += {"CBA_9x19_STEN"};
    };

    class vn_vz61: vn_smg {
        magazineWell[] += {"CBA_32ACP_Vz61"};
    };

    class vn_shotgun: vn_rifle {};

    class vn_izh54: vn_shotgun {
        magazineWell[] += {"CBA_12g_2rnds", "CBA_12g_1rnd"};
    };

    class vn_m1897: vn_shotgun {
        magazineWell[] += {"CBA_12g_6rnds", "CBA_12g_5rnds", "CBA_12g_4rnds", "CBA_12g_3rnds", "CBA_12g_2rnds", "CBA_12g_1rnd"};
    };

    class vn_pistol: Pistol_Base_F {};

    class vn_hd: vn_pistol {};

    class vn_m1911: vn_pistol {
        magazineWell[] += {"CBA_45ACP_1911"};
    };

    class vn_mk22: vn_pistol {};

    class vn_m10: vn_mk22 {
        magazineWell[] += {"CBA_38_Special_6rnds"};
    };

    class vn_m712: vn_pistol {
        magazineWell[] += {"CBA_763x25_M712"};
    };

    class vn_m1895: vn_mk22 {
        magazineWell[] += {"CBA_762x38R_Nagant"};
    };

    class vn_pm: vn_pistol {
        magazineWell[] += {"CBA_9x18_PM"};
    };

    class vn_tt33: vn_pistol {
        magazineWell[] += {"CBA_762x25_TT"};
    };

    class vn_vz61_p: vn_pistol {
        magazineWell[] += {"CBA_32ACP_Vz61"};
    };

    class vn_welrod: vn_hd {
        magazineWell[] += {"CBA_32ACP_Welrod"};
    };

    class vn_Launcher_Base_F: Launcher_Base_F {};

    class vn_rpg7: vn_Launcher_Base_F {
        magazineWell[] += {"CBA_RPG7"};
    };
};
