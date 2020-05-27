#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "$STR_CBA_Author";
        authors[] = {"Kex"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;

        // This prevents any patched class from requiring this addon
        addonRootClass = "A3_Characters_F";
    };
};

#include "CfgEditorSubcategories.hpp"
#include "CfgVehicles.hpp"
