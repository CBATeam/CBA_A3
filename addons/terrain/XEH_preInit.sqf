#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;
#include "XEH_PREP.sqf"

GVAR(terrainChunks) = createHashMap;
GVAR(originalTerrainChunks) = createHashMap;

ADDON = true;
