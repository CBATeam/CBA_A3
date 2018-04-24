#include "script_component.hpp"

LOG(MSG_INIT);

call COMPILE_FILE(flexiMenu\init);

// recreate after loading a savegame
addMissionEventHandler ["Loaded", {
    if (!isNil QGVAR(ProgressBarParams)) then {
        QGVAR(ProgressBar) cutRsc [QGVAR(ProgressBar), "PLAIN"];
    };
}];
