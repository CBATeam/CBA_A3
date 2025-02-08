class asdg_OpticRail;

// Picatinny rails for optic mounts
class asdg_OpticRail1913: asdg_OpticRail { // the "medium" rail, long enough to fit any optic, but not enough to attach a clip-on NVS in front of a long scope.
    class compatibleItems {
        gm_blits_ris_blk = 1;
        gm_c79a1_blk = 1;
        gm_c79a1_oli = 1;
        gm_feroz24_ris_blk = 1;
        gm_feroz51_ris_oli = 1;
        gm_ls1500_ir_ris_blk = 1;
        gm_ls1500_red_ris_blk = 1;
        gm_ls45_ir_ris_blk = 1;
        gm_ls45_red_ris_blk = 1;
        gm_lsminiv_ir_ris_blk = 1;
        gm_lsminiv_red_ris_blk = 1;
        gm_maglite_3d_ris_blk = 1;
        gm_rv_ris_blk = 1;
        gm_streamlight_sl20_ris_blk = 1;
        gm_streamlight_sl20_ris_brn = 1;
        gm_zf10x42_ris_blk = 1;
        gm_zf10x42_ris_oli = 1;
    };
};

class asdg_OpticSideMount: asdg_OpticRail {
    class compatibleItems {};
};

class asdg_OpticSideRail_AK: asdg_OpticSideMount {
    class compatibleItems: compatibleItems {
        gm_nspu_dovetail_blk = 1;
        gm_nspu_dovetail_gry = 1;
        gm_pgo7v_blk = 1;
        gm_pka_dovetail_blk = 1;
        gm_pka_dovetail_gry = 1;
        gm_zfk4x25_blk = 1;
        gm_zln1k_grn_dovetail_blk = 1;
        gm_zln1k_grn_dovetail_gry = 1;
        gm_zln1k_ir_dovetail_blk = 1;
        gm_zln1k_ir_dovetail_gry = 1;
    };
};
class asdg_OpticSideRail_SVD: asdg_OpticSideMount {
    class compatibleItems: compatibleItems {
        gm_nspu_dovetail_blk = 1;
        gm_nspu_dovetail_gry = 1;
        gm_pka_dovetail_blk = 1;
        gm_pka_dovetail_gry = 1;
        gm_pso6x36_1_dovetail_blk = 1;
        gm_pso6x36_1_dovetail_gry = 1;
        gm_pso1_dovetail_blk = 1;
        gm_pso1_dovetail_gry = 1;
    };
};

class asdg_OpticSideRail_RPG7: asdg_OpticSideMount {
    class compatibleItems: compatibleItems {
        gm_pgo7v_blk = 1;
    };
};
