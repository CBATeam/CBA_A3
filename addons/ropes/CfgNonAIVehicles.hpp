class CfgNonAIVehicles {
    class RopeSegment {
        model = QPATHTOF(rope.p3d);

        hiddenSelections[] = {"zbytek"};
        hiddenSelectionsTextures[] = {"#(argb,8,8,3)color(1,0,0,1,co)"}; //"a3\data_f\proxies\rope\data\rope_co.paa"

        class EventHandlers {
            init = "systemChat str [_this]; diag_log [_this];";
        };
    };
};
