#define COMPONENT common
#include "\x\cba\addons\main\script_mod.hpp"


#ifdef DEBUG_ENABLED_COMMON
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COMMON
    #define DEBUG_SETTINGS DEBUG_SETTINGS_COMMON
#endif

#include "\x\cba\addons\main\script_macros.hpp"

#define DUMMY_POSITION [-1000, -1000, 0]

#define YEAR(x) class Number##x {\
    name = QUOTE(x);\
    value = x;\
}

// Zero delay per frame handlers live in their own array so they never pay for an ETA check.
// Which array a handle points at is encoded in the sign of its stored index: non negative
// indexes the delayed array, negative indexes the zero delay one.
#define PFH_EACHFRAME_ENCODE(idx) (-(idx) - 1)
#define PFH_EACHFRAME_DECODE(val) (-(val) - 1)
#define PFH_IS_EACHFRAME(val) ((val) < 0)
