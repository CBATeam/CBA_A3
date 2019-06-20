class CfgMagazineWells {

    // Rifle calibre magwells, ordered lexicographically in metric and imperial groups
    #include "magwells_11x59R.hpp"
    #include "magwells_145x114.hpp"
    #include "magwells_46x30.hpp"
    #include "magwells_545x39.hpp"
    #include "magwells_556x45.hpp"
    #include "magwells_580x42.hpp"
    #include "magwells_65C.hpp"
    #include "magwells_65G.hpp"
    #include "magwells_65x39.hpp"
    #include "magwells_68SPC.hpp"
    #include "magwells_75x54mmFrench.hpp"
    #include "magwells_75x55.hpp"
    #include "magwells_762x39.hpp"
    #include "magwells_762x51.hpp"
    #include "magwells_762x54.hpp"
    #include "magwells_77x58.hpp"
    #include "magwells_792x107mmDS.hpp"
    #include "magwells_792x33.hpp"
    #include "magwells_792x57.hpp"
    #include "magwells_8x50mmR_Mannlicher.hpp"
    #include "magwells_8x56mmR.hpp"
    #include "magwells_9x39.hpp"
    #include "magwells_93x64.hpp"

    #include "magwells_3006.hpp"
    #include "magwells_300BLK.hpp"
    #include "magwells_300WM.hpp"
    #include "magwells_303B.hpp"
    #include "magwells_338LM.hpp"
    #include "magwells_338NM.hpp"
    #include "magwells_30Carbine.hpp"
    #include "magwells_408CT.hpp"
    #include "magwells_50BMG.hpp"

    // Pistol calibre magwells, ordered lexicographically in metric and imperial groups
    #include "magwells_10mmAuto.hpp"
    #include "magwells_57x28.hpp"
    #include "magwells_762x25.hpp"
    #include "magwells_762x38R.hpp"
    #include "magwells_763x25.hpp"
    #include "magwells_765x20Longue.hpp"
    #include "magwells_765x21.hpp"
    #include "magwells_8x22.hpp"
    #include "magwells_9x18.hpp"
    #include "magwells_9x19.hpp"
    #include "magwells_9x21.hpp"

    #include "magwells_22LR.hpp"
    #include "magwells_25ACP.hpp"
    #include "magwells_32ACP.hpp"
    #include "magwells_357Mag.hpp"
    #include "magwells_357SIG.hpp"
    #include "magwells_380ACP.hpp"
    #include "magwells_38Spec.hpp"
    #include "magwells_38_200.hpp"
    #include "magwells_40SW.hpp"
    #include "magwells_455W.hpp"
    #include "magwells_45ACP.hpp"
    #include "magwells_45GAP.hpp"

    // Shotgun calibre magwells, ordered lexicographically
    #include "magwells_10gauge.hpp"
    #include "magwells_12gauge.hpp"
    #include "magwells_16gauge.hpp"
    #include "magwells_20gauge.hpp"


    // Grenade/Flare Launchers, ordered lexicographically
    #include "magwells_35mm.hpp"
    #include "magwells_40mm.hpp"

    // AT and AA Launchers, ordered lexicographically

    class CBA_Bazooka {};                           // M1, M1A1 Bazooka
    class CBA_Panzerschreck {};                     // Panzerschreck RPzB 54
    class CBA_PIAT {};                              // PIAT
    class CBA_SMAW {};                              // Mk 153 Shoulder-Launched Multipurpose Assault Weapon
    class CBA_SMAW_Spotting_Rifle {};               // Mk 153 Shoulder-Launched Multipurpose Assault Weapon - Spotting Rifle

    class CBA_Carl_Gustaf {                         // MAAWS, RAWS
        BI_rounds[] = {
            "MRAWS_HEAT_F",
            "MRAWS_HE_F"
        };
    };

    class CBA_RPG7 {
        BI_rockets[] = {
            "RPG7_F"
        };
    };
};
