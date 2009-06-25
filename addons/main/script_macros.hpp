#ifndef CBA_MAIN_SCRIPT_MACROS_INCLUDED
#define CBA_MAIN_SCRIPT_MACROS_INCLUDED

// COMPONET should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX CBA
// TODO: Consider Mod-wide or Component-narrow versions (or both, depending on wishes!)
#define VERSION 0.01
// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.01

// Set a default debug mode for the addon.
#ifndef DEBUG_MODE_OFF
#ifndef DEBUG_MODE_MINIMAL
#undef DEBUG_MODE_NORMAL
#define DEBUG_MODE_NORMAL
#endif
#endif

#include "script_macros_common.hpp"

#endif // CBA_MAIN_SCRIPT_MACROS_INCLUDED

// TODO: Evaluate location
//#define DEBUG_arrays
//#define DEBUG_common
//#define DEBUG_diagnostic
//#define DEBUG_events
//#define DEBUG_hashes
//#define DEBUG_main
//#define DEBUG_network
//#define DEBUG_string