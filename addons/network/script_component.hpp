#define COMPONENT network
#include "\x\cba\addons\main\script_mod.hpp"

#ifdef DEBUG_ENABLED_NETWORK
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_NETWORK
    #define DEBUG_SETTINGS DEBUG_SETTINGS_NETWORK
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define CBA_SEND_TO_ALL -2
#define CBA_SEND_TO_CLIENTS_ONLY -1
#define CBA_SEND_TO_SERVER_ONLY 0

#define BI_SEND_TO_ALL 0
#define BI_SEND_TO_CLIENTS_ONLY -2
#define BI_SEND_TO_SERVER_ONLY 2
