#define COMPONENT log
#include "\x\cba\addons\main\script_mod.hpp"

#define INITIALIZE_LOGLEVELDESCRIPTORS if (isNil QGVAR(logLevelDescriptors)) then {GVAR(logLevelDescriptors) = [[CBA_LOGLEVEL_TRACE, CBA_LOGLEVEL_DEBUG, CBA_LOGLEVEL_INFO, CBA_LOGLEVEL_WARN, CBA_LOGLEVEL_ERROR, CBA_LOGLEVEL_FATAL], ["TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL"]]}

#ifdef DEBUG_ENABLED_LOG
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_LOG
    #define DEBUG_SETTINGS DEBUG_SETTINGS_LOG
#endif

#include "\x\cba\addons\main\script_macros.hpp"
