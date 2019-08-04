#include "script_component.hpp"

class CfgPatches {
    class cba_ee {
        requiredAddons[] = {"cba_xeh"};
        units[] = {};
    };
};

class CfgVehicles {
    class B_W_Soldier_F;
    class B_W_Story_Protagonist_01_F: B_W_Soldier_F {
        XEH_ENABLED;
        scope = "1 + parseNumber isClass (configFile >> 'CfgPatches' >> 'A3_Data_F_Contact')"; // Inherits from a public base class. Downgrade to protected if Contact component is not loaded.
    };
    class B_W_Story_Major_01_F: B_W_Soldier_F {
        XEH_ENABLED;
        scope = "1 + parseNumber isClass (configFile >> 'CfgPatches' >> 'A3_Data_F_Contact')";
    };
    class B_W_Story_Instructor_01_F: B_W_Soldier_F {
        XEH_ENABLED;
        scope = "1 + parseNumber isClass (configFile >> 'CfgPatches' >> 'A3_Data_F_Contact')";
    };
    class B_W_Story_Soldier_01_F: B_W_Soldier_F {
        XEH_ENABLED;
        scope = "1 + parseNumber isClass (configFile >> 'CfgPatches' >> 'A3_Data_F_Contact')";
    };
    class B_W_Story_Leader_01_F: B_W_Soldier_F {
        XEH_ENABLED;
        scope = "1 + parseNumber isClass (configFile >> 'CfgPatches' >> 'A3_Data_F_Contact')";
    };
};
