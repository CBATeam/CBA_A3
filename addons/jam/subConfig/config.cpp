#include "\x\cba\addons\jam\script_component.hpp"
#undef COMPONENT
#define COMPONENT cba_jam_subConfig

class CfgPatches {
    class ADDON {
        author = "$STR_CBA_Author";
        name = CSTRING(component);
        url = "$STR_CBA_URL";
        units[] = {};
        weapons[] = {};
        magazines[] = {};
        ammo[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"cba_jam"};
        version = VERSION;
        authors[] = {"Robalo"};
    };
};


class CfgWeapons {
    class Rifle_Base_F;
    class UGL_F;
    class arifle_MX_Base_F: Rifle_Base_F {
        class GL_3GL_F: UGL_F {
            magazineWell[] += {"CBA_40mm_3GL","CBA_40mm_M203","CBA_40mm_EGLM"};
        };
    };
};
