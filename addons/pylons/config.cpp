#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = CSTRING(component);
        units[] = {
            QGVAR(camera_tgp),
            QGVAR(camera_turret),
            QGVAR(camera_fixed),
            QGVAR(pylon_single_tgp),
            QGVAR(pylon_single_turret),
            QGVAR(pylon_single_fixed),
            QGVAR(pylon_turret),
            QGVAR(pylon_turret_tgp)
        };
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_common"};
        author = "$STR_CBA_Author";
        authors[] = {"Ampersand"};
        url = "$STR_CBA_URL";
        VERSION_CONFIG;
    };
};

#include "CfgAmmo.hpp"
#include "CfgEditorSubcategories.hpp"
#include "CfgEventHandlers.hpp"
#include "CfgMagazines.hpp"
#include "CfgNonAIVehicles.hpp"
#include "CfgVehicles.hpp"
#include "CfgWeapons.hpp"
