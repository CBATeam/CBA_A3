#include "script_component.hpp"

#define private 0
#define protected 1
#define public 2

#define ReadAndWrite 0
#define ReadAndCreate 1
#define ReadOnly 2
#define ReadOnlyVerified 3

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jr_prep"};
        author = "$STR_CBA_Author";
        authors[] = {"Robalo"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "jr_classes.hpp"
#include "CfgWeapons.hpp"
#include "CfgFunctions.hpp"
