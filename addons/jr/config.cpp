#include "script_component.hpp"

#define private 0       // hidden
#define protected 1     // hidden but usable
#define public 2        // visible

#define ReadAndWrite 0      //! any modifications enabled
#define ReadAndCreate 1     //! only adding new class members is allowed
#define ReadOnly 2          //! no modifications enabled
#define ReadOnlyVerified 3  //! no modifications enabled, CRC test applied

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark","CBA_jr_prep"};
        version = VERSION;
        author[] = {"Robalo"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
    class asdg_jointrails { //compat
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark"};
    };
    class asdg_jointmuzzles { //compat
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark"};
    };
};

class CfgFunctions {
    class CBA {
        class JR {
            class compatibleItems {
                description = "Get list of compatible attachments for a weapon";
                file = QUOTE(PATHTOF(fnc_compatibleItems.sqf));
            };
        };
    };
};

#include "jr_classes.hpp"
#include "cfgweapons.hpp"
