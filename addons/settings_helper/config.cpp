// the purpose of this PBO is to set a default file to the following path:
// userconfig/cba/settings.sqf
// this way we effectively make the file optional, as the loadFile command
// can fall back to this empty default file

#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = ECSTRING(settings,component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {};
        version = VERSION;
    };
};
