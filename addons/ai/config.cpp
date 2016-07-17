#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common","A3_3DEN"};
        version = VERSION;
        authors[] = {"Rommel"};
    };
};

#include "Cfg3DEN.hpp"
#include "CfgFunctions.hpp"
#include "CfgWaypoints.hpp"
