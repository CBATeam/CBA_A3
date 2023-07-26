#include "\x\cba\addons\xeh\script_component.hpp"

// macro add a dummy cfgPatch
#define CBA_EE_PATCH_NOT_LOADED(NAME,CAUSE) \
class CfgPatches { \
    class DOUBLES(NAME,notLoaded) { \
        units[] = {}; \
        weapons[] = {}; \
        cba_not_loaded = CAUSE; \
    }; \
};
