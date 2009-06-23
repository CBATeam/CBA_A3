#ifndef CBA_COMMON_SCRIPT_COMPONENT_INCLUDED
#define CBA_COMMON_SCRIPT_COMPONENT_INCLUDED

#define COMPONENT common
#include "\x\cba\addons\main\script_macros.hpp"

#endif

#ifdef DEBUG_COMMON
	#define DEBUG
#endif

#ifdef DEBUGSETTINGS_COMMON
	#define DEBUGSETTINGS DEBUGSETTINGS_COMMON
#endif
#ifndef DEBUGSETTINGS_COMMON
	#define DEBUGSETTINGS DEFAULT_DEBUGSETTINGS
#endif
