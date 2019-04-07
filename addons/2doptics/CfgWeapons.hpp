class asdg_OpticRail;
class asdg_OpticRail1913: asdg_OpticRail { // the "medium" rail, long enough to fit any optic, but not enough to attach a clip-on NVS in front of a long scope.
    class compatibleItems {
        GVAR(magnificationHelper_1) = 1; GVAR(magnificationHelper_2) = 1; GVAR(magnificationHelper_3) = 1; GVAR(magnificationHelper_4) = 1; GVAR(magnificationHelper_5) = 1;
        GVAR(magnificationHelper_6) = 1; GVAR(magnificationHelper_7) = 1; GVAR(magnificationHelper_8) = 1; GVAR(magnificationHelper_9) = 1; GVAR(magnificationHelper_10) = 1;
        GVAR(magnificationHelper_11) = 1; GVAR(magnificationHelper_12) = 1; GVAR(magnificationHelper_13) = 1; GVAR(magnificationHelper_14) = 1; GVAR(magnificationHelper_15) = 1;
        GVAR(magnificationHelper_16) = 1; GVAR(magnificationHelper_17) = 1; GVAR(magnificationHelper_18) = 1; GVAR(magnificationHelper_19) = 1; GVAR(magnificationHelper_20) = 1;
        GVAR(magnificationHelper_21) = 1; GVAR(magnificationHelper_22) = 1; GVAR(magnificationHelper_23) = 1; GVAR(magnificationHelper_24) = 1; GVAR(magnificationHelper_25) = 1;
    };
};

class CfgWeapons {
    class ItemCore;
    class InventoryOpticsItem_Base_F;

    class GVAR(magnificationHelper_1): ItemCore {
        scope = 1;
        displayName = "";
        picture = "\A3\Weapons_F\Data\clear_empty.paa";
        model = "\A3\Weapons_F\empty.p3d";
        weaponInfoType = "RscWeaponZeroing";

        class ItemInfo: InventoryOpticsItem_Base_F {
            mass = 0;
            opticType = 1;
            optics = 1;
            modelOptics = "\A3\Weapons_F\empty.p3d";

            class OpticsModes {
                class Scope {
                    opticsID = 1;
                    useModelOptics = 0;
                    opticsPPEffects[] = {"Default"};
                    opticsFlare = 0;
                    opticsDisablePeripherialVision = 0;
                    opticsZoomMin = "0.25";
                    opticsZoomMax = "0.25";
                    opticsZoomInit = "0.25";
                    memoryPointCamera = "opticView";
                    visionMode[] = {};
                    distanceZoomMin = 200;
                    distanceZoomMax = 200;
                    cameraDir = "";
                };
            };
        };
    };

    #define HELPER(x) class DOUBLES(GVAR(magnificationHelper),x): GVAR(magnificationHelper_1) {\
        class ItemInfo: ItemInfo {\
            class OpticsModes: OpticsModes {\
                class Scope: Scope {\
                    opticsZoomMin = QUOTE(0.25/x);\
                    opticsZoomMax = QUOTE(0.25/x);\
                    opticsZoomInit = QUOTE(0.25/x);\
                };\
            };\
        };\
    }

    HELPER(2);
    HELPER(3);
    HELPER(4);
    HELPER(5);
    HELPER(6);
    HELPER(7);
    HELPER(8);
    HELPER(9);
    HELPER(10);
    HELPER(11);
    HELPER(12);
    HELPER(13);
    HELPER(14);
    HELPER(15);
    HELPER(16);
    HELPER(17);
    HELPER(18);
    HELPER(19);
    HELPER(20);
    HELPER(21);
    HELPER(22);
    HELPER(23);
    HELPER(24);
    HELPER(25);
};
