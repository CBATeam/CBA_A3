class CfgFunctions {
    // replace broken vanilla function with a working one
    class A3_Bootcamp {
        class Inventory {
            class compatibleItems {
                file = QPATHTOF(fnc_compatibleItems.sqf);
            };
        };
    };
    class CBA {
        class Inventory {
            class compatibleItems {
                description = "Get list of compatible attachments for a weapon";
                file = QPATHTOF(fnc_compatibleItems.sqf);
                RECOMPILE;
            };
        };
    };
};
