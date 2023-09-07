#include "\x\cba\addons\main\script_macros_common.hpp"

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
            #include "\x\cba\addons\main\script_macros_mission.hpp"

*/

/*
    CUSTOM_FOLDER

    Custom folder to search for files in. Will not change variable names.
    Default is PREFIX\COMPONENT

    Example:
        (begin example)
            #define CUSTOM_FOLDER MyPackage\ScriptA
        (end)

        (begin example)
            #define CUSTOM_FOLDER COMPONENT\functions
        (end)


*/

#undef PATHTO_SYS
#undef PATHTOF_SYS
#undef PATHTOF2_SYS
#ifdef CUSTOM_FOLDER
    #define PATHTO_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##CUSTOM_FOLDER\##var3
#else
    #define PATHTO_SYS(var1,var2,var3) ##var1\##var2\##var3.sqf
    #define PATHTOF_SYS(var1,var2,var3) ##var1\##var2\##var3
    #define PATHTOF2_SYS(var1,var2,var3) ##var1\##var2\##var3
#endif

/************************** REMOVAL OF MACROS ***********************/

#undef MAINPREFIX
#undef SUBPREFIX
#undef VERSION_AR
#undef VERSION_CONFIG

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

#undef PATHTO_FNC
#define PATHTO_FNC(func) class func {\
    file = QUOTE(DOUBLES(fnc,func).sqf);\
    RECOMPILE;\
}
