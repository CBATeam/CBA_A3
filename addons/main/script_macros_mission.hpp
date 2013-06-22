#include "\x\cba_a3\addons\main\script_macros_common.hpp"

/*
    Header: script_macros_mission.hpp
    
    Description:
        Modifies script_common_macros.hpp for compatiblity with missions.
        Some addon specific functionality might be lost.
    
    Authors:
        Muzzleflash
        
    Changes from script_macros_mission.hpp:
        Follows Standard:
            Object variables: PREFIX_COMPONENT
            Main-object variables: PREFIX_main
            Paths: PREFIX\COMPONENT\SCRIPTNAME.sqf
                Or if CUSTOM_FOLDER is defined:
                CUSTOM_FOLDER\SCRIPTNAME.sqf  
            eg. six\sys_menu\fDate.sqf

    Usage:
        Define PREFIX and COMPONENT, then include this file:
            #include "x\cba_a3\addons\main\script_macros_mission.hpp"
*/

// TODO: Alternate COMPILE_FILE macros that add e.g "mission\"

/************************** REMOVED ***********************/

#undef MAINPREFIX
#undef SUBPREFIX
#undef VERSION
#undef VERSION_AR
#undef VERSION_CONFIG

#undef MODULAR
#undef COMPONENT_T
#undef COMPONENT_M
#undef COMPONENT_S
#undef COMPONENT_C
#undef COMPONENT_F

// Missions should support paths without leading \
#undef PATHTO_SYS
#define PATHTO_SYS(var1,var2,var3) MAINPREFIX\##var1\SUBPREFIX\##var2\##var3.sqf

#undef PATHTOF2_SYS

#undef PATHTO_R
#undef PATHTO_T
#undef PATHTO_M
#undef PATHTO_S
#undef PATHTO_C
#undef PATHTO_F

#undef QPATHTO_R
#undef QPATHTO_T
#undef QPATHTO_M
#undef QPATHTO_S
#undef QPATHTO_C
#undef QPATHTO_F

#undef VERSIONING_SYS
#undef VERSIONING

#undef PRELOAD_ADDONS

#undef BWC_CONFIG

#undef XEH_DISABLED
#undef XEH_PRE_INIT
#undef XEH_PRE_CINIT
#undef XEH_PRE_SINIT
#undef XEH_POST_INIT
#undef XEH_POST_CINIT
#undef XEH_POST_SINIT

/************************** ADDED *************************/

/* 
    CUSTOM_FOLDER

    Custom folder to search for files in. Will not change variable names.
    Default is PREFIX\COMPONENT

    Example:
    #define CUSTOM_FOLDER MyPackage\ScriptA
*/

/************************ MODIFIED ************************/
//This saves redefinition
#define COMPONENT_F COMPONENT
/* of these macros
PATHTO
COMPILE_FILE
PREP
PREPMAIN
*/

#ifdef CUSTOM_FOLDER
    #define PATHTO_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
#else
    #define PATHTO_SYS(var1,var2,var3) ##var1\##var2\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##var1\##var2\##var3
#endif

