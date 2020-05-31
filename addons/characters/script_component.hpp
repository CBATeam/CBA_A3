#define COMPONENT characters
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_CHARACTERS
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_CHARACTERS
    #define DEBUG_SETTINGS DEBUG_SETTINGS_CHARACTERS
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define UNLOCK_MALARIA_INFECTED_CIVILIAN\
    author = "$STR_A3_Bohemia_Interactive";\
    scope = 2;\
    scopeCurator = 2;\
    editorSubcategory = QGVARMAIN(EdSubcat_Personnel_MalariaInfected)
