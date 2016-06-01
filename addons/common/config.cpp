#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_BaseConfig_F"};
        version = VERSION;
        author = "$STR_CBA_Author";
        authors[] = {"Spooner","Sickboy","Rocko"};
        authorUrl = "https://github.com/CBATeam/CBA_A3";
    };
};

#include "CfgEventHandlers.hpp"
#include "CfgFunctions.hpp"
#include "CfgLocationTypes.hpp"

class CBA_DirectCall {
    class dummy;
};
