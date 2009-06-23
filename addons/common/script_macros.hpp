#ifndef CBA_COMMON_SCRIPT_MACROS_INCLUDED
#define CBA_COMMON_SCRIPT_MACROS_INCLUDED

// COMPONET should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX cba
// TODO: Consider Mod-wide or Component-narrow versions (or both, depending on wishes!)
#define VERSION 0.01
// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.01
#include "script_macros_common.hpp"

#endif

// TODO: Evaluate location
//#define DEBUG_arrays
//#define DEBUG_common
//#define DEBUG_diagnostic
//#define DEBUG_events
//#define DEBUG_hashes
//#define DEBUG_main
//#define DEBUG_network
//#define DEBUG_string