class CfgMagazineWells {

    // Rifle calibre magwells, ordered lexicographically in metric and imperial groups
    #include "magwells_11x59R.hpp"      // 11x59mmR Gras | 11mm Vickers
    #include "magwells_145x114.hpp"     // 14.5x114mm
    #include "magwells_545x39.hpp"      // 5.45x39mm
    #include "magwells_556x45.hpp"      // 5.56x45mm | .223
    #include "magwells_580x42.hpp"      // 5.8x42mm
    #include "magwells_65C.hpp"         // 6.5mm Creedmoor | 6.5 Creedmoor | 6,5 Creedmoor | 6.5 CM | 6.5 CRDMR
    #include "magwells_65G.hpp"         // 6.5mm Grendel | 6.5x39mm Grendel
    #include "magwells_65x39.hpp"       // 6.5x39mm Caseless
    #include "magwells_68SPC.hpp"       // 6.8mm Remington SPC | 6.8 SPC | 6.8x43mm
    #include "magwells_75x55.hpp"       // 7.5x55mm Swiss | 7.5x55mm Schmidt–Rubin
    #include "magwells_762x39.hpp"      // 7.62x39mm | 7.62 Soviet | .30 Russian Short
    #include "magwells_762x51.hpp"      // 7.62x51mm | .308
    #include "magwells_762x54.hpp"      // 7.62x54mmR
    #include "magwells_77x58.hpp"       // 7.7x58mm Arisaka | Type 99 rimless 7.7 mm | 7.7mm Japanese
    #include "magwells_792x33.hpp"      // 7.92x33mm Kurz | 7.92 x 33 kurz | 7.9mm Kurz | 7.9 Kurz | 7.9mmK | 8x33 Polte
    #include "magwells_792x57.hpp"      // 7.92x57mm Mauser | 8mm Mauser | 8x57mm | 8 x 57 IS
    #include "magwells_9x39.hpp"        // 9x39mm

    #include "magwells_3006.hpp"        // .30-06 Springfield | 7.62x63mm
    #include "magwells_300BLK.hpp"      // .300 AAC Blackout | 300 BLK | .300 Blackout | 7.62x35mm
    #include "magwells_300WM.hpp"       // .300 Winchester Magnum | .300 Win Mag | 300WM
    #include "magwells_303B.hpp"        // .303 British | 7.7x56mmR
    #include "magwells_338LM.hpp"       // .338 Lapua Magnum
    #include "magwells_408CT.hpp"       // .408 Cheyenne Tactical | 408 Chey Tac | 10.36x77mm
    #include "magwells_50BMG.hpp"       // .50 BMG | .50 Browning Machine Gun | 12.7x99mm NATO

    // Pistol calibre magwells, ordered lexicographically in metric and imperial groups
    #include "magwells_10mmAuto.hpp"    // 10mm Auto | 10mm Automatic | 10x25mm
    #include "magwells_762x25.hpp"      // 7.62x25mm Tokarev
    #include "magwells_762x38R.hpp"     // 7.62x38mmR | 7.62 mm Nagant
    #include "magwells_763x25.hpp"      // 7.63x25mm Mauser | .30 Mauser Automatic
    #include "magwells_765x21.hpp"      // 7.65x21mm Parabellum | 7,65 Parabellum | 7.65mm Luger | .30 Luger
    #include "magwells_8x22.hpp"        // 8x22mm Nambu
    #include "magwells_9x18.hpp"        // 9x18mm Makarov | 9mm Makarov | 9x18mm PM
    #include "magwells_9x19.hpp"        // 9x19mm Parabellum | 9mm Luger
    #include "magwells_9x21.hpp"        // 9x21mm IMI | 9x21mm Gyurza

    #include "magwells_22LR.hpp"        // .22 LR | .22 Long Rifle | 5.6x15mmR
    #include "magwells_32ACP.hpp"       // .32 ACP | .32 Automatic | 7.65x17mmSR Browning | 7.65 mm Browning Short
    #include "magwells_357Mag.hpp"      // .375 Magnum | .357 S&W Magnum | 9x33mmR
    #include "magwells_357SIG.hpp"      // .357 SIG
    #include "magwells_380ACP.hpp"      // .380 ACP | .380 Auto | 9mm Browning | 9mm Corto | 9mm Kurz | 9mm Short | 9x17mm | 9 mm Browning Court
    #include "magwells_38Spec.hpp"      // .38 Smith & Wesson Special | .38 Special | .38 Spl | .38 Spc | 9x29.5mmR | 9.1x29mmR
    #include "magwells_38_200.hpp"      // .38/200 | 9x20mmR
    #include "magwells_40SW.hpp"        // .40 S&W
    #include "magwells_455W.hpp"        // .455 Webley | .455 Eley | .455 Colt
    #include "magwells_45ACP.hpp"       // .45 ACP | .45 Automatic Colt Pistol | .45 Auto | 11.43x23mm
    #include "magwells_45GAP.hpp"       // .45 GAP | .45 "GAP" | .45 Glock Auto Pistol

    // Shotgun calibre magwells, ordered lexicographically
    #include "magwells_10gauge.hpp"     // 10 Gauge
    #include "magwells_12gauge.hpp"     // 12 Gauge
    #include "magwells_16gauge.hpp"     // 16 Gauge
    #include "magwells_20gauge.hpp"     // 20 Gauge


    // Grenade/Flare Launchers, ordered lexicographically
    #include "magwells_35mm.hpp"
    #include "magwells_40mm.hpp"

    // AT and AA Launchers, ordered lexicographically
    class CBA_Bazooka {};       // M1, M1A1 Bazooka
    class CBA_Panzerschreck {}; // Panzerschreck RPzB 54
    class CBA_PIAT {};          // PIAT

    class CBA_RPG7 {
        BI_rockets[] = {
            "RPG7_F"
        };
    };
};
