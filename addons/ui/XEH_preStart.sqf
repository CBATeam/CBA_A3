#include "script_component.hpp"

#include "XEH_PREP.sqf"

if (hasInterface) then {
    PREP(initDisplayInterrupt);
    PREP(initDisplayMultiplayerSetup);
    PREP(initDisplayOptionsLayout);
    PREP(initDisplayPassword);
    PREP(initDisplayRemoteMissions);
    PREP(initDisplayDiary);
    PREP(initDisplay3DEN);
    PREP(initDisplayCurator);
    PREP(initDisplayMessageBox);
    PREP(initDisplayInventory);

    PREP(preload3DEN);
    PREP(preloadCurator);

    PREP(openItemContextMenu);
};
