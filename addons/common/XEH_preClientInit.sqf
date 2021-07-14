#include "script_component.hpp"

LOG(MSG_INIT);

if (hasInterface) then {
    // ArmA - actionmonitor.sqf v1.0 Original by BN880, converted by Sickboy (sb_at_dev-heaven.net), 6th Sense - Share the Spirit
    GVAR(actionList) = createHashMap;
    GVAR(actionListUpdated) = false; // Set true to force recreation of actions.
    GVAR(nextActionIndex) = 0; // Next index that will be given out.
    GVAR(actionListPFEH) = false;

    call COMPILE_FILE(init_addMiscItemsToArsenal); // Add CBA_MiscItems to VirtualArsenal
};
