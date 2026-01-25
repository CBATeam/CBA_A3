class CfgWeapons {
    class Rifle_Base_F;

    class UGL_F;

    class vn_rifle: Rifle_Base_F {
        class vn_ugl: UGL_F {
            magazineWell[] = {};
        };
    };

    class vn_m16: vn_rifle {
        magazineWell[] += {"CBA_556x45_STANAG","CBA_556x45_STANAG_L","CBA_556x45_STANAG_XL","CBA_556x45_STANAG_2D","CBA_556x45_STANAG_2D_XL"};
    };

    class vn_rifle762: vn_rifle {};

    class vn_k98k: vn_rifle762 {
        magazineWell[] += {"CBA_792x57_K98"};
    };

    class vn_m1carbine: vn_rifle762 {
        magazineWell[] += {"CBA_30Carbine_M1Carbine"};
    };

    class vn_m1_garand: vn_rifle762 {
        magazineWell[] += {"CBA_3006_Garand"};
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

    class vn_mc10: vn_pps52 {
        magazineWell[] = {};
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

    class vn_pistol;

    class vn_hd: vn_pistol {};

    class vn_m1911: vn_pistol {
        magazineWell[] += {"CBA_45ACP_1911"};
    };

    class vn_hp: vn_m1911 {
        magazineWell[] = {"CBA_9x19_HiPower"};
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

    class vn_tt33: vn_pm {
        magazineWell[] = {"CBA_762x25_TT"};
    };

    class vn_vz61_p: vn_pistol {
        magazineWell[] += {"CBA_32ACP_Vz61"};
    };

    class vn_welrod: vn_hd {
        magazineWell[] += {"CBA_32ACP_Welrod"};
    };

    class vn_Launcher_Base_F;

    class vn_rpg7: vn_Launcher_Base_F {
        magazineWell[] += {"CBA_RPG7"};
    };
};
