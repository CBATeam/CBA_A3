// COMPONENT should be defined in the script_component.hpp and included BEFORE this hpp
#define PREFIX cba
// TODO: Consider Mod-wide or Component-narrow versions (or both, depending on wishes!)
#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0
#define BUILD 6

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD


// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.0

/*
// Defined DEBUG_MODE_NORMAL in a few CBA_fncs to prevent looped logging :)
#ifndef DEBUG_MODE_NORMAL
    #define DEBUG_MODE_FULL
#endif
*/

// Set a default debug mode for the component here (See documentation on how to default to each of the modes).
/*
*/
