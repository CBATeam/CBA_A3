#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { "cba_common" };
        version = VERSION;
        author[] = { "MikeMatrix" };
        authorUrl = "http://dev-heaven.net/projects/cca";
    };
};

#include "CfgFunctions.hpp"
