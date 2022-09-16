#include "script_component.hpp"
SCRIPT(XEH_preInit);

ADDON = false;
#include "XEH_PREP.sqf"

GVAR(modifiedTerrainChunks) = createHashMap;
GVAR(originalTerrainChunks) = createHashMap;

if !(isMultiplayer) then {
    addMissionEventHandler ["Loaded", {
        {
            setTerrainHeight _y;
        } forEach GVAR(modifiedTerrainChunks);
    }];
};

ADDON = true;
