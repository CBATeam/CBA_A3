#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        name = CSTRING(component);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "cba_jr",
            "gm_weapons_attachments_optics_feroz24",
            "gm_weapons_attachments_optics_c79",
            "gm_weapons_attachments_optics_lsscope",
            "gm_weapons_attachments_optics_lightscope",
            "gm_weapons_attachments_optics_rv",
            "gm_weapons_attachments_optics_zf10x42",
            "gm_weapons_attachments_optics_nspu",
            "gm_weapons_attachments_optics_pgo7",
            "gm_weapons_attachments_optics_pka",
            "gm_weapons_attachments_optics_zfk4x25",
            "gm_weapons_attachments_optics_zln1k",
            "gm_weapons_attachments_optics_pso1"
        };
        author = "$STR_CBA_Author";
        authors[] = {};
        url = "$STR_CBA_URL";
        skipWhenMissingDependencies = 1;
        VERSION_CONFIG;
    };
};

#include "jr_classes.hpp"
