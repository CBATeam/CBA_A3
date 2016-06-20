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
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Weapons_F","A3_Weapons_F_Mark","A3_Weapons_F_Exp","CBA_jr_prep"};
        version = VERSION;
        authors[] = {"Robalo"};
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

#include "jr_classes.hpp"
#include "cfgweapons.hpp"
#include "CfgFunctions.hpp"
