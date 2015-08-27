#define COMPONENT diagnostic
#include "\x\cba\addons\main\script_mod.hpp"

#define DEFAULT_LOGLEVEL_PAIRS [ \
    [CBA_LOGLEVEL_FATAL, "FATAL"], \
    [CBA_LOGLEVEL_ERROR, "ERROR"], \
    [CBA_LOGLEVEL_WARN, "WARN"], \
    [CBA_LOGLEVEL_INFO, "INFO"], \
    [CBA_LOGLEVEL_DEBUG, "DEBUG"], \
    [CBA_LOGLEVEL_TRACE, "TRACE"] \
]

#define INITIALIZE_LOGLEVELS if (!([GVAR(logLevels)] call CBA_fnc_isHash)) then { GVAR(logLevels) = [DEFAULT_LOGLEVEL_PAIRS] call CBA_fnc_hashCreate; }


#ifdef DEBUG_ENABLED_DIAGNOSTIC
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_DIAGNOSTIC
    #define DEBUG_SETTINGS DEBUG_SETTINGS_DIAGNOSTIC
#endif

#include "\x\cba\addons\main\script_macros.hpp"
