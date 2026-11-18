#include "script_component.hpp"

// Class name of the music that is currently playing, "" if none.
// Updated by the music event handlers added in postInit (music event handlers added in preInit don't survive the mission start).
GVAR(playing) = "";
