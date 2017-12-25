#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
            "CBA_common",
            "A3_Missions_F",
            "A3_Missions_F_Beta",
            "A3_Missions_F_Gamma",
            "A3_Missions_F_EPA",
            "A3_Missions_F_EPB",
            "A3_Missions_F_EPC",
            "A3_Missions_F_Curator",
            "A3_Missions_F_Kart",
            "A3_Missions_F_Bootcamp",
            "A3_Missions_F_Heli",
            "A3_Missions_F_Mark",
            "A3_Missions_F_MP_Mark",
            "A3_Missions_F_Exp_A",
            "A3_Missions_F_Exp",
            "A3_Missions_F_Jets",
            "A3_Missions_F_Patrol",
            "A3_Missions_F_Orange",
            "A3_Missions_F_Tacops"
        };
        version = VERSION;
        authors[] = {"commy2"};
    };
};

class CfgMissions {
    delete MPMissions;
};
