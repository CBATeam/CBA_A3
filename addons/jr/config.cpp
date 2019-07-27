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
        requiredAddons[] = {"cba_jr_prep"};
        version = VERSION;
        authors[] = {"Robalo"};
    };
};

#include "jr_classes.hpp"
#include "CfgWeapons.hpp"
#include "CfgFunctions.hpp"
