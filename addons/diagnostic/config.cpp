#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"CBA_common","CBA_events","3DEN"};
        version = VERSION;
        author[] = {"Spooner","Sickboy"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

#include "CfgFunctions.hpp"
#include "CfgEventHandlers.hpp"

#include "CfgDisplay3DEN.hpp"
